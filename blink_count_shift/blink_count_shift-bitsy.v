/* Small test design actuating all IO on the iCEBreaker-bitsy dev board. */

module top (
	input  CLK,

	input BTN_N,

	output LEDG_N,

	output P0,  P1,  P2,  P3,  P4,  P5,  P6,  P7,  P8,  P9,  P10, P11, P12,
	output P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23
);

	localparam BITS = 5;
	localparam LOG2DELAY = 20;


	reg bp = 0;
	wire bps;
	always @(posedge CLK) begin
		if (BTN_N) begin
			bp <= 0;
			bps <= 0;
		end else begin
			if (bp == 0) begin
				bps <= 1;
				bp <= 1;
			end else begin
				bps <= 0;
			end
		end
	end

	reg [BITS+LOG2DELAY-1:0] counter = 0;
	reg [BITS-1:0] outcnt;
	reg [6:0] shift;
	always @(posedge CLK) begin
		counter <= counter + 1;
		outcnt <= counter >> LOG2DELAY;
		if (bps) begin
			shift <= shift + 1;
		end
	end

	assign LEDG_N = BTN_N;

	assign {P0,  P1,  P2,  P3,  P4,  P5,  P6,  P7, P8,  P9,  P10, P11, P12,
		P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23} = 1 << (shift % 24);
endmodule
