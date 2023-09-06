#pragma once

#include "../Standard/Types.h"
#include "../Standard/String.h"
#include "../Standard/Point.h"

namespace Arkn
{
    class TextRenderer
    {
    public:
        static void WriteCharacter(uint8_t c, uint8_t forecolour, uint8_t backcolour, Arkn::Point point);
        static void WriteString(const Arkn::String& string, Arkn::Point point);
    };
}
