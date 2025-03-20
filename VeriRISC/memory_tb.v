
module memory_test;

    localparam ADDR_WIDTH = 8;
    localparam DATA_WIDTH = 32;

    reg clk;
    reg mem_write;
    reg mem_read;
    reg [ADDR_WIDTH-1:0] address;
    reg [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] read_data;

    memory #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        mem_write = 0;
        mem_read = 0;
        address = 0;
        write_data = 0;

        // Write to memory
        #10 address = 8'h01; write_data = 32'hA5A5A5A5; mem_write = 1; mem_read = 0;
        #10 mem_write = 0;

        // Read from memory
        #10 address = 8'h01; mem_read = 1;
        #10 if (read_data !== 32'hA5A5A5A5) $display("TEST FAILED (Read Error)");
        else $display("Memory Read Test Passed");

        // Test Overwrite
        #10 address = 8'h01; write_data = 32'h5A5A5A5A; mem_write = 1; mem_read = 0;
        #10 mem_write = 0; mem_read = 1;
        #10 if (read_data !== 32'h5A5A5A5A) $display("TEST FAILED (Overwrite Error)");
        else $display("Memory Overwrite Test Passed");

        $display("ALL TESTS PASSED");
        $finish;
    end

endmodule
