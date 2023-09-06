#include "String.h"
#include "../TextRenderer/TextRenderer.h"

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

// Static functions

void Arkn::String::StringCopy(char dest[], const char src[])
{
    size_t i = 0;
    while (1)
    {
        dest[i] = src[i];
        if (dest[i] == '\0')
        {
            break;
        }
        i++;
    } 
}