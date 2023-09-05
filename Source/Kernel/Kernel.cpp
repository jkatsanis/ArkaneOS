#include "KernelTest.h"

extern "C" void main(){
    *(char*)0xb8000 = h.USE;
    return;
}
