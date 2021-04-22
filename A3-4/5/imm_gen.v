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
/*
module tb();
reg [31:0] instruction;
wire [63:0] out;
imm_generate f(instruction,out);
initial begin
    $monitor($time,"out :%b,in :%d",out,instruction);
    #5 instruction=0;
    #5 instruction=4567678056;
    #5 $finish;
end
endmodule
*/