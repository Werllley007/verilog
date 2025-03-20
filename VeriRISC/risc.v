
module risc_cpu #(parameter WIDTH = 32) (
    input clk,
    input reset,
    output [WIDTH-1:0] pc_out
);

    reg [WIDTH-1:0] pc;
    wire [31:0] instruction;
    wire [31:0] read_data_1, read_data_2, write_data, alu_result, mem_read_data;
    wire [4:0] write_reg;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch;
    wire [1:0] alu_op;
    wire [2:0] alu_control;

    // Program Counter
    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 0;
        else pc <= pc + 4;
    end

    // Instruction Memory
    memory #(.ADDR_WIDTH(8), .DATA_WIDTH(32)) instr_mem (
        .clk(clk),
        .mem_write(0),
        .mem_read(1),
        .address(pc[7:0]),
        .write_data(32'b0),
        .read_data(instruction)
    );

    // Controller
    controller control_unit (
        .clk(clk),
        .reset(reset),
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    // Register File
    register reg_file (
        .clk(clk),
        .reset(reset),
        .write_enable(reg_write),
        .data_in(write_data),
        .data_out(read_data_1)
    );

    // ALU Control
    alu alu_unit (
        .a(read_data_1),
        .b(read_data_2),
        .op(alu_control),
        .result(alu_result),
        .zero()
    );

    // Data Memory
    memory data_mem (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result[7:0]),
        .write_data(read_data_2),
        .read_data(mem_read_data)
    );

    // MUX for write-back
    assign write_data = mem_to_reg ? mem_read_data : alu_result;

    assign pc_out = pc;

endmodule
