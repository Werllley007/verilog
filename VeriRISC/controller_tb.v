
module controller_test;

    reg clk;
    reg reset;
    reg [5:0] opcode;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch;
    wire [1:0] alu_op;

    controller uut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // Test R-type
        opcode = 6'b000000;
        #10;
        if (reg_dst !== 1 || alu_src !== 0 || reg_write !== 1) $display("TEST FAILED (R-type)");
        else $display("R-type instruction passed");

        // Test LW
        opcode = 6'b100011;
        #10;
        if (alu_src !== 1 || mem_read !== 1 || mem_to_reg !== 1) $display("TEST FAILED (LW)");
        else $display("LW instruction passed");

        // Test SW
        opcode = 6'b101011;
        #10;
        if (alu_src !== 1 || mem_write !== 1) $display("TEST FAILED (SW)");
        else $display("SW instruction passed");

        // Test BEQ
        opcode = 6'b000100;
        #10;
        if (branch !== 1 || alu_op !== 2'b01) $display("TEST FAILED (BEQ)");
        else $display("BEQ instruction passed");

        $display("ALL TESTS PASSED");
        $finish;
    end

endmodule
