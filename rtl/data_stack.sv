module data_stack
#(
    parameter STACK_DEPTH = 16,
    parameter TOS_P_WIDTH = 4
)
(
    input logic clk,

    input logic [3:0] push_data,
    input logic push_en,

    input logic pop_en,
    output logic [3:0] pop_data,

    output logic [3:0] tos,
    output logic [3:0] ntos
);

reg [STACK_DEPTH-1:0][3:0] stack;
reg [TOS_P_WIDTH-1:0] tos_pointer;

logic [1:0] push_pop;
assign push_pop[0] = pop_en;
assign push_pop[1] = push_en;

always@(posedge clk)
begin
    unique case(push_pop)
        2'b00: pop_data = 4'b0000;

        // POP
        2'b01: 
            begin
            pop_data = stack[tos_pointer];
            tos_pointer = tos_pointer - 1;
            end
        
        // PUSH
        2'b10: 
            begin
            tos_pointer = tos_pointer + 1;
            stack[tos_pointer] = push_data;
            end
        
        // POP and PUSH (Replace the TOS with push_data)
        2'b11: stack[tos_pointer] = push_data;
    endcase
end

assign tos = stack[tos_pointer];
assign ntos = stack[tos_pointer - 1];

endmodule