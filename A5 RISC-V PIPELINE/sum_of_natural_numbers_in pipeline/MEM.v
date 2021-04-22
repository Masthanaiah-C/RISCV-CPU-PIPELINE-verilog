/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME: MEM stage
  contains
    1) next pc generator + mux which decide the branched 'pc' or 'pc+4'
    2) memory store/load


*/
module mux_2inp(next_pc,pc_updated,branched_pc,branch_pc_selector); //mux take 2 inputs and give one output with help of one control input
output [63:0] next_pc;
input [63:0] pc_updated,branched_pc;
input branch_pc_selector;
assign next_pc=(branch_pc_selector)?branched_pc:pc_updated;
endmodule

module pc_generator(next_pc,branched_pc,pc_updated,branch_pc_selector);
input [63:0] pc_updated,branched_pc;
output [63:0] next_pc;
input branch_pc_selector;
mux_2inp b(next_pc,pc_updated,branched_pc,branch_pc_selector);
endmodule


module MEM(read_output,memread,memwrite,data,result,branch,zero,next_pc,branched_pc,pc_updated);
input [63:0] branched_pc,pc_updated,data,result;
input zero;
input branch,memread,memwrite;
wire branch_pc_selector;
output [63:0] read_output,next_pc;
and(branch_pc_selector,branch,zero);
pc_generator p(next_pc,branched_pc,pc_updated,branch_pc_selector);
mem1 m(result,data,memread,memwrite,read_output);
endmodule

//MEM starts
module mem1(result,data,memread,memwrite,out);
input [63:0] result,data;
output [63:0] out;
reg out;
input memread,memwrite;

reg [31:0] data_memory[63:0][63:0];// 16 KB memory 2kb is reserved and 4 kb for instruction 10 kb for data


//memory initialisation
genvar i,j;
for(i=24;i<64;i=i+1) //this range is set for data entries
begin
    for (j=0;j<64;j=j+1)
    begin
always @(i,j)
begin
    data_memory[i][j] <= 0; // allotting 0 for all data inside the data section
end
    end
end

always @(memread or memwrite or result)
begin
     
  if(memwrite==1)
  begin
      data_memory[result>>8][(result/4)%64]<=data[63:32];
      data_memory[(result+4)>>8][((result+4)/4)%64]<=data[31:0];
  end
  if(memread==1)
  begin
    out<={data_memory[result>>8][(result/4)%64],data_memory[(result+4)>>8][((result+4)/4)%64]};
  end


end


endmodule
