module dut(
    input        clock,
    input        reset,
    output       io_enq_ready,
    input        io_enq_valid,
    input  [7:0] io_enq_bits,
    input        io_deq_ready,
    output       io_deq_valid,
    output [7:0] io_deq_bits
);
    // Register declarations
    reg         pValid;  // Indicates whether there is currently valid data being held
    reg [7:0]   pData;   // Holds the data

    // Sequential logic to manage state and data
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pValid <= 1'b0;
            pData <= 8'b0;
        end else begin
            // Load data if no valid data is being held and enq is valid
            if (io_enq_valid && !pValid) begin
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end

            // Clear valid flag if the current data is dequeued
            if (io_deq_ready && pValid) begin
                pValid <= 1'b0;
            end
        end
    end

    // Output assignments
    assign io_enq_ready = !pValid; // Ready for new data when not holding valid data
    assign io_deq_valid = pValid;  // Valid data for dequeue when pValid is set
    assign io_deq_bits = pData;    // Present held data if valid

endmodule
