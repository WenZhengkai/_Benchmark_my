module dut (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output wire mul_en_out,
    output wire [15:0] mul_out
);

    // Registers for input and enable signals
    reg [2:0] mul_en_out_reg;
    reg [7:0] mul_a_reg, mul_b_reg;

    // Partial product wires
    wire [7:0] temp [7:0];

    // Registers for partial sums
    reg [9:0] sum1, sum2;
    reg [11:0] sum3, sum4;
    reg [13:0] sum5, sum6;
    reg [15:0] mul_out_reg;

    // Input control and register update
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out_reg <= 3'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
        end else if (mul_en_in) begin
            mul_en_out_reg <= {mul_en_out_reg[1:0], 1'b1};
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end else begin
            mul_en_out_reg <= {mul_en_out_reg[1:0], 1'b0};
        end
    end

    // Generate partial products
    assign temp[0] = mul_b_reg[0] ? mul_a_reg : 8'b0;
    assign temp[1] = mul_b_reg[1] ? mul_a_reg : 8'b0;
    assign temp[2] = mul_b_reg[2] ? mul_a_reg : 8'b0;
    assign temp[3] = mul_b_reg[3] ? mul_a_reg : 8'b0;
    assign temp[4] = mul_b_reg[4] ? mul_a_reg : 8'b0;
    assign temp[5] = mul_b_reg[5] ? mul_a_reg : 8'b0;
    assign temp[6] = mul_b_reg[6] ? mul_a_reg : 8'b0;
    assign temp[7] = mul_b_reg[7] ? mul_a_reg : 8'b0;

    // Pipeline stage 1: Partial sum calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum1 <= 10'b0;
            sum2 <= 10'b0;
        end else if (mul_en_out_reg[0]) begin
            sum1 <= {2'b0, temp[0]} + {1'b0, temp[1], 1'b0};
            sum2 <= {2'b0, temp[2]} + {1'b0, temp[3], 1'b0};
        end
    end

    // Pipeline stage 2: Partial sum calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum3 <= 12'b0;
            sum4 <= 12'b0;
        end else if (mul_en_out_reg[1]) begin
            sum3 <= {2'b0, sum1} + {sum2, 2'b0};
            sum4 <= {4'b0, temp[4]} + {3'b0, temp[5], 1'b0};
        end
    end

    // Pipeline stage 3: Partial sum calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum5 <= 14'b0;
            sum6 <= 14'b0;
        end else if (mul_en_out_reg[2]) begin
            sum5 <= {2'b0, sum3} + {sum4, 2'b0};
            sum6 <= {6'b0, temp[6]} + {5'b0, temp[7], 1'b0};
        end
    end

    // Pipeline stage 4: Final product calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else begin
            mul_out_reg <= {2'b0, sum5} + {sum6, 2'b0};
        end
    end

    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule