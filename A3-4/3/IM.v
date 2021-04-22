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
    main_memory[i][j] <= $random;
end
    end
end
endmodule