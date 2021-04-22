/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME: test bench

    has only clk ,reset, pc_input and overflow as output 
*/

module tb();
reg reset;
reg [63:0] pc_input;
reg clk;
wire overflow;

initial 
begin
    clk=0;
    forever 
        #5 clk=~clk;
    
end
always @(reset )
begin
    if (reset==1)
    begin
        #5 reset=0;
    end

end
 pipeline p(pc_input,clk,reset,overflow);
initial begin
    //$monitor($time ," . pc :%d ,clk :%d",pc_input,clk);
     pc_input=3072;
    
    #600 $finish;
end

endmodule