// test bench for the alu control 

module t();

reg [1:0] op;
wire [3:0] operation;
reg [5:0] func;

control c(func,op,operation);

initial begin
    $dumpfile("alu_control.vcd");
    $dumpvars(0,t);
    $monitor($time,". op:%b,funct:%b,operation:%b",op,func,operation);

    #5 op=2'b00;func=6'b000000; $display("ld,sd type");
    #5 op=2'b01;func=6'b000000; $display("branch type");
    #5 op=2'b10;func=6'b000000; $display("r-type  add");
    #5 op=2'b10;func=6'b000010; $display("r-type subtract");
    #5 op=2'b10;func=6'b000100; $display("r-type and");
    #5 op=2'b10;func=6'b000101; $display("r-type or");
    #5 op=2'b10;func=6'b001010; $display("r-type setless than");
end
endmodule
