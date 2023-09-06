#include "Cursor.h"

void Arkn::Cursor::DisableCursor()
{
    Arkn::IO::Outb(0x3D4, 0x0A);
	Arkn::IO::Outb(0x3D5, 0x20);
}