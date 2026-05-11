#include "address_map_arm.h"
#include <stdio.h>

#define BOOTH_BASE_ADDRESS 0xFF200000
#define DATA_A_ADDRESS 0xFF200000
#define DATA_B_ADDRESS 0xFF200004
#define RESULT_ADDRESS 0xFF200008
#define STATUS_ADDRESS 0xFF20000C

extern volatile int key_pressed;
extern volatile int received;
extern volatile int res;

/***************************************************************************************
 * Pushbutton - Interrupt Service Routine
 *
 * This routine toggles the key_dir variable from 0 <-> 1
****************************************************************************************/
void pushbutton_ISR(void)
{
    volatile int * KEY_ptr = (int *)KEY_BASE;
    int            press;

    press          = *(KEY_ptr + 3); // read the pushbutton interrupt register
    *(KEY_ptr + 3) = press;          // Clear the interrupt

    key_pressed ^= 1; // Toggle key_pressed value

    return;
}

void booth_ISR()
{
    // printf("entering the booth ISR\n");
    // 1st we must clear the interrupt by writing a value 1 and then 0
    // to bit slv_reg3(2) "ACK"
    volatile int * status = (int *)STATUS_ADDRESS;
    volatile int * resultpt = (int *)RESULT_ADDRESS;
    *status = (*status & 0xE); // set start to 0
    *status = (*status | 0x4); // set ack to 1
    received = 1;
    res = *resultpt;
    *status = (*status & 0xB); // set ack to 0

    // store the contents of the result before allowing unblock

    // a global flag should be set to let the application know that an
    // interrupt comming from the multiplier has been received

    return;
}
