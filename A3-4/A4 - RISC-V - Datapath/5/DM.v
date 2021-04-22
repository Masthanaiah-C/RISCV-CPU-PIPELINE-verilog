/*
member 1:
            Name : Masthanaiah Chintamani
            Roll : 191CS115
member 2:
            Name : LSV Sandeep 
            Roll : 191CS226

Module Name :
            date memory 

Date of creation : 26rd March,2021
Date of submission : 29th March,2021

*/

//datamemory module
module MEM(result,data,memread,memwrite,out);
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
      data_memory[result>>8][(result/4)%64]<=data[63:32];// to fetch 64 bit value we use consecutive 32 -bit values
      data_memory[(result+4)>>8][((result+4)/4)%64]<=data[31:0];
  end
  


end


endmodule

/*
module tb();
reg [63:0] result,data;
wire [63:0] out;
reg memread,memwrite;
MEM p(result,data,memread,memwrite,out);
initial
begin
    $monitor($time, ".result:%d ,data :%d,write :%b ,read :%b ,output :%d",result,data,memwrite,memread,out);
    #5 data=1;result=0;memwrite=1;memread=0;
    #5 data=1;result=0;memwrite=0;memread=1;
end

endmodule

*/


