#include <stdlib.h>
#include <iostream>
#include "Vtoxic_core.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv) {
	// Initialize Verilators variables
    VerilatedVcdC* tfp = NULL;
	Verilated::commandArgs(argc, argv);

	// Create an instance of our module under test
	Vtoxic_core *tb = new Vtoxic_core;
    tb->eval();

    vluint64_t time = 0;

    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;

    tb->trace(tfp, 99);

    std::string vcdname = argv[0];
    vcdname += ".vcd";
    std::cout << vcdname << std::endl;
    tfp -> open(vcdname.c_str());

    tb->rst = 1;
    tfp -> dump(time);
    time += 20;
    tb->rst = 0;
    tfp -> dump(time);

	// Tick the clock until we are done
	for(int i = 0; i < 100; i++) {
		tb->clk = 1;
		tb->eval();

        if(tfp != NULL)
        {
            tfp -> dump(time);
        }
        time+=10;

		tb->clk = 0;
		tb->eval();
        if(tfp != NULL)
        {
            tfp -> dump(time);
        }

        time+=10;
	}

    tb->final();               // Done simulating

    if (tfp != NULL)
    {
        tfp->close();
        delete tfp;
    }

    delete tb;
}
