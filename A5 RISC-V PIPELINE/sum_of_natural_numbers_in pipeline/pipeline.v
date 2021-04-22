
/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME: pipeline
    contains
        1)IF stage
        2)ID stage
        3)EXE stage
        4)MEM STAGE
        5)WB stage

*/



module pipeline(pc_input,clk,reset,overflow);

input reset;
input [63:0] pc_input;
wire [31:0] instruction;
input clk;
wire [63:0] pc;
wire [63:0] pc_updated;
wire [63:0] next_pc;
wire [63:0] wd;
wire ALUSrc,MemtoReg,MemWrite,Memread,Branch;
wire [3:0] operation;
wire Regwrite;
wire [63:0] out1,out2,imm;
wire zero;
wire [63:0] result,read_output;
output overflow;
wire branch_pc_selector;
wire [63:0] branched_pc;
IF inst_fetch(instruction,reset,pc_input,pc_updated,clk,pc,next_pc);
ID instr_decode(wd,instruction,out1,out2,imm,ALUSrc,MemtoReg,MemWrite,Memread,Branch,operation);
EX exe(out1,out2,operation,overflow,zero,result,ALUSrc,imm,pc,branched_pc);
MEM memory_access(read_output,Memread,MemWrite,out2,result,Branch,zero,next_pc,branched_pc,pc_updated);
WB w(wd,read_output,result,MemtoReg);


initial begin
    $dumpfile("pipe_INSTRUCTION.vcd");
    $dumpvars(0,pipeline);
    $display("we generate 100 in register and storing address in register x10 ; store 100 in the address recided in x10 and fetch it and we do r-type instructions ");
    $monitor("----------------------------\n time :" ,$time ,"\npc_value       : %d ,\n aluoutput     : %d ,\n read_memory_output: %d,\n instruction   :%h, \n immediate     :%d,\n reg_output_1  :%d,\n reg_output_2  :%d,\nnext_pc :%d\n-------------------------------------------------------",pc,result,read_output,instruction,imm,out1,out2,next_pc);
end
endmodule
