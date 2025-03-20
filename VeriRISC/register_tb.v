
module register_test;

    localparam WIDTH = 32;

    reg clk;
    reg reset;
    reg write_enable;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;

    register #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        write_enable = 0;
        data_in = 0;
        
        #10 reset = 0;
        #10 data_in = 32'hA5A5A5A5; write_enable = 1;
        #10 write_enable = 0;
        #10 data_in = 32'h5A5A5A5A; // Should NOT update since write_enable is 0
        #10 write_enable = 1;
        #10 if (data_out !== 32'h5A5A5A5A) $display("TEST FAILED");
        else $display("TEST PASSED");

        $finish;
    end

endmodule
