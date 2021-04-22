/*
member 1
name: Chintamani Masthanaiah
roll number :191cs115

member 2 
name : LSV sandeep margana
roll number :191cs226

MODULE NAME: CONTROL UNIT (includes both main control and alu control)

*/




module main_control(opcode,func7,func3,ALUSrc,MemtoReg,Regwrite,MemWrite,Memread,Branch,operation);
input [6:0] opcode;
input [6:0] func7;
input [2:0] func3;
output reg ALUSrc,MemtoReg,Regwrite,MemWrite,Memread,Branch;
reg [1:0] op;
output [3:0] operation;
reg [5:0] func;
//502
always @(opcode)
begin
    if (opcode==7'b0110011)      //r-type
    begin
   
        ALUSrc = 0;
        MemtoReg = 0;
        Regwrite=1;
        Memread=0;
        MemWrite=0;
        Branch = 0;
        op=2'b10;
        
    end
    if(opcode==7'b0000011)     // ld
    begin
    $display("load -type");
         ALUSrc = 1;
         MemtoReg=1;
         Regwrite=1;
         Memread=1;
         MemWrite=0;
         Branch = 0;
         op=2'b00;
    end
    if(opcode==7'b0100011)     // sd
    begin
    $display("store-type");
         ALUSrc = 1;
         MemtoReg=0;
         Regwrite=0;
         Memread=0;
         MemWrite=1;
         Branch = 0;
         op=2'b00;
    end
    if (opcode==7'b1100011)    //beq
       begin
       $display("branch-type");
         ALUSrc = 0;
         MemtoReg=0;
         Regwrite=0;
         Memread=0;
         MemWrite=0;
         Branch = 1;
         op=2'b01;
       end
    if(opcode==7'b0010011)   // i type
    begin
    
         ALUSrc = 1;
         MemtoReg=0;
         Regwrite=1;
         Memread=0;
         MemWrite=0;
         Branch = 0;
         op=2'b10;   
    end 
end  
    
always @(func7 or func3 or opcode)
begin
 case (opcode)
   7'b0110011://r-type
   begin
      $display("r-type");
      if(func3==3'b000 && func7==7'b0) //addition
      begin
      $display("add");
        func=6'b0;
      end
      if(func3==3'b000 && func7==7'b0100000) //subtraction
      begin
      $display("sub");
        func=6'b000010;
      end
      if(func3==3'b110 && func7==7'b0) //or
      begin
      $display("or");
        func=6'b000101;
      end
      if(func3==3'b111 && func7==7'b0) //and
      begin
      $display("and");
        func=6'b000100;
      end
      if(func3==3'b010 && func7==7'b0) //set less than
      begin
      $display("set less than");
        func=6'b001010;
      end  
  
   end
   7'b0010011:
   begin
     $display("i-type");
     if(func3==3'b000 ) //addition
      begin
      $display("add");
        func=6'b0;
      end
      if(func3==3'b010) //subtraction
      begin
      $display("sub");
        func=6'b000010;
      end
      if(func3==3'b110 ) //or
      begin
        func=6'b000101;
      end
      if(func3==3'b111 ) //and
      begin
        func=6'b000100;
      end
      if(func3==3'b010 ) //set less than
      begin
        func=6'b001010;
      end  
   end
   
 endcase
end

alu_control c(func,op,operation);

endmodule

module alu_control(func,op,operation);
input [1:0] op;
output [3:0] operation;
input [5:0] func;
wire w0;
not(w0,op[0]);
and(operation[3],w0,op[0]);
wire w1;
and(w1,op[1],func[1]);
or(operation[2],w1,op[0]);
wire w2,w3,w4;
not(w3,op[1]);
not(w4,func[2]);
or(operation[1],w3,w4);
or(w2,func[3],func[0]);
and(operation[0],op[1],w2);
endmodule
//create a test bench
