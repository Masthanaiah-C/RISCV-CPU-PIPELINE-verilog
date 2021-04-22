//test bench for the single bit alu


module tb();

reg a,b,ain,bin,left,cin;
reg [1:0] c;
wire result,cout;

alu_d z(result,a,b,ain,bin,cin,c,cout,left);

initial begin
    $dumpfile("alu_bit.vcd");
    $dumpvars(0,tb);

$monitor($time,".result: %b, a:%b, b:%b, a_inv:%b, b_inv:%b, carry_in:%b, left:%b, carry_out:%b,control :%b",result,a,b,ain,bin,cin,left,cout,c);

        #5  $display("or gate  "); a=1;b=0;ain=0;bin=0;c=1;  // or gate
           #5  $display("and gate  "); a=1;b=0;ain=0;bin=0;c=0;   //and gate
           #5  $display("nand gate  "); a=0;b=1;ain=1;bin=1;c=0;   // nand gate
           #5  $display("nor gate  "); a=0;b=0;ain=1;bin=1;c=1;   //nor gate
           #5  $display("subtration  "); a=0;b=1;ain=0;bin=1;c=2; cin=1;  //sub
           #5  $display("sum  "); a=1;b=1;ain=0;bin=0;c=2;   cin=0;        //sum
           #5  $display("zero check  "); a=0;b=0;ain=0;bin=0;c=2;     //zero
           #5  $display("slt check  "); a=0;b=1;ain=0;bin=1;c=3;cin=1;left=0;   //slt it is useful in 64-bit alu 
		#5  $display("slt check  "); a=0;b=1;ain=0;bin=1;c=3;cin=1;left=1;	
	   #10 $finish;
   end

endmodule
