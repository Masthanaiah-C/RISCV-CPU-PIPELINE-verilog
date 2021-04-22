/*
member 1:
Name : Masthanaiah Chintamani
Roll : 191CS115
member 2:
Name : LSV Sandeep 
Roll : 191CS226

Date : 12th March,2021

generates 64-bit ALU
*/

//mux 2:1 which take only one input and make 2 inputs internally one the input and other its inverse and depending on the control 
module mux(out,inp,c1);  //mux develop the a,invert of a with help of the control
output out;
input inp, c1;
wire n_inp;
not(n_inp,inp);
wire temp,temp1;
wire c1_not;
not(c1_not,c1);
and(temp,c1_not,inp);
and(temp1,c1,n_inp);
or(out,temp,temp1);
endmodule

/*
//the following module is not used here as we used mux 2:1 only for invertion of the input so it is embedded in the above module 
//this is implemented for the furthur use
module mux_2inp(out,inp,inp1,c); //mux take 2 inputs and give one output with help of one control input
output out;
input inp,inp1,c;
wire c_inv;
not(c_inv,c);
wire and1,and2;
and(and1,c_inv,inp);
and(and2,c,inp1);
or(out,and1,and2);
endmodule
*/
//mux 4:1  will take 4 inputs and 2-bit control generate single output
module mux_2(out,inp,inp1,inp2,inp3,c);
output out;
input  inp,inp1,inp2,inp3;
input  [1:0] c ;
assign out = (inp & ~c[0] & ~c[1]) | (inp3 & (c[0]) & (c[1]))|(inp2 & ~(c[0]) & (c[1])) | (inp1 & (c[0]) & ~(c[1])) ;
// following structural code can be replaced with above  assign statement to get the same desired output
//wire w1,w2; 
//not(w1,c[0]);
//not(w2,c[1]);
//wire choc,choc1,choc2,choc3;
//and(choc,w1,w2);
//and(choc1,c[0],w2);
//and(choc2,w1,c[1]);
//and(choc3,c[0],c[1]);
//wire out1,out2,out3,out4;
//and(out1,choc,inp);
//and(out2,choc1,inp1);
//and(out3,choc2,inp2);
//and(out4,choc3,inp3);
//wire dis,dis2;
//or(dis,out1,out2);
//or(dis1,out3,out4);
//or(out,dis1,dis);
endmodule


//full adder take 3 inputs two operands and carry_in generating carry_out and sum value
module adder_full(cout,sum,a,b,cin); //full addder 
input a,b,cin;
output cout,sum;
wire w1;
xor(w1,a,b);
xor(sum,w1,cin);
//assign cout = a&b|a&cin|cin&b;
wire o1,o2;
and(o1,a,b);
and(o2,w1,cin);
or(cout,o1,o2);
endmodule


//main module of alu take the a ,b ,
//4-bit having ain for a_invert mux al, bin for b_invert mux b1, and 2 -bit mux control for m2
//carry_in,left
//giving carry_out,result 

module alu_d(result,a,b,ain,bin,cin,c,cout,left); //1-bit alu 
input a,b,ain,bin,left,cin;
input [1:0] c;
output result,cout;
wire w1,w2,w3;
mux a1(w1,a,ain);
mux b1(w2,b,bin);
wire o,ad;
and(ad,w1,w2);
or(o,w1,w2);
adder_full q(cout,w3,a,w2,cin);
mux_2 m2(result,ad,o,w3,left,c);
endmodule


//check the overflow by takig the inputs a,b,carry_out,result and give flag value
// we use a,b,result to generate carry in through odd function implemented with help of xor gates

module overflow1(a,b,r,cout,flag); //overflow control
input a,b,r,cout;
output flag;
xor(a1,a,b);
wire cin;
xor(cin,a1,r);
//assign flag=(cin!=cout)?1:0;
xor(flag,cin,cout);
endmodule


//making an 64-bit alu by combinig them all
//inputs :64-bit a(input),b(input)

module bit_64(a,b,ALUop,result,overflow,zero);
input [63:0] a,b;
output [63:0] result;
output overflow,zero;
input [3:0] ALUop;

wire [63:0]carry_out;

//wire [62:0] con;
//assign con=carry_out[62:0];
wire set;
alu_d alus[63:0](result,a,b,ALUop[3],ALUop[2],{carry_out[62:0],ALUop[2]},{ALUop[1:0]},carry_out[63:0],{63'b0,set}); //64-bit contigous alu alllocation of single bit alu
wire a1,b1;
mux m1(a1,a[63],ALUop[3]);
mux m2(b1,b[63],ALUop[2]);
overflow1 of(a1,b1,carry_out[62],carry_out[63],overflow);
xor(set,overflow,result[63]);
assign zero=(result)?0:1; //used a behavioural code instead of 64-bit nor gate 
endmodule

