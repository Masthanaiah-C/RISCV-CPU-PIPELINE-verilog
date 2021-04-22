/*
member 1:
            Name : Masthanaiah Chintamani
            Roll : 191CS115
member 2:
            Name : LSV Sandeep 
            Roll : 191CS226

module name : ALU CONTROL UNIT

Date of creation : 25rd March,2021
Date of submission : 29th March,2021
*/

// alu  control module 
// this design  is taken from the riscv  book specified in the instruction
module control(func,op,operation);
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

