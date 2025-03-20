
module alu_test;

  localparam WIDTH = 8;

  reg [WIDTH-1:0] a, b;
  reg [2:0] op;
  wire [WIDTH-1:0] result;
  wire zero;

  alu #(.WIDTH(WIDTH)) alu_inst (
      .a(a),
      .b(b),
      .op(op),
      .result(result),
      .zero(zero)
  );

  task expect;
      input [WIDTH-1:0] exp_result;
      input exp_zero;
      if (result !== exp_result || zero !== exp_zero) begin
          $display("TEST FAILED");
          $display("At time %0d: a=%h b=%h op=%b result=%h zero=%b",
                   $time, a, b, op, result, zero);
          $finish;
      end else begin
          $display("At time %0d: a=%h b=%h op=%b result=%h zero=%b",
                   $time, a, b, op, result, zero);
      end
  endtask

  initial begin
      a = 8'h0A; b = 8'h05; op = 3'b000; #1 expect(8'h0F, 0); // ADD
      a = 8'h0A; b = 8'h05; op = 3'b001; #1 expect(8'h05, 0); // SUB
      a = 8'h0A; b = 8'h05; op = 3'b010; #1 expect(8'h00, 1); // AND
      a = 8'h0A; b = 8'h05; op = 3'b011; #1 expect(8'h0F, 0); // OR
      a = 8'h0A; b = 8'h05; op = 3'b100; #1 expect(8'h0F, 0); // XOR
      $display("TEST PASSED");
      $finish;
  end

endmodule
