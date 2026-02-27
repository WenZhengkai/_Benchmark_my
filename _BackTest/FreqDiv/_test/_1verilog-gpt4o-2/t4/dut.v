module dut (
    input wire CLK_in,   // Input clock signal (100MHz)
    input wire RST,      // Reset signal

    output reg CLK_50,   // Output clock signal with 50MHz frequency
    output reg CLK_10,   // Output clock signal with 10MHz frequency
    output reg CLK_1     // Output clock signal with 1MHz frequency
);

    // Intermediate counters for CLK_10 and CLK_1
    reg [2:0] cnt_10;    // 3-bit counter for 10MHz signal (values 0 to 4)
    reg [6:0] cnt_100;   // 7-bit counter for 1MHz signal (values 0 to 49)

    // CLK_50 Generation (CLK_in divided by 2)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 1'b0; // Reset CLK_50 to 0
        end else begin
            CLK_50 <= ~CLK_50; // Toggle CLK_50 on every positive edge of CLK_in
        end
    end

    // CLK_10 Generation (CLK_in divided by 10)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 1'b0;   // Reset CLK_10 to 0
            cnt_10 <= 3'b000; // Reset counter for CLK_10 to 0
        end else begin
            if (cnt_10 == 3'b100) begin // Check if counter reaches 4
                CLK_10 <= ~CLK_10;      // Toggle CLK_10
                cnt_10 <= 3'b000;       // Reset counter to 0
            end else begin
                cnt_10 <= cnt_10 + 1;   // Increment counter
            end
        end
    end

    // CLK_1 Generation (CLK_in divided by 100)
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 1'b0;     // Reset CLK_1 to 0
            cnt_100 <= 7'b0;   // Reset counter for CLK_1 to 0
        end else begin
            if (cnt_100 == 7'd49) begin // Check if counter reaches 49
                CLK_1 <= ~CLK_1;        // Toggle CLK_1
                cnt_100 <= 7'b0;        // Reset counter to 0
            end else begin
                cnt_100 <= cnt_100 + 1; // Increment counter
            end
        end
    end

endmodule
