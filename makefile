DESIGN_TOP=toxic_core
TEST_BENCH=testbench.cpp
TB_DIR=testbench/
RTL_DIR=rtl/
OPTIMIZATION=-O3 -fno-stack-protector

all: verilog compile sim

verilog: alu
	verilator -cc rtl/toxic_core.sv -exe $(TB_DIR)$(TEST_BENCH) --trace -o ../sim -I$(RTL_DIR)

alu:
	verilator -cc rtl/alu.sv --trace -I$(RTL_DIR)

data_stack:
	verilator -cc rtl/data_stack.sv --trace -I$(RTL_DIR)

data_stack_sim:
	verilator -cc rtl/data_stack.sv -exe $(TB_DIR)data_stack_tb.cpp --trace -I$(RTL_DIR) -o ../data_stack_sim 
	make -C ./obj_dir OPT_FAST="$(OPTIMIZATION)" -j -f Vdata_stack.mk

compile:
	make -C ./obj_dir OPT_FAST="$(OPTIMIZATION)" -j -f V$(DESIGN_TOP).mk

sim:
	./sim

clean:
	rm -rf obj_dir
	rm -f sim sim.vcd
	rm -f data_stack_sim data_stack_sim.vcd
