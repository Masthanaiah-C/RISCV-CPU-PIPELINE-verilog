/*
member 1:
            Name : Masthanaiah Chintamani
            Roll : 191CS115
member 2:
            Name : LSV Sandeep 
            Roll : 191CS226
Module Name :
            generated branched pc values 
Date of creation : 25rd March,2021
Date of submission : 29th March,2021
*/
// pc +immediate if branch condition is enabled
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