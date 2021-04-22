module WB(wd,data,result,MemtoReg);
input [63:0] data,result;
output [63:0] wd;
input MemtoReg;
assign wd=(MemtoReg)?data:result;
endmodule