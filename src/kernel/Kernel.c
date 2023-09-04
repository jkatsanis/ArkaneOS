#include <stdio.h>
#include <stdint.h>

#define BUFFER_SIZE 512

void KernelUpadte();

void main()
{
    uint8_t buffer[BUFFER_SIZE];

    for(int i = 0; i < BUFFER_SIZE; i++)
    {
        buffer[i] = 0;
    }

    buffer[510] = 0x55;
    buffer[511] = 0xAA;

    while(1)
    {
        KernelUpadte();
    }
}

void KernelUpdate()
{

}