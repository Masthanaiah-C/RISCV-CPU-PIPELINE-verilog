module r_type();

wire [63:0] result;
wire overflow,zero;
reg [31:0] instruction;
reg [1:0] op;

reg [5:0] func;
reg mux;

reg write_control;
wire [63:0] out1,out2,imm;


 IDc id(write_control,result,instruction,out1,out2,imm);
 exe x(out1,out2,func,op,overflow,zero,result,mux,imm);

initial begin

$dumpfile("r-type.vcd");
$dumpvars(0,r_type);

    $monitor($time ," . result :%d , op :%d,func :%b ",result,op,func);
    #5 instruction=32'b00000000001100001000001000110011;write_control=1;op=2'b10;func=6'b000000;mux=0; $display("r-type addition between 56 and 47");
    #5 instruction=32'b01000000001100001000001000110011;write_control=1;op=2'b10;func=6'b000010;mux=0; $display("r-type subtraction between 56 and 47");
    #5 instruction=32'b00000000001100001000001000110011;write_control=1;op=2'b10;func=6'b000100;mux=0; $display("r-type and between 56 and 47");
    #5 instruction=32'b00000000001100001000001000110011;write_control=1;op=2'b10;func=6'b000101;mux=0; $display("r-type or between 56 and 47");
    #5 instruction=32'b00000000011100001000001000010011;write_control=1;op=2'b10;func=6'b000000;mux=1; $display("r-type addition immediate between 56 and 3 ");
    #5 instruction=32'b11111111111100001000001000010011;write_control=1;op=2'b10;func=6'b000000;mux=1; $display("r-type addition immediate between 56 and -1");
    #5 instruction=32'b00000000011100001000001000010011;write_control=1;op=2'b10;func=6'b000010;mux=1; $display("r-type subraction immediate between 56 and 3 ");
    #5 instruction=32'b11111111111100001000001000010011;write_control=1;op=2'b10;func=6'b000010;mux=1; $display("r-type subraction immediate between 56 and -1");

    #5 $finish;
end
endmodule
