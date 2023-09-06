#pragma once

#include "../Standard/Types.h"
#include "../Standard/String.h"
#include "../Standard/Point.h"
#include "../Standard/Error.h"

namespace Arkn
{
    class TextRenderer
    {
    private:
        static uint32_t s_current_line_pos_y;
    public:
        static void WriteCharacter(uint8_t c, uint8_t forecolour, uint8_t backcolour, Arkn::Point point);
        static void WriteString(const Arkn::String& string, Arkn::Point point);
        static void WriteLine(const Arkn::String& string);
    };
}
