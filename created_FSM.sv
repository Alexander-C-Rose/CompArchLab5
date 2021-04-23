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
     S1 = 4'd1,		// Read
     S2 = 4'd2,		// ReadMiss
     S3 = 4'd3,		// ReadMem
     S4 = 4'd4,		// ReadData
     S5 = 4'd5,		// Write
     S6 = 4'd6,		// WriteMiss
     S7 = 4'd7,		// WriteHit
	 s8 = 4'd8,		// WriteMem
	 s9 = 4'd9,		// WriteData
     Idle = 4'd10;	// Idle

   logic [3:0] CURRENT_STATE;
   logic [3:0] NEXT_STATE;
   

   always @(CURRENT_STATE or Strobe)
     begin
 	case(CURRENT_STATE)
	  Idle:	
	    if (Strobe == 1'b0)
	      begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  Idle;
	      end

		  else if  (Strobe == 1'b1 && RW == 1'b1)
		  begin
		 Z = 1'b0;
		 NEXT_STATE <=  S0;
		  end else begin
		  
	      end
	  
	  S1:	// Read
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  Idle;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S2;
	      end	

	  S2:	// ReadMiss
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  S1;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S3;
	      end	

	  S3:	// ReadMem
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  S4;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S0;
	      end	

	  S4:	// ReadData
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  Idle;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S5;
	      end	

	  S5:	// Write
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  S1;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S6;
	      end	

	  S6:	// WriteMiss
	    if (X == 1'b0)
	      begin
		 Z = 1'b0;
		 NEXT_STATE <=  S7;
	      end else begin
		 Z = 1'b0;
		 NEXT_STATE <=  S0;
	      end	

	  S7:	// WriteHit
	    if (X == 1'b0)
	      begin
		 Z = 1'b1;
		 NEXT_STATE <=  Idle;
	      end else begin
		 Z = 1'b1;
		 NEXT_STATE <=  S5;
	      end
	  
	  s8:	// WriteMem
		if (
		  end
	  s9:	// WriteData
		if (
		  end
	  
	  default: 
	    begin
	       NEXT_STATE <=  S0;
	       Z = 1'b0;	     
	    end
	  
	endcase // case (CURRENT_STATE)	
     end // always @ (CURRENT_STATE or X)

endmodule //fsm