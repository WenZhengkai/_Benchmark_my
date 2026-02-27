module dut (
    input wire CLK_in,    // Input clock signal (100 MHz)
    input wire RST,       // Reset signal (active high)
    output reg CLK_50,    // Output clock signal with 50 MHz frequency
    output reg CLK_10,    // Output clock signal with 10 MHz frequency
    output reg CLK_1      // Output clock signal with 1 MHz frequency
);

    // Counter for CLK_10 generation
    reg [2:0] cnt_10;      // 3-bit counter to count up to 4
    // Counter for CLK_1 generation
    reg [5:0] cnt_100;     // 6-bit counter to count up to 49

    // Initialize all outputs and counters
    initial begin
        CLK_50 = 0;
        CLK_10 = 0;
        CLK_1 = 0;
        cnt_10 = 0;
        cnt_100 = 0;
    end

    // CLK_50 generation: Divide-by-2 (toggle on every positive edge of CLK_in)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 0;   // Reset CLK_50 to 0
        end else begin
            CLK_50 <= ~CLK_50;  // Toggle CLK_50
        end
    end

    // CLK_10 generation: Divide-by-10
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 0;   // Reset CLK_10 to 0
            cnt_10 <= 0;   // Reset counter for CLK_10
        end else begin
            if (cnt_10 == 4) begin
                CLK_10 <= ~CLK_10;  // Toggle CLK_10
                cnt_10 <= 0;        // Reset cnt_10
            end else begin
                cnt_10 <= cnt_10 + 1;  // Increment cnt_10
            end
        end
    end

    // CLK_1 generation: Divide-by-100
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 0;    // Reset CLK_1 to 0
            cnt_100 <= 0;  // Reset counter for CLK_1
        end else begin
            if (cnt_100 == 49) begin
                CLK_1 <= ~CLK_1;   // Toggle CLK_1
                cnt_100 <= 0;      // Reset cnt_100
            end else begin
                cnt_100 <= cnt_100 + 1;  // Increment cnt_100
            end
        end
    end

endmodule
