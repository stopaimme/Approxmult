module Log_mult(
    input wire[15:0]A,B,
    output wire[31:0]OUT
    );
    wire [15:0] NA,NB;
    wire [15:0] SA,SB;
    wire [3:0]  PA,PB;
    wire [4:0]  AA;
    wire [31:0] DA;
    wire [31:0] SHA,SHB;
    wire [31:0] DAA;
    wire sign;
    wire [31:0] Y;
    wire [31:0]sig;
    
    if_zero(.A(A),.B(B),.sig(sign));
    NOD N1(.income(A),.outcome(NA));
    NOD N2(.income(B),.outcome(NB));
    
    p_encode p1(.a(NA[15:1]),.out(PA));
    p_encode p2(.a(NB[15:1]),.out(PB));
    
    adder_5bout a1(.a(PA),.b(PB),.ci(1'b0),.s(AA));
    
    sub s1(.a(A),.diff(NA),.s(SA),.co());
    sub s2(.a(B),.diff(NB),.s(SB),.co());
    
    shifter sh1(.data_in(SA),.select(PB),.data_out(SHA));
    shifter sh2(.data_in(SB),.select(PA),.data_out(SHB));
    
    adder_32bits a2(.a(SHA),.b(SHB),.ci(1'b0),.s(DAA),.co());
    
    decode d1(.A(AA),.Y(DA));
    adder_32bits a3(.a(DA),.b(DAA),.ci(1'b0),.s(Y),.co());
    
    assign sig ={32{sign}};
    
    assign OUT = sig & Y;
    
endmodule
