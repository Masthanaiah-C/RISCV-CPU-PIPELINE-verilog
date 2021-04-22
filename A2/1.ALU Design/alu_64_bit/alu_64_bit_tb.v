// test bench for the alu_64_bit 


module test();
reg [63:0] a,b;
wire [63:0] result;
wire overflow,zero;
reg [3:0] ALUop;

reg carry_in;


//initiation

bit_64  y(a,b,ALUop,result,overflow,zero);
  

initial 
    begin
        $dumpfile("64_bit_alu.vcd");
        $dumpvars(0,test);
    repeat(2)
    
    $monitor($time , ".result :%d , a:%d ,b:%d,op :%b,   overflow :%b,zero :%b",result,a,b,ALUop,overflow,zero);
    
           #5  $display("or gate  "); a=45;b=44;ALUop=4'b0001;  // or gate
           #5  $display("and gate  "); a=45;b=44;ALUop=4'b0000;   //and gate
           #5  $display("nand gate  "); a=45;b=44;ALUop=4'b1100;   // nand gate
           #5  $display("nor gate  "); a=45;b=44;ALUop=4'b1101;   //nor gate
           #5  $display("subtration  "); a=0;b=1;ALUop=4'b0110;   //sub
           #5  $display("sum  "); a=45;b=44;ALUop=4'b0010;           //sum
           #5  $display("zero check  "); a=0;b=0;ALUop=4'b0110;     //zero
           #5  $display("slt check  "); a=0;b=1;ALUop=4'b0111 ;    //slt

        
        #100    $finish;
end

endmodule
