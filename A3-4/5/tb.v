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

module tb();

reg write_control;
wire [63:0] out1,out2;
wire [63:0] MEM_out;


wire [63:0] result;
wire overflow,zero;

wire [63:0] final_pc;
reg [31:0] instruction;
wire [63:0] imm_out;
reg c1;

wire [63:0] branch;
reg [63:0] pc;
wire [63:0] pc_up;
wire [63:0] out;
reg mem_reg;
reg memread,memwrite;
 
reg [1:0] op;
wire [3:0] operation;
reg [5:0] func;
wire [63:0] alu_inp;
adder m(pc,pc_up);
control c(func,op,operation); //func,op
 MEM mm(result,out2,memread,memwrite,out);//memread,memwrite
imm_generate i(instruction,imm_out);//instruction
mux_2inp m1(alu_inp,out2,imm_out,c1);//c1
reg_file r(instruction[19:15],instruction[24:20],instruction[11:7],MEM_out,out1,out2,write_control);//write_control
 branch_pc b(imm_out,pc,branch);
 bit_64 al(out1,alu_inp,operation,result,overflow,zero);
mux_2inp m2(final_pc,pc_up,branch,zero);

mux_2inp m3(MEM_out,out,result,mem_reg);//mem_reg

//output : operation,pc,pc_up,branch,MEM_out,write_control,mem_reg

initial
begin
    $monitor($time, ".ALUresult:%d ,ALUoperation :%d,pc :%d ,pc_updated :%d,branched_pc:%d,mem_write :%d mem_read :%d, MEM_out :%d,writeback to reg:%d zero: %d",result,operation,pc,pc_up,branch,memwrite,memread,out,MEM_out,zero);
#5 $display("\nsubtract operation with file[1]=6000;file[3]=1470; to file[6]");    
     func=6'b000010;
    op=2'b10;
    pc=3000;
    memwrite=0;
    memread=1;
    instruction=32'b00000000001100001000001100010011;
    c1=0;
    write_control=1;
    mem_reg=1;
#5 $display("\nadd operation with file[1]=6000;file[3]=1470; to file[4]");
     func=6'b000000;
    op=2'b10;
    memwrite=0;
    pc=4000;
    memread=1;
    instruction=32'b00000000001100001000001000000000;
    c1=0;
    write_control=1;
    mem_reg=1;
#5 $display("\nbranching the pc to before instruction(pc-4) ");
     func=6'b000000;
    op=2'b01;
    memwrite=0;
    pc=5000;
    memread=1;
    instruction=32'b11111110000100001000111011100011;
    c1=0;
    write_control=0;
    mem_reg=1;
#5 $display("\nbranching the pc to pc+28 ");
     func=6'b000000;
    op=2'b01;
    memwrite=0;
    pc=5000;
    memread=1;
    instruction=32'b00000000000100001000111001100011;
    c1=0;
    write_control=0;
    mem_reg=1;
#5 $display("\nstore the instruction file[4] at 7024 whih has the sum of 6000 and 1470 =7470");
     func=6'b000000;
    op=2'b00;
    memwrite=1;
    pc=5000;
    memread=0;
    instruction=32'b01000000010000001000000000100011;
    c1=1;
    write_control=0;
    mem_reg=0;  
#5 $display("\nload the instruction file[4] at 7024");
     func=6'b000000;
    op=2'b00;
    memwrite=0;
    pc=5000;
    memread=1;
    instruction=32'b01000000000000001000001000000011;
    c1=1;
    write_control=1;
    mem_reg=0;
    #10 $finish;
end


endmodule