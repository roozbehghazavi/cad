module full_adder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);

endmodule 

module ripple_carry_adder_subtractor(S, C, V, A, B, Op);
   output [3:0] S;   // The 4-bit sum/difference.
   output 	C;   // The 1-bit carry/borrow status.
   output 	V;   // The 1-bit overflow status.
   input [3:0] 	A;   // The 4-bit augend/minuend.
   input [3:0] 	B;   // The 4-bit addend/subtrahend.
   input 	Op;  // The operation: 0 => Add, 1=>Subtract.
   
   wire 	C0,C1,C2,C3;
   wire 	B0,B1,B2,B3; 

   xor(B0, B[0], Op);
   xor(B1, B[1], Op);
   xor(B2, B[2], Op);
   xor(B3, B[3], Op);
   xor(C, C3, Op);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
   xor(V, C3, C2);     // If the two most significant carry output bits differ, then we have an overflow.
   
   full_adder fa0(S[0], C0, A[0], B0, Op);    // LSB
   full_adder fa1(S[1], C1, A[1], B1, C0);
   full_adder fa2(S[2], C2, A[2], B2, C1);
   full_adder fa3(S[3], C3, A[3], B3, C2);    // MSB

endmodule 



	
