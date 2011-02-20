
module TimingManager(input VSYNC, input HREF,input pclk,output reg Sig_En, output enC);
reg [8:0] line = 0;
reg [8:0] foo = 0;
//reg res = 0;
//reg enC = 1'b0;
//wire enD = pclk & enC;
//wire resHREF = res & HREF;
/*initial begin
	Sig_En <= 1'b1;
end*/
always @(posedge HREF or posedge VSYNC)begin
  if(HREF == 1'b1)line <= line +1'b1;
  else line = 8'h00;
  end
  /*
always @(pclk) begin
	if(Sig_En)Enasg <= 1'b1;
    else      Enasg <= 1'b0;*/
//	if(!pclk)begin

/*always @(negedge pclk)begin
		if ( HREF&enC ) foo <= foo + 1;
		else foo <= 7'b0000000;
end*/

assign enC = (line==9'h30 ) ? 1'b1 : 1'b0;

always @(posedge pclk)begin
		if ( HREF&enC ) foo <= foo + 1'b1;
		else foo <= 7'b0000000;
//---
		if(foo[0]&foo[8]&HREF)begin
			Sig_En<=1'b1;
//			res<=1'b1;
			foo <= 7'b0000000;
		end
		else begin
			Sig_En<=1'b0;
//			res<=1'b0;
		end
	end
endmodule

module Dtacutcmmit(
	input SigEn,
	input [7:0]pshdta,
	output WrCmplt,
	output reg [11:0]popdta
	);
	assign WrCmplt = ~SigEn;
	reg [3:0]redpx;
	always @(posedge SigEn)begin
		redpx [3:0] <= pshdta[3:0];
	end
	always @(negedge SigEn)begin
		popdta[11:0]<= { redpx[3:0], pshdta[7:0] };
	end
endmodule
/*
module memoryaddressor(input Enasg, input pclk, output  WEb, output reg BLEb, output reg BHEb, output [15:0] Address);
reg write_state = 0;
//wire state = 0;
//assign WEb = state | pclk;
reg [15:0] preAddress = 16'h0000;
assign Address = (WEb) ? 16'hzzzz : preAddress ;

assign WEb = ((~Enasg) & write_state) | pclk;

always@(posedge pclk)begin
		if(Enasg==1'b1)begin
				write_state <= 1'b0;
		end
		else if(write_state==1'b0)begin
				write_state <= write_state + 1'b1;
		end
		else write_state<=write_state;
end

always @(Enasg)begin
		BLEb <= (Enasg) ? 1'b0 : 1'b1;
		BHEb <= (Enasg) ? 1'b1 :1'b0;
	end
//	WideCounter w_count1(Enasg,1'h0,preAddress,1'h1);
always @(posedge Enasg)preAddress <= preAddress + 1'b1;
endmodule*/
/*
module memoryaddressor(input Sig_En, input pclk, output  WEb, output reg BLEb, output reg BHEb, output [15:0] Address);
reg write_state = 0;
//wire state = 0;
//assign WEb = state | pclk;
wire [15:0] preAddress;
assign Address = (WEb) ? 16'hzzzz : preAddress ;

assign WEb = ((~Sig_En) & write_state) | pclk;

always@(posedge pclk)begin
		if(Sig_En==1'b1)begin
				write_state <= 1'b0;
		end
		else if(write_state==1'b0)begin
				write_state <= write_state + 1'b1;
		end
		else write_state<=write_state;
end

always @(Sig_En)begin
		BLEb <= (Sig_En) ? 1'b0 : 1'b1;
		BHEb <= (Sig_En) ? 1'b1 :1'b0;
	end
	WideCounter w_count1(Sig_En,1'h0,preAddress,1'h1);
endmodule
*/
module InputLayer(
	input VSYNC,
	input HREF,
	input pclk,
	input [7:0]pshdta,
/*	input Req,
	input Greq,
	input Blreq,*/
/*	output [3:0]RedOt,
   output [3:0]GreOt,
   output [3:0]BluOt,
	output Remp,
	output Gemp,
	output Bemp*/
	output [11:0]PixParaBus,
	output SigEn,
	output enC,
	output Wrtcmplt
	);
/*
	InputsideQueueArray IQAentity(
		.pshdta ( PixParaBus[11:0] ),         //From TM
		.Wrtcmplt ( Wrtcmplt ),
	//Xe
		.Req ( Req ),
		.Greq ( Greq ),
		.Blreq ( Blreq ),
		.RedOt ( RedOt[3:0] ),
		.GreOt ( GreOt[3:0] ),
		.BluOt ( BluOt[3:0] ),
		.Remp ( Remp ),
		.Gemp ( Gemp ),
		.Bemp ( Bemp )
		);*/
	Dtacutcmmit DataCommit(
		.SigEn ( SigEn ),
		.pshdta ( pshdta[7:0] ),
		.WrCmplt ( Wrtcmplt ),
		.popdta ( PixParaBus[11:0] )
		);

	TimingManager timemanager(VSYNC, HREF, pclk, SigEn,enC);
endmodule
