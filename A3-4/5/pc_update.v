module branch_pc(imm,pc,branch);
input [63:0] imm,pc;
output [63:0] branch;
wire [63:0] left;
assign left = imm<<1;
assign branch = left+pc;

endmodule
/*
module tb();
reg [63:0] imm,pc;
wire [63:0] branch;
 branch_pc p(imm,pc,branch);
 initial begin
     $monitor($time," . imm: %d,pc :%d ,output  :%d",imm,pc,branch);
     #5 imm=2;pc=20; 
     #5 imm=100;pc=40;
 end

endmodule
*/