module dut (
    input wire CLK_in,   // Input clock signal, 100 MHz
    input wire RST,      // Reset signal
    output reg CLK_50,   // Output clock signal, 50 MHz
    output reg CLK_10,   // Output clock signal, 10 MHz
    output reg CLK_1     // Output clock signal, 1 MHz
);

    // Counter for 10 MHz clock generation
    reg [3:0] cnt_10;    // 4-bit counter (0 to 4)

    // Counter for 1 MHz clock generation
    reg [5:0] cnt_100;   // 6-bit counter (0 to 49)

    // Generate 50 MHz clock: Simple toggle
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 0;
        end else begin
            CLK_50 <= ~CLK_50;
        end
    end

    // Generate 10 MHz clock
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 0;
            cnt_10 <= 0;
        end else if (cnt_10 == 4) begin
            CLK_10 <= ~CLK_10;
            cnt_10 <= 0;
        end else begin
            cnt_10 <= cnt_10 + 1;
        end
    end

    // Generate 1 MHz clock
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 0;
            cnt_100 <= 0;
        end else if (cnt_100 == 49) begin
            CLK_1 <= ~CLK_1;
            cnt_100 <= 0;
        end else begin
            cnt_100 <= cnt_100 + 1;
        end
    end

endmodule
