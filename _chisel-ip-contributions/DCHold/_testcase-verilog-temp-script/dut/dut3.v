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

    // Internal registers for storing valid state and data
    reg pValid;
    reg [7:0] pData;

    // Combinational logic: Output assignments
    assign io_enq_ready = ~pValid;         // Ready to accept new data if no valid data is currently held
    assign io_deq_valid = pValid;          // Deq valid is true if there's valid data held
    assign io_deq_bits  = pData;           // Output the current held data

    // Sequential logic: Manage data holding and state transitions
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pValid <= 1'b0;                // Reset the valid flag
            pData  <= 8'b0;                // Clear any stored data
        end else begin
            if (io_deq_ready && pValid) begin
                // Dequeue condition: Clear data and indicate no valid data held
                pValid <= 1'b0;
            end
            if (io_enq_valid && io_enq_ready) begin
                // Enqueue condition: Capture new data and indicate valid data held
                pData  <= io_enq_bits;
                pValid <= 1'b1;
            end
        end
    end

endmodule
