#pragma once

#include "Types.h"

namespace Arkn
{
    class String
    {
    private:
        uint32_t m_size;
        const char* m_str;

    public:
        String(const char* str);

        char operator[](uint32_t idx) const;

        uint32_t GetSize() const { return this->m_size;} 
    };
}