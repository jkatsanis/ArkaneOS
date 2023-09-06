#pragma once

#include "../Standard/Types.h"

class TextRenderer
{
public:
    void WriteCharacter(unsigned char c, unsigned char forecolour, unsigned char backcolour, int x, int y);
};
