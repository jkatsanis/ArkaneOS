#include "TextRenderer/TextRenderer.h"

class Kernel
{
private:
    TextRenderer m_text_renderer;
public:
    void KernelUpdate();
};

void Kernel::KernelUpdate()
{
    m_text_renderer.WriteCharacter('K', 0xFFF, 4, 10 ,10);
}


extern "C" void main()
{
    Kernel kernel;
    kernel.KernelUpdate();
    return;
}