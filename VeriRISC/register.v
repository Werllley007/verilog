
module register #(parameter WIDTH = 32) (
    input clk,
    input reset,
    input write_enable,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
        end else if (write_enable) begin
            data_out <= data_in;
        end
    end

endmodule
