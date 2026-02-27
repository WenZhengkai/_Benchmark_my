module dut (
    input wire CLK_in,     // Input clock signal (100MHz)
    input wire RST,        // Reset signal (asynchronous active high)
    output reg CLK_50,     // Output clock signal with frequency 50MHz
    output reg CLK_10,     // Output clock signal with frequency 10MHz
    output reg CLK_1       // Output clock signal with frequency 1MHz
);

    // Counter for CLK_10
    reg [2:0] cnt_10;  // 3-bit counter for dividing by 10 (values 0 to 4)

    // Counter for CLK_1
    reg [5:0] cnt_100; // 6-bit counter for dividing by 100 (values 0 to 49)

    // CLK_50 generation: Divide input clock by 2
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 0;
        end else begin
            CLK_50 <= ~CLK_50;
        end
    end

    // CLK_10 generation: Divide input clock by 10
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 0;
            cnt_10 <= 0;
        end else begin
            if (cnt_10 == 4) begin  // Toggle output every 5 input clock cycles
                CLK_10 <= ~CLK_10;
                cnt_10 <= 0;
            end else begin
                cnt_10 <= cnt_10 + 1;
            end
        end
    end

    // CLK_1 generation: Divide input clock by 100
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 0;
            cnt_100 <= 0;
        end else begin
            if (cnt_100 == 49) begin  // Toggle output every 50 input clock cycles
                CLK_1 <= ~CLK_1;
                cnt_100 <= 0;
            end else begin
                cnt_100 <= cnt_100 + 1;
            end
        end
    end

endmodule
