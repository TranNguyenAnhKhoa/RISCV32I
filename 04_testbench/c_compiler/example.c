#include <stdint.h>

#define RESULT_ADDRESS 0x00000100u

int main(void)
{
    volatile uint32_t accumulator = 0u;
    uint32_t index;
    volatile uint32_t *result_pointer;

    for (index = 1u; index <= 10u; index++) {
        accumulator += index;
    }

    result_pointer = (volatile uint32_t *)RESULT_ADDRESS;
    *result_pointer = accumulator;

    return 0;
}

