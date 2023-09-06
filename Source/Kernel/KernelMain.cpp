#include "KernelMain.h"

void Kernel::KernelUpdate()
{
    this->m_text_renderer.WriteCharacter('K', 0xFFF, 4, 10 ,10);
}

// ====== CALL FROM ASM =========

extern "C" void main()
{
    Kernel kernel;
    kernel.KernelUpdate();
    return;
}