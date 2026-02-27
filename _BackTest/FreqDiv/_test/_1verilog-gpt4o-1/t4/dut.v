module dut (
    input wire CLK_in,   // Input clock signal (100 MHz)
    input wire RST,      // Active-high reset signal
    output reg CLK_50,   // Output clock signal (50 MHz)
    output reg CLK_10,   // Output clock signal (10 MHz)
    output reg CLK_1     // Output clock signal (1 MHz)
);

    // Counter for CLK_10
    reg [2:0] cnt_10;    // 3-bit counter for division by 10 (counts 0 to 4)
    // Counter for CLK_1
    reg [6:0] cnt_100;   // 7-bit counter for division by 100 (counts 0 to 49)

    // CLK_50 generation (divide by 2)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 1'b0;  // Reset CLK_50 to 0
        end else begin
            CLK_50 <= ~CLK_50;  // Toggle CLK_50
        end
    end

    // CLK_10 generation (divide by 10)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 1'b0;  // Reset CLK_10 to 0
            cnt_10 <= 3'b000; // Reset counter to 0
        end else begin
            if (cnt_10 == 3'd4) begin
                CLK_10 <= ~CLK_10; // Toggle CLK_10
                cnt_10 <= 3'b000;  // Reset counter
            end else begin
                cnt_10 <= cnt_10 + 3'b001; // Increment counter
            end
        end
    end

    // CLK_1 generation (divide by 100)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 1'b0;   // Reset CLK_1 to 0
            cnt_100 <= 7'b0000000; // Reset counter to 0
        end else begin
            if (cnt_100 == 7'd49) begin
                CLK_1 <= ~CLK_1; // Toggle CLK_1
                cnt_100 <= 7'b0000000; // Reset counter
            end else begin
                cnt_100 <= cnt_100 + 7'b0000001; // Increment counter
            end
        end
    end

endmodule
