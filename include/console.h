#ifndef INCLUDE_CONSOLE_H_
#define INCLUDE_CONSOLE_H_

#include "types.h"

typedef
enum real_color {
    rc_black = 0,
    rc_blue = 1,
    rc_green = 2,
    rc_cyan = 3,
    rc_red = 4,
    rc_magenta = 5,
    rc_brown = 6,
    rc_light_grey = 7,
    rc_drak_grey = 8,
    rc_light_blue = 9,
    rc_light_green = 10,
    rc_light_cyan = 11,
    rc_light_red = 12,
    rc_light_magenta = 13,
    rc_light_brown = 14,
    rc_white = 15

} real_color_t;

// clear screen
void console_clear();

// print a char with color
void console_putc_color(char c, real_color_t back, real_color_t fore);

// print a string end with \0
void console_write(char *cstr);

// print string end with \0, and with color
void console_write_color(char *cstr, real_color_t back, real_color_t fore);

// print hes num
void console_write_hex(uint32_t n, real_color_t back, real_color_t fore);

// 打印十进制数
void console_write_dec(uint32_t n, real_color_t back, real_color_t fore);

#endif