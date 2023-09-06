#pragma once

#include "Types.h"

namespace Arkn
{
    class IO
    {
    public:
        static inline void Outb(uint16_t port, uint8_t val)
        {
            asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) :"memory");
        }

        static inline uint8_t Inb(uint16_t port)
        {
            uint8_t ret;
            asm volatile ( "inb %1, %0"
                        : "=a"(ret)
                        : "Nd"(port)
                        : "memory");
            return ret;
        }
    };
}