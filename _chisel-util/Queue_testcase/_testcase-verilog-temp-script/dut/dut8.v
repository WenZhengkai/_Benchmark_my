module dut #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter HAS_FLUSH = 0  // Set to 1 if flush is included, 0 otherwise
)(
    input                     clock,
    input                     reset,
    output                    io_enq_ready,
    input                     io_enq_valid,
    input  [DATA_WIDTH-1:0]   io_enq_bits,
    input                     io_deq_ready,
    output                    io_deq_valid,
    output [DATA_WIDTH-1:0]   io_deq_bits,
    input                     io_flush,      // Only valid if HAS_FLUSH = 1
    output [ADDR_WIDTH-1:0]   io_count
);

    localparam ENTRIES = (1 << ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] ram [0:ENTRIES-1];
    reg [ADDR_WIDTH-1:0] enq_ptr;
    reg [ADDR_WIDTH-1:0] deq_ptr;
    reg                  maybe_full;

    wire                 ptr_match = (enq_ptr == deq_ptr);
    wire                 full      = ptr_match && maybe_full;
    wire                 empty     = ptr_match && !maybe_full;
    wire                 do_enq    = io_enq_ready && io_enq_valid;
    wire                 do_deq    = io_deq_ready && io_deq_valid;

    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;
    assign io_deq_bits  = ram[deq_ptr];
    
    // Count logic
    wire [ADDR_WIDTH:0] diff = enq_ptr >= deq_ptr ? enq_ptr - deq_ptr : (ENTRIES + enq_ptr) - deq_ptr;
    assign io_count = full ? ENTRIES : diff[ADDR_WIDTH-1:0];

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr   <= 0;
            deq_ptr   <= 0;
            maybe_full <= 0;
        end else begin
            if (HAS_FLUSH && io_flush) begin
                enq_ptr   <= 0;
                deq_ptr   <= 0;
                maybe_full <= 0;
            end else begin
                if (do_enq) begin
                    ram[enq_ptr] <= io_enq_bits;
                    enq_ptr <= enq_ptr + 1;
                end
                if (do_deq) begin
                    deq_ptr <= deq_ptr + 1;
                end
                if (do_enq && !do_deq) begin
                    maybe_full <= 1;
                end else if (!do_enq && do_deq) begin
                    maybe_full <= 0;
                end
            end
        end
    end

endmodule
