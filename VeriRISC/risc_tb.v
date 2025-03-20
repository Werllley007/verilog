
module risc_cpu_test;

    reg clk;
    reg reset;
    wire [31:0] pc_out;

    risc_cpu cpu (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;

        #100;
        $display("Final PC Value: %h", pc_out);
        $finish;
    end

endmodule
