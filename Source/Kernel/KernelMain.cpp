#include "KernelMain.h"

Arkn::Kernel::Kernel()
{
    this->m_cursor.DisableCursor();
}

void Arkn::Kernel::KernelUpdate()
{
    Arkn::String yo("Afghane");
    TextRenderer::WriteLine(yo);

    while (1)
    {
       //  uint8_t keypressed = Arkn::IO::Inb(0x60);
       //  Arkn::TextRenderer::WriteLine(keypressed);
    }    
}

// ====== CALL FROM ASM =========

extern "C" int main()
{
    Arkn::Kernel kernel;
    kernel.KernelUpdate();
    return 1;
}