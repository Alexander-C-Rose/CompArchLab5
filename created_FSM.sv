module created_FSM(clk, reset, Strobe, RW, M, V, CtrSig, LdCtr, RdyEn, Rdy, W, MStrobe, MRW, Wsel, RSel);
	
	input logic clk;
	input logic reset;
	input logic Strobe;
	input logic RW;
	input logic M;
	input logic V;
	input logic CtrSig;
	
	output logic LdCtr;
	output logic RdyEn;
	output logic Rdy;
	output logic W;
	output logic MStrobe;
	output logic MRW;
	output logic RSel;
	output logic Wsel;
	
	parameter [3:0] S0 = 4'd0,
     S1 = 4'd1,		// Read
     S2 = 4'd2,		// ReadMiss
     S3 = 4'd3,		// ReadMem
     S4 = 4'd4,		// ReadData
     S5 = 4'd5,		// Write
     S6 = 4'd6,		// WriteMiss
     S7 = 4'd7,		// WriteHit
	 S8 = 4'd8,		// WriteMem
	 S9 = 4'd9,		// WriteData
     Idle = 4'd10;	// Idle

   logic [3:0] CURRENT_STATE;
   logic [3:0] NEXT_STATE;
   
   always @(posedge clk)
     begin
	if (reset == 1'b1)	
	  CURRENT_STATE <=  Idle;
	else
	  CURRENT_STATE <=  NEXT_STATE;
    end

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
	      end else if  (Strobe & RW) begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S5;
	      end else if (Strobe == 1'b1 & RW == 1'b0) begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S1;
		  end
		 //maybe add end here? who knows?
	  
	  S1:	// Read
	    if ((M & V) == 1'b0)
	      begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b1;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S2;
	      end else begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b1;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <= Idle;
		  end

	  S2:	// ReadMiss
	    if (1)
	    begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b1;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S3;
	    end 	

	  S3:	// ReadMem
	    if (CtrSig)
	    begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S4;
	    end else if(~CtrSig) begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S3;
	    end	

	  S4:	// ReadData
	    if (1)
	     begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b1;
		 W       = 1'b1;
		 MStrobe = 1'b0;
		 MRW     = 1'b1;
		 Wsel    = 1'b1;
		 RSel    = 1'b0;
		 NEXT_STATE <=  Idle;
	    end 	

	  S5:	// Write
	    if ((M & V) == 1'b0)
	      begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S6;
	      end else begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S7;
	      end	

	  S6:	// WriteMiss
	    if (1)
	      begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b1;
		 MRW     = 1'b1;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S8;
	      end 	

	  S7:	// WriteHit
	    if (1)
	      begin
		 LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b1;
		 MRW     = 1'b1;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S8;
	      end 
	  
	  S8:	// WriteMem
		if (CtrSig)
		  begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b1;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S9;
		  end else begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b1;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
		 NEXT_STATE <=  S8;
		  end
		  
		  
	  S9:	// WriteData
		if (1)
		  begin
		 LdCtr   = 1'b0;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b1;
		 W       = 1'b1;
		 MStrobe = 1'b0;
		 MRW     = 1'b1;
		 Wsel    = 1'b0;
		 RSel    = 1'b1;
		 NEXT_STATE <=  Idle;
		  end
	  
	  default: 
	    begin
	      NEXT_STATE <=  Idle;
	     LdCtr   = 1'b1;
		 RdyEn   = 1'b0;
		 Rdy     = 1'b0;
		 W       = 1'b0;
		 MStrobe = 1'b0;
		 MRW     = 1'b0;
		 Wsel    = 1'b0;
		 RSel    = 1'b0;
	    end
	  
	endcase // case (CURRENT_STATE)	
    end // always @ (CURRENT_STATE or X)

	endmodule //fsm