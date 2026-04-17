#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <verilated.h>

#define ENABLE_TRACE 1

#if ENABLE_TRACE
    #include <verilated_fst_c.h>
#endif

#include "Vtop.h"

#define MAX_SIM_TIME 10000
#define TIME_RST 4

#define POLY_N  256
#define POLY_Q  8380417
vluint64_t sim_time = 0;
vluint64_t clk_time = 0;
vluint64_t temp_time = 0;
uint32_t temp = 0;
uint8_t temp_bytes[3];
bool check_byte;

typedef struct{
    unsigned char *value;
    size_t size;
} Bytes;

void hex_string_to_bytes(const char* hex_string, Bytes* bytes) {
    size_t hex_len = strlen(hex_string);
    bytes->size = hex_len / 2;
    bytes->value = (unsigned char*)malloc(bytes->size * sizeof(unsigned char));
    for (size_t i = 0; i < bytes->size; i++) {
        sscanf(&hex_string[2 * i], "%2hhx", &bytes->value[i]);
    }
}

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vtop *top = new Vtop;

#if ENABLE_TRACE
    Verilated::traceEverOn(true);
    VerilatedFstC *m_trace = new VerilatedFstC;
    top->trace(m_trace, 4);
    m_trace->open("wave.fst");
#endif

    top->clk_i           = 0;
    top->rstn_i          = 0;
    top->branch_i        = 0;
    top->flush_i         = 0;
    top->write_PC_en_i   = 0;
    top->addr_branch_i   = 0;

    while ((sim_time < MAX_SIM_TIME)) {
        // top_reset(top, sim_time);
        top->clk_i  ^= 1;
        
        top->eval();
        #if ENABLE_TRACE
            m_trace->dump(sim_time);
        #endif

        if (sim_time >= 0 && sim_time < TIME_RST) { 
            top->rstn_i = 0;
        } else top->rstn_i = 1;
        
        if (sim_time >= TIME_RST && top->clk_i == 0) {
            //tb
            
        }
        sim_time++;
    }
#if ENABLE_TRACE
    m_trace->close();
    delete m_trace;
#endif
 
    delete top;

    std::cout << "\n\033[32mSimulation done\033[0m\n";
    return EXIT_SUCCESS;

}
