#pragma once

#include "TextRenderer/TextRenderer.h"
#include "Standard/Cursor.h"
#include "Standard/String.h"
#include "Standard/Point.h"
#include "Standard/IO.h"

namespace Arkn
{
    class Kernel
    {
    private:
        Arkn::Cursor m_cursor;

    public:
        Kernel();

        void KernelUpdate();
    };
}
