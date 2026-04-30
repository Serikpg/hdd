#include "address_map_arm.h"

#define BOOTH_BASE_ADDRESS 0xFF200000
#define DATA_A_ADDRESS ( BOOTH_BASE_ADDRESS + 0x0 )
#define DATA_B_ADDRESS ( BOOTH_BASE_ADDRESS + 0x4 )
#define RESULT_ADDRESS ( BOOTH_BASE_ADDRESS + 0x8 )
#define STATUS_ADDRESS ( BOOTH_BASE_ADDRESS + 0xC )

extern volatile int key_pressed;

extern volatile int received;
extern volatile int value_received;

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
    // 1st we must clear the interrupt by writing a value 1 and then 0
    // to bit slv_reg3(2) "ACK"
    volatile int * status = (int *)STATUS_ADDRESS;
    volatile int * value  = (int *)RESULT_ADDRESS;
    *status = (*status | 0x2); // set ack to 1

    // store the contents of the result before allowing unblock
    value_received = *value;
    received = 1;

    *status = (*status ^ 0x2); // set ack to 0
    *status = (*status & 0xE); // set start to 0

    // a global flag should be set to let the application know that an
    // interrupt comming from the multiplier has been received

    return;
}
