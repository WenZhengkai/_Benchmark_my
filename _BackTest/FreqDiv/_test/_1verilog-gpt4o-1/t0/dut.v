module dut (
    input wire CLK_in,   // Input clock signal (100MHz)
    input wire RST,      // Reset signal
    output reg CLK_50,   // Output clock signal with 50MHz frequency
    output reg CLK_10,   // Output clock signal with 10MHz frequency
    output reg CLK_1     // Output clock signal with 1MHz frequency
);

    // Internal counters for frequency division
    reg [2:0] cnt_10;    // 3-bit counter for CLK_10 generation (divide by 10)
    reg [6:0] cnt_100;   // 7-bit counter for CLK_1 generation (divide by 100)

    // CLK_50 generation (divide-by-2)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 1'b0;  // Reset CLK_50 to 0
        end else begin
            CLK_50 <= ~CLK_50;  // Toggle on each clock edge
        end
    end

    // CLK_10 generation (divide-by-10)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 1'b0;   // Reset CLK_10 to 0
            cnt_10 <= 3'b000; // Reset cnt_10 to 0
        end else if (cnt_10 == 3'd4) begin
            CLK_10 <= ~CLK_10; // Toggle CLK_10
            cnt_10 <= 3'b000;  // Reset cnt_10
        end else begin
            cnt_10 <= cnt_10 + 1'b1; // Increment cnt_10
        end
    end

    // CLK_1 generation (divide-by-100)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 1'b0;    // Reset CLK_1 to 0
            cnt_100 <= 7'b0000000; // Reset cnt_100 to 0
        end else if (cnt_100 == 7'd49) begin
            CLK_1 <= ~CLK_1;  // Toggle CLK_1
            cnt_100 <= 7'b0000000; // Reset cnt_100
        end else begin
            cnt_100 <= cnt_100 + 1'b1; // Increment cnt_100
        end
    end

endmodule
