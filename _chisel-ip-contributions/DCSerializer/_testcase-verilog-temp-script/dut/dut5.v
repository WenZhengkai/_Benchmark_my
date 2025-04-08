module dut (
    input        clock,
    input        reset,
    output reg   io_dataIn_ready,
    input        io_dataIn_valid,
    input  [7:0] io_dataIn_bits,
    input        io_dataOut_ready,
    output reg   io_dataOut_valid,
    output reg [4:0] io_dataOut_bits
);

    // State Definitions
    localparam IDLE = 1'b0;
    localparam ACTIVE = 1'b1;

    reg state;
    reg [2:0] cycle_count; // Enough to cover up to 3 cycles

    // Split input data into chunks of 5 and 3 bits
    wire [4:0] data_part1 = io_dataIn_bits[4:0];
    wire [2:0] data_part2 = io_dataIn_bits[7:5];

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            cycle_count <= 3'b0;
            io_dataIn_ready <= 1'b1;
            io_dataOut_valid <= 1'b0;
            io_dataOut_bits <= 5'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (io_dataIn_valid && io_dataIn_ready) begin
                        state <= ACTIVE;
                        cycle_count <= 3'b0;
                    end
                end
                ACTIVE: begin
                    if (io_dataOut_ready) begin
                        io_dataOut_valid <= 1'b1;
                        if (cycle_count == 3'b0) begin
                            io_dataOut_bits <= data_part1;
                            cycle_count <= 3'b1;
                        end else begin
                            io_dataOut_bits <= {2'b0, data_part2}; // Append zeros to make it 5 bits
                            state <= IDLE;
                            io_dataOut_ready <= 1'b0;
                            io_dataIn_ready <= 1'b1;
                        end
                    end
                end
            endcase
        end
    end

    // Input ready logic
    always @(*) begin
        if (state == IDLE) begin
            io_dataIn_ready = 1'b1;
        end else if (state == ACTIVE && cycle_count == 3'b1) begin
            io_dataIn_ready = 1'b0;
        end else begin
            io_dataIn_ready = 1'b0;
        end
    end

    // Output valid logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            io_dataOut_valid <= 1'b0;
        end else if (io_dataOut_ready) begin
            io_dataOut_valid <= (state == ACTIVE);
        end else begin
            io_dataOut_valid <= 1'b0;
        end
    end

endmodule
