#include "TextRenderer.h"

// Static public functions

void Arkn::TextRenderer::WriteCharacter(uint8_t c, uint8_t forecolour, uint8_t backcolour, Arkn::Point point)
{
    uint16_t attrib = (backcolour << 4) | (forecolour & 0x0F);
    volatile uint16_t * where;
    where = (volatile uint16_t *)0xB8000 + (point.y * 80 + point.x) ;
    *where = c | (attrib << 8);
}

void Arkn::TextRenderer::WriteString(const Arkn::String& string, Arkn::Point point)
{
    for(size_t i = 0; i < string.GetSize(); i++)
    {
        Arkn::TextRenderer::WriteCharacter(string[i], 15, 0, point);
        point.x += 1;
    }
}