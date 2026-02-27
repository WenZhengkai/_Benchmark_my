module dut (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output wire mul_en_out,
    output wire [15:0] mul_out
);

    // Registers for pipeline stages
    reg [3:0] mul_en_out_reg;
    reg [7:0] mul_a_reg, mul_b_reg;
    reg [15:0] sum [3:0];
    reg [15:0] mul_out_reg;

    // Wires for partial products
    wire [7:0] temp [7:0];

    // Generate partial products
    assign temp[0] = mul_b_reg[0] ? mul_a_reg : 8'b0;
    assign temp[1] = mul_b_reg[1] ? {mul_a_reg[6:0], 1'b0} : 8'b0;
    assign temp[2] = mul_b_reg[2] ? {mul_a_reg[5:0], 2'b0} : 8'b0;
    assign temp[3] = mul_b_reg[3] ? {mul_a_reg[4:0], 3'b0} : 8'b0;
    assign temp[4] = mul_b_reg[4] ? {mul_a_reg[3:0], 4'b0} : 8'b0;
    assign temp[5] = mul_b_reg[5] ? {mul_a_reg[2:0], 5'b0} : 8'b0;
    assign temp[6] = mul_b_reg[6] ? {mul_a_reg[1:0], 6'b0} : 8'b0;
    assign temp[7] = mul_b_reg[7] ? {mul_a_reg[0], 7'b0} : 8'b0;

    // Pipeline stage 1: Input registers and first partial sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out_reg <= 4'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            sum[0] <= 16'b0;
        end else if (mul_en_in) begin
            mul_en_out_reg <= {mul_en_out_reg[2:0], mul_en_in};
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            sum[0] <= {8'b0, temp[0]} + {7'b0, temp[1]};
        end
    end

    // Pipeline stage 2: Second partial sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[1] <= 16'b0;
        end else if (mul_en_out_reg[0]) begin
            sum[1] <= sum[0] + {6'b0, temp[2]} + {5'b0, temp[3]};
        end
    end

    // Pipeline stage 3: Third partial sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[2] <= 16'b0;
        end else if (mul_en_out_reg[1]) begin
            sum[2] <= sum[1] + {4'b0, temp[4]} + {3'b0, temp[5]};
        end
    end

    // Pipeline stage 4: Final sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[3] <= 16'b0;
        end else if (mul_en_out_reg[2]) begin
            sum[3] <= sum[2] + {2'b0, temp[6]} + {1'b0, temp[7]};
        end
    end

    // Output stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else if (mul_en_out_reg[3]) begin
            mul_out_reg <= sum[3];
        end
    end

    // Output assignments
    assign mul_en_out = mul_en_out_reg[3];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule