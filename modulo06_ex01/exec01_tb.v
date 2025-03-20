module exec01_tb;
    localparam WIDTH = 5;
    
    reg [WIDTH-1:0] a, b, c, f;
    reg ctrl;
    wire [WIDTH-1:0] d;

    exec01
    #(
        .WIDTH (WIDTH)
    )
    exec01_inst
    (
        .a(a),
        .b(b),
        .c(c),
        .f(f),
        .ctrl(ctrl),
        .d(d)
    );

    task expect;
        input [WIDTH-1:0] d_out;
        if(d !== d_out) begin
            $display("TEST FAILED");
            $display("At time %0d a=%b b=%b c=%b f=%b ctrl=%b d=%b",
                    $time, a, b, c, f, ctrl, d);
            $display("exercicio01 should be %b", d_out);
            $finish;
        end
        else begin
            $display("At time %0d a=%b b=%b c=%b f=%b ctrl=%b d=%b",
                    $time, a, b, c, f, ctrl, d);
        end
    endtask

    initial begin
        a = 4'b0011; b = 4'b0001; c = 4'b0000; f = 4'b0011; ctrl = 0; #1 expect(4'b0001);
        a = 4'b0111; b = 4'b0011; c = 4'b0000; f = 4'b0011; ctrl = 0; #1 expect(4'b0011);
        a = 4'b0011; b = 4'b0001; c = 4'b0000; f = 4'b0111; ctrl = 1; #1 expect(1'b0000);
        a = 4'b0011; b = 4'b0001; c = 4'b0000; f = 4'b0111; ctrl = 0; #1 expect(1'b0000);
        a = 4'b0011; b = 4'b0001; c = 4'b0001; f = 4'b0111; ctrl = 0; #1 expect(1'b0001);
        $display("TEST PASSED");
        $finish;
    end

endmodule