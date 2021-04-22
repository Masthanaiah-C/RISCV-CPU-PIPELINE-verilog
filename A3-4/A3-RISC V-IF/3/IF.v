module adder(pc,incremented_pc);
input [63:0] pc;
output [63:0] incremented_pc;
assign incremented_pc=pc+4;
endmodule


module IF(instruction,reset,pc_input,pc_updated,clk,pc);
input reset;
input [63:0] pc_input;
output [31:0] instruction;
input clk;
output reg [63:0] pc;
output reg [63:0] pc_updated;
wire [63:0] out;
IM memory_fetch(pc,instruction);
adder upd(pc,out);


always @(pc_input) // if pc input changes the register pc is updated
begin
    pc<=pc_input;
end
always @(pc) // when ever pc is changed then the pc is incremented and stored inside the pc_updated 
begin
    pc_updated<=out;
end

always @(clk)  // when there is any change in clk or reset following statements are executed
begin
    if(clk==1)
    begin
        pc <= out;
    end
        
    if(reset==1)
    begin
        pc <=pc_input; //reset to the value to the initial pc value pc_input
    end
    
end

initial begin
    $dumpfile("IF.vcd"); // taking the vcd file 
    $dumpvars(0,IF);
end


endmodule
