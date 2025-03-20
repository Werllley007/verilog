//--------------------------------------------
//Encontre 12 erros no código abaixo e corrija:
//--------------------------------------------
// module twelve_wrong(w,v,y,t,b,c,s)
//     input  [3:0] a,b,c,s;
//     output [3,0] w,v,y,t;
//     reg    [3:0] w,v,y,t,

//     assign W = s;

//     always @(a or b or c and s) begin
//         if (s == 0)
//             v = a;
//             y = b;
//             t = c;
//         else if (s <= 4'b0101) begin
//             v = c;
//             y = b;
//             t = a;
//             a = s;
//         end
//         else if (s == 6 or s == 7) begin
//             v = c;
//         else v == 4'b'xxxx;
// endmodule

//--------------------------------------------
// Código Corrigido 
//--------------------------------------------
// module twelve_wrong(w, v, y, t, a, b, c, s);
//     input  [3:0] a, b, c, s;
//     output [3:0] w, v, y, t;
//     reg    [3:0] w, v, y, t;

//     always @(a or b or c or s) begin
//         if (s == 0) begin
//             v = a;
//             y = b;
//             t = c;
//             w = s;  // Atribuição de 'w' dentro do 'always'
//         end
//         else if (s <= 4'b0101) begin
//             v = c;
//             y = b;
//             t = a;
//             w = s;  // Atribuição de 'w' dentro do 'always'
//         end
//         else if (s == 6 || s == 7) begin
//             v = c;
//         end
//         else 
//             v = 4'bxxxx;  // Atribuindo 'v' com valor 'xxxx'
//     end
// endmodule

//--------------------------------------------
// Código Corrigido - do meu jeito
//--------------------------------------------
module twelve_wrong#(parameter WIDTH = 4)(
    input       [WIDTH-1:0] a,b,c,s,
    output reg  [WIDTH-1:0] w,v,y,t
);
    // Remova o assign, pois 'w' é um 'reg' e não pode ser atribuído assim
    // assign w = s;  // Erro: 'w' é um 'reg'

    always @(a or b or c or s) begin
        if (s == 0) begin
            v = a;
            y = b;
            t = c;
            w = s; // Agora 'w' é atribuído corretamente aqui
        end
        else if (s <= 4'b0101) begin
            v = c;
            y = b;
            t = a;
            w = s; // Atribuindo 'w' dentro de 'always'
        end
        else if (s == 6 || s == 7)  begin
            v = c;
        end
        else 
            v = 4'bxxxx;
    end
endmodule