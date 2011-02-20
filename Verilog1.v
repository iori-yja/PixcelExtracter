
/////////////////////Counter is above. below is InputHandleField field
//module MemoryaddrBridge(input VSYNC, input HREF,input pclk,output reg Sig_En,output reg enC, output[7:0] line, output [7:0] foo);

module clkdivider (input clk, output xclk);
	reg [1:0] t_count = 0;
	always@(posedge clk) t_count[0] <= ~t_count[0];
	always@(posedge t_count[0]) t_count[1] <= ~t_count[1];
	assign xclk = t_count[1];
endmodule

////////////////////////////////////////////////

module ReShynth (
	input 	clk,
	input 	pclk,
	input 	HREF,
	input 	VSYNC,
	input		Serck,
//	output	Serctl,
	output	Serot,
//	input 	[7:0]pixdata,
	output 	xclk,
	output	[11:0]PixParaBus,
	output enasg,
	output TEST2,
	output reg TEST3 = 0,
	output nData,
	output NREFbg,
	output NVSYNCbg
	/*, output WEb, output BLEb,output BHEb */);
//wire Sig_En;
//wire WEbpre;
//assign WEb = WEbpre | clk;
//wire Req,Greq,Blreq;
//wire [3:0]RedOt,GreOt,BluOt;
//wire Remp,Gemp, Bemp;
wire Wrtcmplt;
assign NREFbg = ~HREF;
assign NVSYNCbg = ~VSYNC;
wire [7:0]pixdata;
assign pixdata = 8'he0;
//assign Serctl = | {Remp, Gemp, Bemp};
always @(posedge enasg)TEST3 <= ~TEST3;
assign nData = ~ pixdata[1];
wire dummy;
assign PixParaBus[0] = VSYNC;
InputLayer ILE (
	.VSYNC 	( VSYNC ),
	.HREF 	( HREF ),
	.pclk		( pclk ),
	.pshdta	( pixdata[7:0] ),
//	.PixParaBus ( { PixParaBus[11:1], dummy } ),
	.PixParaBus ( { PixParaBus[11],PixParaBus[8],PixParaBus[5],PixParaBus[2],PixParaBus[10],PixParaBus[7],PixParaBus[4],PixParaBus[1],PixParaBus[9],PixParaBus[6],PixParaBus[3], dummy } ),
	.Wrtcmplt( Wrtcmplt ),
	.SigEn	(enasg),
	.enC		(TEST2)
/*	.Req		( Req ),
	.Greq		( Greq ),
	.Blreq	( Blreq ),
	.RedOt	( RedOt ),
   .GreOt	( GreOt ),
   .BluOt	( BluOt ),
	.Remp		( Remp ),
	.Gemp		( Gemp ),
	.Bemp		( Bemp )*/
	);

transmittr transmitter(
	.Srialclk( Serck ),
	.Wrtcmplt( Wrtcmplt ),
	.data( PixParaBus ),
	.SrialData( Serot )
	);

		
clkdivider clkdivider0(clk,xclk);
endmodule
//OutputBulkSerialDriver oBSD(
/*OutputBulkSerialDriver oBSD(
	.Serck ( Serck ),
	.Serot( Serot ),
	.Req( Req ),
	.Greq( Greq ),
	.Blreq( Blreq ),
	.RedOt( RedOt ),
	.GreOt( GreOt ),
	.BluOt( BluOt )
	);	*/
///////////////******************************MAIN(TOP CIRCCUIT)********************************/////////////////
//module MemoryaddrBridge (input clk, input pclk,input HREF,input VSYNC, output xclk, output WEb, output BLEb,output BHEb, output [15:0] SRAM_address,output Sig_En );
//wire Sig_En;
//wire WEbpre;
//assign WEb = WEbpre | clk;
//TimingManager timemanager(VSYNC, HREF, pclk, Sig_En);
//memoryaddressor menaddr(Sig_En,  pclk, WEb,  BLEb, BHEb, SRAM_address);
//musimixesim:/TESTr musxer(clk, WEb, SRAM_address
