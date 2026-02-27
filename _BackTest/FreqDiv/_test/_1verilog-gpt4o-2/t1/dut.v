module dut (
    input wire CLK_in,  // Input clock signal, 100MHz
    input wire RST,     // Reset signal (active high)
    output reg CLK_50,  // Output clock signal, 50MHz
    output reg CLK_10,  // Output clock signal, 10MHz
    output reg CLK_1    // Output clock signal, 1MHz
);

    // Counter for generating CLK_10
    reg [2:0] cnt_10; // 3-bit counter for dividing by 10 (counts 0 to 4)

    // Counter for generating CLK_1
    reg [6:0] cnt_100; // 7-bit counter for dividing by 100 (counts 0 to 49)

    // CLK_50 generation: Divide 100MHz by 2 -> 50MHz
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 0;
        end else begin
            CLK_50 <= ~CLK_50; // Toggle the output clock
        end
    end

    // CLK_10 generation: Divide 100MHz by 10 -> 10MHz
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 0;
            cnt_10 <= 0;
        end else if (cnt_10 == 4) begin
            CLK_10 <= ~CLK_10; // Toggle the output clock
            cnt_10 <= 0;       // Reset the counter
        end else begin
            cnt_10 <= cnt_10 + 1; // Increment the counter
        end
    end

    // CLK_1 generation: Divide 100MHz by 100 -> 1MHz
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 0;
            cnt_100 <= 0;
        end else if (cnt_100 == 49) begin
            CLK_1 <= ~CLK_1; // Toggle the output clock
            cnt_100 <= 0;    // Reset the counter
        end else begin
            cnt_100 <= cnt_100 + 1; // Increment the counter
        end
    end

endmodule
