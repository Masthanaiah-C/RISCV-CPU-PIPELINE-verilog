/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME: INSTRUCTION DECODE STAGE MODULE
    contains
        1)register file
        2)immediate generator
        3)control unit

*/
//ID
module reg_file(r1,r2,w,wd,out1,out2,write_control);
input [4:0] r1,r2,w;
input write_control;
output reg [63:0] out1,out2;
input [63:0] wd;
reg clk;
reg [63:0] file [31:0];
// change the below  values with desired ones
initial
begin
    file[0]=0;
    file[1]=0;
    file[2]=0;
    file[3]=0;
    file[4]=0;
    file[5]=0;
    file[6]=0;
    file[7]=0;
    file[8]=0;
    file[9]=0;
    file[10]=6144;
    file[11]=0;
    file[12]=0;
    file[13]=0;
    file[14]=0;
    file[15]=0;
    file[16]=0;
    file[17]=0;
    file[18]=0;
    file[19]=0;
    file[20]=0;
    file[21]=0;
    file[22]=0;
    file[23]=0;
    file[24]=0;
    file[25]=0;
    file[26]=0;
    file[27]=0;
    file[28]=0;
    file[29]=0;
    file[30]=0;
    file[31]=0;

end

initial begin
    clk=0;
    forever begin
       #5 clk=~clk;
    end
end
always @(wd or write_control or w or clk)
begin
if(write_control==1)
file[w]<=wd ;
end
always @(r1 or r2) begin
   out1=file[r1];
   out2=file[r2]; 
end
 
endmodule

module imm_generate(instruction,out);
input [31:0] instruction;
output reg [63:0] out;
wire [51:0] ext;
wire [6:0] a,op;
wire [4:0] b;
wire [4:0] b1;
assign op=instruction[6:0];
assign ext=-1;
// out={ext*(instruction[31]),instruction[31:20]};
always @(op or instruction)
begin
    if(op==7'b0010011 || op==7'b0000011 )
    begin
     out={ext*(instruction[31]),instruction[31:20]};
    end
    if(op==7'b1100011)
    begin
     out={ext*(instruction[31]),instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    end
    if(op==7'b0100011)
    begin
     out={ext*(instruction[31]),instruction[31:25],instruction[11:7]};
    end
end
endmodule

module ID(wd,instruction,out1,out2,imm,ALUSrc,MemtoReg,MemWrite,Memread,Branch,operation);
input [63:0] wd;
output ALUSrc,MemtoReg,MemWrite,Memread,Branch;
output [3:0] operation;
wire Regwrite;
output [63:0] out1,out2,imm;
input [31:0] instruction;

reg_file s(instruction[19:15],instruction[24:20],instruction[11:7],wd,out1,out2,Regwrite);
imm_generate g(instruction,imm);
main_control c(instruction[6:0],instruction[31:25],instruction[14:12],ALUSrc,MemtoReg,Regwrite,MemWrite,Memread,Branch,operation);
endmodule

//ID finish