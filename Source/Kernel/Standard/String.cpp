#include "String.h"

Arkn::String::String(const char* string)
{
    for(size_t i = 0; string[i] != 0; i++)
    {
        this->m_size = i;
    }
    this->m_size++;
    this->m_str = string;
}

char Arkn::String::operator[](uint32_t idx) const
{
    return this->m_str[idx];
}