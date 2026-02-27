module dut(
    input CLK_in,      // 100MHz input clock
    input RST,         // Reset signal
    output reg CLK_50, // Output: 50MHz clock
    output reg CLK_10, // Output: 10MHz clock
    output reg CLK_1   // Output: 1MHz clock
);

    // Counter for dividing clock to generate CLK_10
    reg [2:0] cnt_10; // 3-bit counter to count 0 to 4
      
    // Counter for dividing clock to generate CLK_1
    reg [6:0] cnt_100; // 7-bit counter to count 0 to 49

    // CLK_50 generation: Divide by 2
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_50 <= 0;
        end else begin
            CLK_50 <= ~CLK_50;
        end
    end

    // CLK_10 generation: Divide by 10
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_10 <= 0;
            cnt_10 <= 0;
        end else begin
            if (cnt_10 == 4) begin
                CLK_10 <= ~CLK_10; // Toggle CLK_10
                cnt_10 <= 0;       // Reset the counter
            end else begin
                cnt_10 <= cnt_10 + 1; // Increment counter
            end
        end
    end

    // CLK_1 generation: Divide by 100
    always @(posedge CLK_in or posedge RST) begin
        if (RST) begin
            CLK_1 <= 0;
            cnt_100 <= 0;
        end else begin
            if (cnt_100 == 49) begin
                CLK_1 <= ~CLK_1; // Toggle CLK_1
                cnt_100 <= 0;    // Reset the counter
            end else begin
                cnt_100 <= cnt_100 + 1; // Increment counter
            end
        end
    end

endmodule
