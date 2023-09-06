#include "KernelMain.h"

void Arkn::Kernel::KernelUpdate()
{
    Arkn::String str("Hello OS");
    
    Arkn::TextRenderer::WriteString(str, Arkn::Point(10, 10));    

    this->m_cursor.DisableCursor();

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