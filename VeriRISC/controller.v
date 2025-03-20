module controller_tb (
    input       zero       ,
    input [2:0] phase      ,
    input [2:0] opcode     ,
    output reg  sel        ,   
    output reg  rd         ,
    output reg  ld_ir      ,
    output reg  halt       ,
    output reg  inc_pc     ,
    output reg  ld_ac      ,
    output reg  wr         ,
    output reg  ld_pc      ,
    output reg  data_e         
);

    localparam INST_ADDR    = 3'b000;
    localparam INST_FETCH   = 3'b001;
    localparam INST_LOAD    = 3'b010;
    localparam IDLE         = 3'b011;
    localparam OP_ADDR      = 3'b100;
    localparam OP_FETCH     = 3'b101;
    localparam ALU_OP       = 3'b110;
    localparam STORE        = 3'b111;

    localparam HLT          = 3'b000;
    localparam SKZ          = 3'b001;
    localparam ADD          = 3'b010;
    localparam AND          = 3'b011;
    localparam XOR          = 3'b100;
    localparam LDA          = 3'b101;
    localparam STO          = 3'b110;
    localparam JMP          = 3'b111;   
        

    always @* begin
        case(phase)
        INST_ADDR  : begin 
            sel    <= 1;
            rd     <= 0;
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end 
        INST_FETCH : begin 
            sel    <= 1;
            rd     <= 1;
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end
        INST_LOAD  : begin 
            sel    <= 1;
            rd     <= 1;
            ld_ir  <= 1;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end
        IDLE       : begin 
            sel    <= 1;
            rd     <= 1;
            ld_ir  <= 1;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end
        OP_ADDR    : begin 
            sel    <= 0;
            rd     <= 0;
            ld_ir  <= 0;
            halt   <= (opcode == HLT ? 1 : 0);
            inc_pc <= 1;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end
        OP_FETCH   : begin 
            sel    <= 0;
            rd     <= (opcode == ADD || opcode == AND || opcode == XOR || opcode == || LDA ? 1 : 0);
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= 0;
            data_e <= 0;
        end
        ALU_OP     : begin 
            sel    <= 0;
            rd     <= (opcode == ADD || opcode == AND || opcode == XOR || opcode == || LDA ? 1 : 0);
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= ((opcode == SKZ ? 1 : 0) && zero);
            ld_ac  <= 0;
            wr     <= 0;
            ld_pc  <= (opcode == JMP ? 1 : 0);
            data_e <= (opcode == STO ? 1 : 0);
        end
        STORE      : begin 
            sel    <= 0;
            rd     <= (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA ? 1 : 0);
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA ? 1 : 0);
            wr     <= (opcode == STO ? 1 : 0);
            ld_pc  <= (opcode == JMP ? 1 : 0);
            data_e <= (opcode == STO ? 1 : 0);
        end
        endcase        
    end
    
endmodule