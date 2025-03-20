
module memory #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 32) (
    input clk,
    input mem_write,
    input mem_read,
    input [ADDR_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] write_data,
    output reg [DATA_WIDTH-1:0] read_data
);

    reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    always @(posedge clk) begin
        if (mem_write) begin
            mem[address] <= write_data;
        end
        if (mem_read) begin
            read_data <= mem[address];
        end
    end

endmodule
