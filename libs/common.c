#include "common.h"

// 端口写一个字节
inline void outb(uint16_t port, uint8_t value){
    
    asm volatile ("outb %1, %0" : : "dN" (port), "a" (value));
}

// 端口读取一个字节
inline uint8_t inb(uint16_t prot){
    uint8_t ret;

    asm volatile("inb %1, %0" : "=a" (ret) : "dN" (prot));

    return ret;
}

// 读取一个word
inline uint16_t inw(uint16_t port){
    uint16_t ret;

    asm volatile("inw %1, %0" : "=a" (ret) : "dN" (port));
    return ret;
}