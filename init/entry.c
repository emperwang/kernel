#include "console.h"

int kern_entry(){

    conole_test();

    return 0;
}

void conole_test(){
    console_clear();

    console_write_color("Hello, 0s kernel!\n",rc_black, rc_green);
}

void firstDemo(){
    uint8_t  *input = (uint8_t *)0xB8000;
    uint8_t  color = (0 << 4) | (15 & 0x0F);

    *input++ = 'H'; *input++ = color;
    *input++ = 'e'; *input++ = color;
    *input++ = 'l'; *input++ = color;
    *input++ = 'l'; *input++ = color;
    *input++ = 'o'; *input++ = color;
    *input++ = ','; *input++ = color;
    *input++ = 'O'; *input++ = color;
    *input++ = 'S'; *input++ = color;
}