module alu
    (
        input logic [3:0] operand_a,
        input logic [3:0] operand_b,
        input logic [1:0] aluop,
        output logic [3:0] alu_result,
        output logic carry
    );

assign carry = 0;

always_comb
begin
    unique case(aluop)
        2'b00: alu_result = operand_a + operand_b;
        2'b01: alu_result = operand_a ^ operand_b;
        2'b10: alu_result = 0;
        2'b11: alu_result = 0;
    endcase
end

endmodule
