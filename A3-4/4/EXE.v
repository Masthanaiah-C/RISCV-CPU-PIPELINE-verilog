

module mux_2inp(out,inp0,inp1,c); //mux take 2 inputs and give one output with help of one control input
output [63:0] out;
input [63:0] inp0,inp1;
input c;
assign out=(c)?inp1:inp0;
endmodule



module exe(a,b,func,op,overflow,zero,result,mux,imm); // execution block alu + mux to select the input for immediate or output register
input [63:0] a,b,imm;
output [63:0] result;
output overflow,zero;
wire [63:0] r;
input [1:0] op;
wire [3:0] operation;
input [5:0] func;
input mux;
bit_64 alu(a,r,operation,result,overflow,zero);
control c(func,op,operation);
mux_2inp m(r,b,imm,mux);
endmodule
