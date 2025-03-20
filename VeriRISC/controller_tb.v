module controller_tb;
    localparam integer HLT = 0;
    localparam integer SKZ = 1;
    localparam integer ADD = 2;
    localparam integer AND = 3;
    localparam integer XOR = 4;
    localparam integer LDA = 5;
    localparam integer STO = 6;
    localparam integer JMP = 7;   

    reg         zero   ; // acumulador é zero   
    reg [2:0]   phase  ; //  
    reg [2:0]   opcode ; //                         
    wire        sel    ; // sleciona instrução do endereço de memoria       
    wire        rd     ; // ativa a memoria de saída                    
    wire        ld_ir  ; // carrega o registrador de instruções          
    wire        halt   ; // halt                         
    wire        inc_pc ; // incrementa o PC     
    wire        ld_ac  ; // carrega o acumulador no barremento de dados 
    wire        wr     ; //  escrever barramento de dados na memória
    wire        ld_pc  ; //  carrega o PC
    wire        data_e ; //  ativa o acumulador de saída 

    controller 
        controller_inst(
            .zero  (zero  ),
            .phase (phase ),
            .opcode(opcode),
            .sel   (sel   ),
            .rd    (rd    ),
            .ld_ir (ld_ir ),
            .halt  (halt  ),
            .inc_pc(inc_pc),
            .ld_ac (ld_ac ),
            .wr    (wr    ),
            .ld_pc (ld_pc ),
            .data_e(data_e)
        );

    task expect;

    endtask

    initial begin
        
    end
    
endmodule