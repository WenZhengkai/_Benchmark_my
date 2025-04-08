module dut (
    input clock,
    input reset,
    output reg io_dataIn_ready,
    input io_dataIn_valid,
    input [4:0] io_dataIn_bits,
    input io_dataOut_ready,
    output reg io_dataOut_valid,
    output reg [7:0] io_dataOut_bits
);

    // Number of cycles needed to deserialize: ceil(8 / 5) = 2
    localparam cycles = 2;

    // Log2 ceiling function for cycle count width
    localparam cycleCountWidth = 1;  // ceil(log2(cycles))

    reg [cycleCountWidth-1:0] cycleCount;
    reg [9:0] dataSelect;  // To temporarily hold 2 * 5-bit segments, but we only use 8 bits

    wire dataIn_fire = io_dataIn_ready && io_dataIn_valid;
    wire dataOut_fire = io_dataOut_valid && io_dataOut_ready;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            io_dataOut_valid <= 0;
            io_dataIn_ready <= 1;  // Ready to receive input data after reset
        end
        else begin
            if (dataIn_fire) begin
                // Store incoming serialized data segments into `dataSelect`
                dataSelect <= {dataSelect[4:0], io_dataIn_bits};

                if (cycleCount == cycles - 1) begin
                    // All segments received, set valid flag and reset cycle count
                    io_dataOut_valid <= 1;
                    io_dataOut_bits <= dataSelect[7:0];
                    cycleCount <= 0;
                end
                else begin
                    cycleCount <= cycleCount + 1;
                end
            end

            if (dataOut_fire) begin
                // Data output successfully, reset valid flag
                io_dataOut_valid <= 0;
                io_dataIn_ready <= 1;  // Ready to receive the next data set
            end

            // Control the readiness based on the current state
            if (io_dataOut_valid) begin
                io_dataIn_ready <= 0;  // Cannot accept new input if output not yet fired
            end else if (cycleCount == 0) begin
                io_dataIn_ready <= 1;  // Ready to accept new input cycle
            end
        end
    end

endmodule
