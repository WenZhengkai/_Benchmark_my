module dut (
    input  wire        clock,
    input  wire        reset,
    output wire        io_enq_ready,
    input  wire        io_enq_valid,
    input  wire [7:0]  io_enq_bits,
    output wire        io_deq_valid,
    input  wire        io_deq_credit,
    output wire [7:0]  io_deq_bits,
    output wire [2:0]  io_curCredit
);

    // Parameters
    localparam [2:0] maxCredit = 3'b111; // Maximum credits available (can be adjusted if needed)

    // Internal Registers
    reg [2:0] curCredit;
    reg [7:0] dataOut;
    reg       validOut;
    reg       icredit;

    // Combinational Logic
    wire enq_fire  = io_enq_valid && io_enq_ready;
    wire deq_fire = validOut && io_deq_credit;

    // Assign outputs
    assign io_enq_ready = (curCredit > 3'b0);
    assign io_deq_valid = validOut;
    assign io_deq_bits  = dataOut;
    assign io_curCredit = curCredit;

    // Sequential Logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= maxCredit;
            dataOut   <= 8'b0;
            validOut  <= 1'b0;
            icredit   <= 1'b0;
        end else begin
            // Capture the credit signal
            icredit <= deq_fire ? 1'b0 : io_deq_credit;

            // Update curCredit
            if (enq_fire && !icredit) begin
                curCredit <= curCredit - 1;
            end else if (icredit && !enq_fire) begin
                curCredit <= curCredit + 1;
            end

            // Update dataOut and validOut
            if (enq_fire) begin
                dataOut  <= io_enq_bits;
                validOut <= 1'b1;
            end else if (deq_fire) begin
                validOut <= 1'b0;
            end
        end
    end

endmodule
