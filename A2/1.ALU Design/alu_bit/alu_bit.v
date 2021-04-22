/*
member 1:
Name : Masthanaiah Chintamani
Roll : 191CS115
member 2:
Name : LSV Sandeep 
Roll : 191CS226

Date : 12th March,2021

Module Name : single bit alu design

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
// assign out = (c1) ? ~inp:inp;
endmodule

// the following module is not used here as inputs are sent as one invert to another that is implemented as mux (above)
//this may be used further in next assignments
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

//takes the 4 inputs and with the help of additional two control inputs  generates the output 
// here c is  a 2-bit control input 
module mux_2(out,inp,inp1,inp2,inp3,c);//mux 4:1
output out;
input  inp,inp1,inp2,inp3;
input  [1:0] c ;
//assign out = (inp & ~c[0] & ~c[1]) | (inp1 & (c[0]) & ~(c[1])) |(inp2 & ~(c[0]) & (c[1])) | (inp3 & (c[0]) & (c[1]));

// following structural code can be replaced with above commented assign statement to get the desired output
wire w1,w2; 
not(w1,c[0]);
not(w2,c[1]);
wire choc,choc1,choc2,choc3;
and(choc,w1,w2);
and(choc1,c[0],w2);
and(choc2,w1,c[1]);
and(choc3,c[0],c[1]);
wire out1,out2,out3,out4;
and(out1,choc,inp);
and(out2,choc1,inp1);
and(out3,choc2,inp2);
and(out4,choc3,inp3);
wire dis,dis2;
or(dis,out1,out2);
or(dis1,out3,out4);
or(out,dis1,dis);
endmodule

//full adder module having the inputs a ,b, carry_in generates output carry_out and sum
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
// single bit implementation taking the inputs a , b with help of carry in and left single bit inputs generating
// result of 64 -bit ,overflow flag ,zero check 
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





