/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME:INSTRUCTION FETCH STAGE
    Contains
        1) pc
        2) main memory


*/

// instruction fetch
module adder(pc,incremented_pc);
input [63:0] pc;
output [63:0] incremented_pc;
assign incremented_pc=pc+4;
endmodule

module IF(instruction,reset,pc_input,pc_updated,clk,pc,next_pc);
input reset;
input [63:0] pc_input;
output [31:0] instruction;
input clk;
output reg [63:0] pc;
output reg [63:0] pc_updated;
input [63:0] next_pc;
wire [63:0] out;
IM memory_fetch(pc,instruction);
adder upd(pc,out);


always @(pc) // when ever pc is changed then the pc is incremented and stored inside the pc_updated 
begin
    pc_updated<=out;
    
end
always @(posedge clk or reset )  // when there is any change in clk or reset following statements are executed
begin
    if(clk==1)
    begin
        pc <= next_pc;
        
    end
        
    if(reset==1)
    begin
        pc <=pc_input; //reset to the value to the initial pc value pc_input
    end 
end
    always @(pc_input)
    begin
        pc<=pc_input;
    end



endmodule

module IM(pc,instruction);
input [63:0] pc;
output reg [31:0] instruction;

// main_memory
//size 16 kb
// stack + heap has 10 kb [ also called data memory ]
// instruction memory is 4 kb
// reserved section is 2 kb 
reg [31:0] main_memory[63:0][63:0];
                                // as soon as the pc changes the instruction will be fetched
always @(pc)
begin
    if(pc>=6144 || pc <2048)    //check the limit of the data section 
    begin
        $display("trap ");
        instruction=32'bx;
    end
    else begin                  //fetch 2 words; as each instruction hold 64 bit;
        instruction={main_memory[(pc>>8)][(pc/4)%64]};
     end
end
                                //memory initialisation
genvar i,j;
for(i=0;i<64;i=i+1)             //this main_memory has the random values throughout
begin
    for (j=0;j<64;j=j+1)
    begin
always @(i,j)
begin
    if(i==12 && j<64)
    begin
      // enter your code upto 64 instructions
      
      main_memory[i][0] <= 32'b00000110010000000000000010010011; //addi x1,x0,100;
      main_memory[i][1] <= 32'b01000000000000000000010100010011; //addi x10,x0,1024
      main_memory[i][2] <= 32'b00000000101001010000010100110011; //add x10,x10,x10
      main_memory[i][3] <= 32'b01000000000001010000010100010011; //addi x10,x10,1024
      main_memory[i][4] <= 32'b00000000101001010000010100110011; //add x10,x10,x10
      main_memory[i][5] <= 32'b00000000000101010000000000100011; //sd x1,0(x10);
      main_memory[i][6] <= 32'b00000000000001010000000100000011; //ld x2,0(x10);
      main_memory[i][7] <= 32'b00000000001000001000000110110011; //add x3,x1,x2;
      main_memory[i][8] <= 32'b01000000001000001000000110110011; //sub x3,x1,x2;
      main_memory[i][9] <= 32'b00000000001000001110000110110011; //or x3,x1,x2
      main_memory[i][10] <=32'b00000010101001010000000001100011; //beq x10,x10,16
    end
    else begin
        main_memory[i][j] <= $random;
    end
    
end
    end
end
endmodule
// IF ends