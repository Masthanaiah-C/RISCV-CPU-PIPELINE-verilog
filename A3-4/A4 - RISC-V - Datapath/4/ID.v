/*
member 1:
            Name : Masthanaiah Chintamani
            Roll : 191CS115
member 2:
            Name : LSV Sandeep 
            Roll : 191CS226
Module Name :
            instruction decode stage
Date of creation : 25rd March,2021
Date of submission : 29th March,2021

*/

//it uses register file and immmediate generator
module IDc(write_control,wd,instruction,out1,out2,imm);
input [63:0] wd;

input write_control;
output [63:0] out1,out2,imm;
input [31:0] instruction;
//main control is implemented in futher assignments
reg_file s(instruction[19:15],instruction[24:20],instruction[11:7],wd,out1,out2,write_control);
imm_generate g(instruction,imm);


endmodule