#include "UIWindow.h"

extern "C" void main(){
    UIWindow window = UIWindow();
    *(char*)0xb8000 = window.data;
    return;
}
