
module alu #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [2:0] op, // Operações: 000=ADD, 001=SUB, 010=AND, 011=OR, 100=XOR
    output reg [WIDTH-1:0] result,
    output reg zero
);

    always @(*) begin
        case (op)
            3'b000: result = a + b; // ADD
            3'b001: result = a - b; // SUB
            3'b010: result = a & b; // AND
            3'b011: result = a | b; // OR
            3'b100: result = a ^ b; // XOR
            default: result = 0;
        endcase
        zero = (result == 0);
    end

endmodule
