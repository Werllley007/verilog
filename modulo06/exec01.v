module exec01 #(parameter WIDTH = 4)(
    input [WIDTH-1:0] a, b, c, f,
    input ctrl,
    output reg [WIDTH-1:0] d

    );

    always @(a or b or c or f or ctrl) begin
        if (f < 4'b0110)
            d = a & b;
        else if (ctrl)
            d = 1'b0;
        else
            d = c;
    end
endmodule
