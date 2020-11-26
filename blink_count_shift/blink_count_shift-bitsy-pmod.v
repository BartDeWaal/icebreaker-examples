/* Small test design actuating all IO on the iCEBreaker Bitsy dev board. */

module top (input CLK,
            input BTN_N,
            output LEDG_N,
            output PMOD1_1, PMOD1_2, PMOD1_3, PMOD1_4, PMOD1_7, PMOD1_8, PMOD1_9, PMOD1_10,
            output PMOD2_1, PMOD2_2, PMOD2_3, PMOD2_4, PMOD2_7, PMOD2_8, PMOD2_9, PMOD2_10,
            output PMOD3_1, PMOD3_2, PMOD3_3, PMOD3_4, PMOD3_7, PMOD3_8, PMOD3_9, PMOD3_10);
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

    assign {PMOD1_1, PMOD1_2, PMOD1_3, PMOD1_4, PMOD1_7, PMOD1_8, PMOD1_9, PMOD1_10,
            PMOD2_1, PMOD2_2, PMOD2_3, PMOD2_4, PMOD2_7, PMOD2_8, PMOD2_9, PMOD2_10,
            PMOD3_1, PMOD3_2, PMOD3_3, PMOD3_4, PMOD3_7, PMOD3_8, PMOD3_9, PMOD3_10} = 1 << (shift % 24);
endmodule
