
module multiplexor #(parameter WIDTH = 5) (
        input [WIDTH-1:0] in0,
        input [WIDTH-1:0] in1,
        input sel,
        output reg [WIDTH-1:0] mux_out
        );

        always @(in0 or in1 or sel) begin
                if(sel == 1'b0)
                        mux_out <= in0;
                else
                        mux_out <= in1;
        end
endmodule
