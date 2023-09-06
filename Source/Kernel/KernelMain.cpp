#include "KernelMain.h"

void Arkn::Kernel::KernelUpdate()
{
    this->m_cursor.DisableCursor();
    this->m_text_renderer.WriteCharacter('M', 0xFFF, 4, 10 ,10);
    while (1)
    {
        
    }    
}

// ====== CALL FROM ASM =========

extern "C" int main()
{
    Arkn::Kernel kernel;
    kernel.KernelUpdate();
    return 1;
}