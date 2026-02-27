module dut (
    input wire CLK_in,    // Input clock signal (100MHz)
    input wire RST,       // Reset signal (active high)
    output reg CLK_50,    // Output clock signal (50MHz)
    output reg CLK_10,    // Output clock signal (10MHz)
    output reg CLK_1      // Output clock signal (1MHz)
);

    // Counter for CLK_10 generation (100MHz / 10 = 10MHz)
    reg [2:0] cnt_10;

    // Counter for CLK_1 generation (100MHz / 100 = 1MHz)
    reg [6:0] cnt_100;

    // CLK_50 generation (Toggle every cycle of CLK_in)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 1'b0;  // Reset CLK_50
        end else begin
            CLK_50 <= ~CLK_50;  // Toggle CLK_50
        end
    end

    // CLK_10 generation (Toggle every 5 cycles of CLK_50, or 10 cycles of CLK_in)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 1'b0;  // Reset CLK_10
            cnt_10 <= 3'b000;  // Reset cnt_10
        end else begin
            if (cnt_10 == 3'b100) begin
                CLK_10 <= ~CLK_10;  // Toggle CLK_10
                cnt_10 <= 3'b000;  // Reset cnt_10
            end else begin
                cnt_10 <= cnt_10 + 1'b1;  // Increment cnt_10
            end
        end
    end

    // CLK_1 generation (Toggle every 50 cycles of CLK_10, or 100 cycles of CLK_in)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 1'b0;  // Reset CLK_1
            cnt_100 <= 7'b000_0000;  // Reset cnt_100
        end else begin
            if (cnt_100 == 7'b011_0010) begin  // 49 in decimal
                CLK_1 <= ~CLK_1;  // Toggle CLK_1
                cnt_100 <= 7'b000_0000;  // Reset cnt_100
            end else begin
                cnt_100 <= cnt_100 + 1'b1;  // Increment cnt_100
            end
        end
    end

endmodule
