module IF_tb();

reg reset;
reg [63:0] pc_input;
wire [63:0] pc_now,pc_updated;
wire [31:0] instruction;
reg clk;
/*module instantiation*/

IF if1(instruction,reset,pc_input,pc_updated,clk,pc_now);

initial begin
    clk =0;
    forever 
    #5 clk<=~clk;
end
always @(reset )
begin
    if (reset==1)
    begin
        #5 reset=0;
    end

end
/*stimulus*/


initial begin
    pc_input=2000;
    $monitor($time," .  pc value :%d, updated pc_value :%d ,instruction fetched :%b ,reset :%b",pc_now,pc_updated,instruction,reset);
    #50 pc_input=3000;$display("changing value of pc to 3000");
    #20 reset=1; $display ("reset is enabled");
    #40 reset=1; $display ("reset is enabled");
    #20 reset=0;
    #40 pc_input=6100;$display("changing value of pc to 6100");
    #100 reset=0;
    #10 $finish;
end

endmodule
