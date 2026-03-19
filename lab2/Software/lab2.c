#include "address_map_arm.h"
#include <stdio.h>
#define COUNT28_BASE_ADDRESS 0xFF200020

void set_A9_IRQ_stack(void);
void config_GIC(void);
void config_KEYs(void);
void enable_A9_interrupts(void);
/* key_pressed and pattern is written by an interrupt service routines; we have to
 * declare these as volatile to avoid the compiler caching their values in
 * registers */
volatile int key_pressed = 1;

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
    volatile int *count28_enable = (int *)COUNT28_BASE_ADDRESS;

    set_A9_IRQ_stack();      // initialize the stack pointer for IRQ mode
    config_GIC();            // configure the general interrupt controller

    config_KEYs();           // configure pushbutton KEYs to generate interrupts

    enable_A9_interrupts(); // enable interrupts
    
    printf("\nProgram starts...\n");
    
 

    while (1)
    {
    	*count28_enable = key_pressed;      
    }
}

/* setup the KEY interrupts in the FPGA */
void config_KEYs()
{
    volatile int * KEY_ptr = (int *)KEY_BASE; // pushbutton KEY address

    *(KEY_ptr + 2) = 0x1; // enables interrupts for all pushbuttons
}
