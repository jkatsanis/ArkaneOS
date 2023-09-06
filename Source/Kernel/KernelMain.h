#pragma once

#include "TextRenderer/TextRenderer.h"
#include "Standard/Cursor.h"

namespace Arkn
{
    class Kernel
    {
    private:
        Arkn::TextRenderer m_text_renderer;
        Arkn::Cursor m_cursor;

    public:
        void KernelUpdate();
    };
}
