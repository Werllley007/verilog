module exec01_tb;
    localparam WIDTH = 4;

    reg  [WIDTH-1:0] a,b,c,s;
    wire [WIDTH-1:0] w,v,y,t;

    // Instancia o módulo twelve_wrong
    twelve_wrong#(.WIDTH(WIDTH))
        twelve_wrong_inst(
            .a(a),
            .b(b),
            .c(c),
            .s(s),
            .w(w),
            .v(v),
            .y(y),
            .t(t)
        );

    // Task para comparar os valores e verificar se estão corretos
    task expect;
        input [WIDTH-1:0] w_out, v_out, y_out, t_out;
        begin
            if (w !== w_out || v !== v_out || y !== y_out || t !== t_out) begin
                $display("TEST FAILED");
                $display("At time %0d a=%b, b=%b, c=%b ,s=%b", $time, a, b, c, s);
                $display("Expected: w=%b, v=%b, y=%b, t=%b", w_out, v_out, y_out, t_out);
                $finish;
            end
            else begin
                $display("At time %0d a=%b, b=%b, c=%b ,s=%b", $time, a, b, c, s);
                $display("TEST PASSED");
            end
        end
    endtask

    // Bloco inicial com os testes
    initial begin
        // Teste 1 - s == 0
        a = 4'b0001; b = 4'b0010; c = 4'b0011; s = 4'b0000; #1;
        expect(4'b0000, 4'b0001, 4'b0010, 4'b0011);  // Esperado: w=0000, v=0001, y=0010, t=0011

        // Teste 2 - s <= 4'b0101
        a = 4'b0001; b = 4'b0010; c = 4'b0011; s = 4'b0100; #1;
        expect(4'b0100, 4'b0011, 4'b0010, 4'b0001);  // Esperado: w=0100, v=0011, y=0010, t=0001

        // Teste 3 - s == 6
        a = 4'b0001; b = 4'b0010; c = 4'b0011; s = 4'b0110; #1;
        expect(4'b0011, 4'b0000, 4'b0000, 4'b0000);  // Esperado: w=0000, v=0011, y=0000, t=0000

        // Teste 4 - s == 7
        a = 4'b0001; b = 4'b0010; c = 4'b0011; s = 4'b0111; #1;
        expect(4'b0011, 4'b0000, 4'b0000, 4'b0000);  // Esperado: w=0000, v=0011, y=0000, t=0000

        // Teste 5 - else v = 4'bxxxx;
        a = 4'b0001; b = 4'b0010; c = 4'b0011; s = 4'b1000; #1;
        expect(4'bxxxx, 4'bxxxx, 4'bxxxx, 4'bxxxx);  // Esperado: w=xxxx, v=xxxx, y=xxxx, t=xxxx

        $display("All tests passed!");
        $finish;
    end
endmodule
