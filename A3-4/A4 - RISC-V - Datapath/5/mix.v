module mux_2inp(out,inp,inp1,c); //mux take 2 inputs and give one output with help of one control input
output [63:0] out;
input [63:0] inp,inp1;
input c;

assign out=(c)?inp1:inp;
endmodule

module adder(pc,out);
input [63:0] pc;
output [63:0] out;
assign out=pc+4;
endmodule

module beq(instruction,pc,pc_up,func,op,memwrite,memread,mem_reg,branch,c1,overflow,write_control,MEM_out,result,zero,operation);
input write_control;
wire [63:0] out1,out2;
output [63:0] MEM_out;
//
//
output [63:0] result;
output zero;
output overflow;
//
wire [63:0] final_pc;
input [31:0] instruction;
wire [63:0] imm_out;
input c1;
//
output [63:0] branch;
input [63:0] pc;
output [63:0] pc_up;
wire [63:0] out;
input mem_reg;
input memread,memwrite;
// 
input [1:0] op;
output [3:0] operation;
input [5:0] func;
wire [63:0] alu_inp;
//


adder m(pc,pc_up);//pc adder 
control c(func,op,operation); //func,op                                 
 MEM mm(result,out2,memread,memwrite,out);//memread,memwrite            
imm_generate i(instruction,imm_out);//instruction                   
mux_2inp m1(alu_inp,out2,imm_out,c1);//c1   //mux 2:1
reg_file r(instruction[19:15],instruction[24:20],instruction[11:7],MEM_out,out1,out2,write_control);//write_control 
 branch_pc b(imm_out,pc,branch); 
 bit_64 al(out1,alu_inp,operation,result,overflow,zero); 
mux_2inp m2(final_pc,pc_up,branch,zero); 

mux_2inp m3(MEM_out,out,result,mem_reg);//mem_reg
endmodule
