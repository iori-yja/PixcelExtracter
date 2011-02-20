////////////////////////////////////////////////////////////////////////////////////
/*Signal Extraction Layer*/
module Sendbridge (
	input clk,
	input pclk,
	input [15:0]Pushin,
	input Req,
	input SIO
	);
endmodule
////////////////////////////////////////////////////


module InputsideQueueArray (
	input [11:0]pshdta,
	input Wrtcmplt,

	input Req,
	input Greq,
	input Blreq,
	output [3:0]RedOt,
	output [3:0]GreOt,
	output [3:0]BluOt,
	output Remp,
	output Gemp,
	output Bemp
);
	wire [3:0]Redin = pshdta[11:8];
	wire [3:0]Grein = pshdta[7:4];
	wire [3:0]Bluin = pshdta[3:0];


	wire 	Rful,
			Gful,
			Bful;

	Queue Queue_Red (
		.wrclk ( Wrtcmplt ),
		.rdclk ( Req ),
		.data ( Redin[3:0] ),
		.rdreq ( Req ),
		.wrreq ( Wrtcmplt ),
		.rdempty ( Remp ),
		.wrfull ( Rful ),
		.q ( RedOt[3:0] )
	);

	Queue Queue_Gre (
		.wrclk ( Wrtcmplt ),
		.rdclk ( Greq ),
		.data ( Grein[3:0] ),
		.rdreq ( Greq ),
		.wrreq ( Wrtcmplt ),
		.rdempty ( Gemp ),
		.wrfull ( Gful ),
		.q ( GreOt[3:0] )
);

	Queue Queue_Blu (
		.wrclk ( Wrtcmplt ),
		.rdclk ( Blreq ),
		.data ( Bluin[3:0] ),
		.rdreq ( Blreq	 ),
		.wrreq ( Wrtcmplt ),
		.rdempty ( Bemp ),
		.wrfull ( Bful ),
		.q ( BluOt[3:0] )
	);

endmodule


module OutputBulkSerialDriver(
	input		Serck,
 output reg Serot,
	output	Req,
	output	Greq,
	output	Blreq,
	input		[3:0]RedOt,
   input		[3:0]GreOt,
   input		[3:0]BluOt
);
	wire [11:0]RingVr;
	wire [11:0]MxdS = { RedOt[3], GreOt[3], BluOt[3], RedOt[2], GreOt[2], BluOt[2], RedOt[1], GreOt[1], BluOt[1] };
	reg  [10:0]Ringff;

	assign RingVr[0] = ~| Ringff;
	assign RingVr[11:1]= Ringff;
	assign Req	= RingVr[0];
	assign Blreq= RingVr[0];
	assign Greq	= RingVr[0];

	always@(negedge Serck)begin
//		if(Serck == 1'b0)begin
			Ringff	<= Ringff << 1;
			Ringff[0]<= RingVr[0];
//			Serot <= Serot;
//		end
	end
//		else begin
	always@(posedge Serck)begin
//			Ringff<= Ringff;
			Serot <= | (MxdS & RingVr);
		end
//	end
endmodule

/*
module ByteCounter(input ck,input res, output [7:0] Val,input enable);
reg [7:0] q;
initial q <= 8'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+8'h1;
	else
		q<=8'h0;
end
assign Val = (enable==1'b1) ? q : 8'b0;
endmodule

module tinyCounter(input ck,input res, output [1:0] Val,input enable);
reg [1:0] q;
initial q <= 2'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+2'h1;
	else
		q<=2'h0;
end
assign Val = (enable) ? q : 2'b0;
endmodule

module WideCounter(input ck,input res, output [15:0] Val,input enable);
reg [15:0] q ;
initial q <= 16'h0;
always @(posedge ck or posedge res) begin
	if( ck==1'b1 )
		q<=q+16'h1;
	else
		q<=16'h0;
end
assign Val = (enable) ? q : 16'b0;
endmodule*/
/*
module TimingManager(input VSYNC, input HREF,input pclk,output reg Sig_En);
wire [7:0] line,foo;
reg res,enC;
initial begin
	Sig_En <= 1'b1;
end
ByteCounter HrefC (HREF, VSYNC, line[7:0],1'b1);
ByteCounter PixC (pclk,res, foo[7:0],enC&HREF);
	//always @(negedge VSYNC) begin
//	res<=1'b0;
//end
always @(negedge pclk) begin
	if(line==8'h20 || line==8'h80 || line==8'hF0) begin
		enC<=1'b1;
	end
	else begin
		enC<=1'b0;
	end
	if(foo[6]==1'b1)begin
		Sig_En<=1'b1;
		res<=1'b1;
	end
	else begin
		Sig_En<=1'b0;
		res<=1'b0;
	end
end
endmodule
*/