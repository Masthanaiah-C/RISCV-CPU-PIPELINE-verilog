module reg_file(r1,r2,w,wd,out1,out2,write_control);
input [4:0] r1,r2,w;
input write_control;
output [63:0] out1,out2;
input [63:0] wd;

reg [63:0] file [31:0];
// change the below  values with desired ones
initial
begin
    file[0]=0;
    file[1]=6000;
    file[2]=0;
    file[3]=1470;
    file[4]=0;
    file[5]=0;
    file[6]=0;
    file[7]=0;
    file[8]=0;
    file[9]=0;
    file[10]=0;
    file[11]=0;
    file[12]=0;
    file[13]=0;
    file[14]=0;
    file[15]=0;
    file[16]=0;
    file[17]=0;
    file[18]=0;
    file[19]=0;
    file[20]=0;
    file[21]=0;
    file[22]=0;
    file[23]=0;
    file[24]=0;
    file[25]=0;
    file[26]=0;
    file[27]=0;
    file[28]=0;
    file[29]=0;
    file[30]=0;
    file[31]=0;
    

end

assign out1=file[r1];
assign out2=file[r2];

    always @(wd) begin
        if(write_control==1)
        file[w]<=wd;
    end

endmodule
