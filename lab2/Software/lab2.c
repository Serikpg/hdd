#include "address_map_arm.h"
#include <stdio.h>
#define COUNT28_BASE_ADDRESS 0xFF200020

#define BOOTH_BASE_ADDRESS 0xFF200000
#define DATA_A_ADDRESS 0xFF200000
#define DATA_B_ADDRESS 0xFF200004
#define RESULT_ADDRESS 0xFF200008
#define STATUS_ADDRESS 0xFF20000C

void set_A9_IRQ_stack(void);
void config_GIC(void);
void config_KEYs(void);
void enable_A9_interrupts(void);
/* key_pressed and pattern is written by an interrupt service routines; we have to
 * declare these as volatile to avoid the compiler caching their values in
 * registers */
volatile int key_pressed = 1;
volatile int received = 0;
volatile int res = 0;

/* ********************************************************************************
 * This program demonstrates use of interrupts with C code. 
 
 * Initially the value of the switches is represented on the LEDs
 
 * Each time any of the Pushbuttons is pressed the value of variable key_pressed
 * is changed. When the value of this variabl is 0 the value of the switches
 * is represented on the LEDs. When its value is 1 the value of the switches is 
 * represented on the LEDs, but LED9 is ON independently of the value establiched
 * in the switches
********************************************************************************/
int main(void)
{

    //volatile int *leds = (int *)LEDR_BASE;
    //volatile int *count28_enable = (int *)COUNT28_BASE_ADDRESS;
    volatile int *status = (int *)STATUS_ADDRESS;
    volatile int *data_a_ptr = (int *)DATA_A_ADDRESS;
    volatile int *data_b_ptr = (int *)DATA_B_ADDRESS; 

    set_A9_IRQ_stack();      // initialize the stack pointer for IRQ mode
    config_GIC();            // configure the general interrupt controller

    config_KEYs();           // configure pushbutton KEYs to generate interrupts

    enable_A9_interrupts(); // enable interrupts
    
    printf("\nProgram starts...\n");

    while (1)
    {
        printf("status: %d\n", *status);
        while (*status & 0x2) {};
        // before entering the main loop we must be sure there are no pending interrupts
        *status = (*status | 0x4); // set ack 1
        *status = (*status ^ 0x4); // set ack 0

        // printf("busy is not active\n");
        scanf("%d", data_a_ptr);
        scanf("%d", data_b_ptr); 

        // printf("a read: %d    b read: %d\n", *data_a_ptr, *data_b_ptr);

        *status = 0x9; // set start to 1
        // *status |= 0x1;
        printf("start set to 1\n");
        while (!received) {}; // if ISR notifies us new value has come
        printf("status read: %d\n", *status);
        received = 0;
        printf("value has been received\n");
        printf("result is: %d\n", res); // print out the mulltiplication result
    }
}

/* setup the KEY interrupts in the FPGA */
void config_KEYs()
{
    // volatile int * KEY_ptr = (int *)KEY_BASE; // pushbutton KEY address
    // *(KEY_ptr + 2) = 0x1; // enables interrupts for all pushbuttons

    // we can reuse this config_KEYs function to enable the
    // interrupts of the booth multiplier source
    volatile int * status = (int *)STATUS_ADDRESS;
    *status = 0x8; // slv_reg3(3) = 1'b1
}

