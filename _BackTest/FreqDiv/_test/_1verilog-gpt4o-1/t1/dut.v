module dut (
    input  wire CLK_in,  // Input clock signal (100 MHz)
    input  wire RST,     // Reset signal (active high)
    output reg  CLK_50,  // Output clock with frequency 50 MHz
    output reg  CLK_10,  // Output clock with frequency 10 MHz
    output reg  CLK_1    // Output clock with frequency 1 MHz
);

    // Counter for generating CLK_10
    reg [2:0] cnt_10;  // 3-bit counter (values 0-4)

    // Counter for generating CLK_1
    reg [5:0] cnt_100; // 6-bit counter (values 0-49)

    // CLK_50 Generation
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 1'b0; // Reset CLK_50 to 0
        end else begin
            CLK_50 <= ~CLK_50; // Toggle CLK_50 on every clock edge
        end
    end

    // CLK_10 Generation
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 1'b0;  // Reset CLK_10 to 0
            cnt_10 <= 3'b000; // Reset counter cnt_10 to 0
        end else begin
            if (cnt_10 == 3'b100) begin // Check if counter reaches 4
                CLK_10 <= ~CLK_10; // Toggle CLK_10
                cnt_10 <= 3'b000;  // Reset counter
            end else begin
                cnt_10 <= cnt_10 + 1'b1; // Increment counter
            end
        end
    end

    // CLK_1 Generation
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 1'b0;   // Reset CLK_1 to 0
            cnt_100 <= 6'b000000; // Reset counter cnt_100 to 0
        end else begin
            if (cnt_100 == 6'd49) begin // Check if counter reaches 49
                CLK_1 <= ~CLK_1; // Toggle CLK_1
                cnt_100 <= 6'b000000; // Reset counter
            end else begin
                cnt_100 <= cnt_100 + 1'b1; // Increment counter
            end
        end
    end

endmodule
