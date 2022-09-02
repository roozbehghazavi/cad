module jkstruct(j,k,clk,q,qbar);

input j,k,clk;

output q,qbar;

wire x,y,w,z;

assign w=q;

assign z=qbar;

nand n1(x,z,j,clk);

nand n2(y,k,w,clk);

nand n3(q,x,z);

nand n4(qbar,y,w);

endmodule