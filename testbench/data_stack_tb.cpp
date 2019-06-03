#include <stdlib.h>
#include <iostream>
#include "Vdata_stack.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv) {
	// Initialize Verilators variables
    VerilatedVcdC* tfp = NULL;
	Verilated::commandArgs(argc, argv);

	// Create an instance of our module under test
	Vdata_stack *ds = new Vdata_stack;
    ds->eval();

    vluint64_t time = 0;

    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;

    ds->trace(tfp, 99);

    std::string vcdname = argv[0];
    vcdname += ".vcd";
    std::cout << vcdname << std::endl;
    tfp -> open(vcdname.c_str());

	// Tick the clock until we are done
	for(int i = 0; i < 100; i++) {
		ds->clk = 1;
		ds->eval();

        if(tfp != NULL)
        {
            tfp -> dump(time);
        }
        time+=10;

		ds->clk = 0;
        ds->push_en = 1;
        ds->push_data = i % 4;
		ds->eval();
        if(tfp != NULL)
        {
            tfp -> dump(time);
        }

        time+=10;
	}

    ds->final();               // Done simulating

    if (tfp != NULL)
    {
        tfp->close();
        delete tfp;
    }

    delete ds;
}
