// Simple hello world in SystemVerilog
module toxic_core
    (
        input logic rst,
        input logic clk,
        output logic pulse,
        output logic [3:0] alu_result,
        output clk_morror
    );

    reg [7:0] counter;
    logic carry;

    alu aluinst
    (
        .operand_a(counter[3:0]),
        .operand_b(4'b0000),
        .aluop(2'b00),
        .alu_result(alu_result),
        .carry(carry)
    );

    always@(posedge clk)
    begin
        if(rst)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    always_comb
    begin
        pulse = counter[2] && counter[1];
    end

    assign clk_morror = clk;

endmodule