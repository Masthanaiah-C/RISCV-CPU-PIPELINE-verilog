
module IDc(write_control,wd,instruction,out1,out2,imm);
input [63:0] wd;


input write_control;
output [63:0] out1,out2,imm;
input [31:0] instruction;
//main control is implemented in futher assignments
reg_file s(instruction[19:15],instruction[24:20],instruction[11:7],wd,out1,out2,write_control);
imm_generate g(instruction,imm);


endmodule