#pragma once

#include "Types.h"

namespace Arkn
{
    class Point
    {
    public:
        uint32_t x, y;

        Point(uint32_t x, uint32_t y)
        {
            this->x = x; 
            this->y = y;
        }
    };
}