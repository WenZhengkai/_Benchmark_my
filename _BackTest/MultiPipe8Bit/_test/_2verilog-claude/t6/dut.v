module dut (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output wire mul_en_out,
    output wire [15:0] mul_out
);

    // Input registers
    reg [7:0] mul_a_reg, mul_b_reg;
    
    // Enable signal registers
    reg [3:0] mul_en_out_reg;
    
    // Partial product wires
    wire [7:0] temp [7:0];
    
    // Partial sum registers
    reg [15:0] sum [3:0];
    
    // Output register
    reg [15:0] mul_out_reg;

    // Input control and register update
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            mul_en_out_reg <= 4'b0;
        end else if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            mul_en_out_reg <= {mul_en_out_reg[2:0], mul_en_in};
        end
    end

    // Partial product generation
    assign temp[0] = mul_b_reg[0] ? mul_a_reg : 8'b0;
    assign temp[1] = mul_b_reg[1] ? mul_a_reg : 8'b0;
    assign temp[2] = mul_b_reg[2] ? mul_a_reg : 8'b0;
    assign temp[3] = mul_b_reg[3] ? mul_a_reg : 8'b0;
    assign temp[4] = mul_b_reg[4] ? mul_a_reg : 8'b0;
    assign temp[5] = mul_b_reg[5] ? mul_a_reg : 8'b0;
    assign temp[6] = mul_b_reg[6] ? mul_a_reg : 8'b0;
    assign temp[7] = mul_b_reg[7] ? mul_a_reg : 8'b0;

    // Partial sum calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[0] <= 16'b0;
            sum[1] <= 16'b0;
            sum[2] <= 16'b0;
            sum[3] <= 16'b0;
        end else begin
            sum[0] <= {8'b0, temp[0]} + {7'b0, temp[1], 1'b0};
            sum[1] <= {6'b0, temp[2], 2'b0} + {5'b0, temp[3], 3'b0};
            sum[2] <= {4'b0, temp[4], 4'b0} + {3'b0, temp[5], 5'b0};
            sum[3] <= {2'b0, temp[6], 6'b0} + {1'b0, temp[7], 7'b0};
        end
    end

    // Final product calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else begin
            mul_out_reg <= sum[0] + sum[1] + sum[2] + sum[3];
        end
    end

    // Output assignments
    assign mul_en_out = mul_en_out_reg[3];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule