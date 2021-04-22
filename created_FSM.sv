module fsm(Strobe, RW, M, V, CtrSig, LdCtr, RdyEn, Rdy, W, MStrobe, MRW, Wsel, RSel);
	
	input logic Strobe;
	input logic RW
	input logic M
	input logic V
	input logic CtrSig
	
	output logic LdCtr
	output logic RdyEn
	output logic Rdy
	output logic W 
	output logic MStrobe
	output logic MRW
	output logic RSel
	
	parameter [3:0] S0 = 4'd0,
     S1 = 4'd1,
     S2 = 4'd2,
     S3 = 4'd3,
     S4 = 4'd4,
     S5 = 4'd5,
     S6 = 4'd6,
     S7 = 4'd7,
     Idle = 4'd8;

   logic [3:0] CURRENT_STATE;
   logic [3:0] NEXT_STATE;

endmodule //fsm