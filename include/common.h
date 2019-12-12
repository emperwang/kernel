#ifndef INCLUDE_COMMON_H_
#define INCLUDE_CONNON_H_

#include "types.h"

// write byte to port 
void outb(uint16_t port, uint8_t value);

// read byte from port
uint8_t inb(uint16_t prot);

// read word from port
uint16_t inw(uint16_t port);

#endif