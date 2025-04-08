module DCInput_UInt8 (
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
  // Internal registers
  reg  ready_r;
  reg  occupied;
  reg [7:0] hold;
  
  wire  drain = occupied & io_deq_ready;
  wire  load = io_enq_valid & ready_r & (~io_deq_ready | drain);
  wire  _GEN_1 = drain ? 1'h0 : occupied;
  wire  _GEN_2 = load | _GEN_1;

  assign io_enq_ready = ready_r;
  assign io_deq_valid = io_enq_valid | occupied;
  assign io_deq_bits = occupied ? hold : io_enq_bits;

  always @(posedge clock) begin
    ready_r <= reset | (~occupied & ~load | drain & ~load);
    if (reset) begin
      occupied <= 1'h0;
    end else begin
      occupied <= _GEN_2;
    end
    if (load) begin
      hold <= io_enq_bits;
    end
  end
endmodule

module DCOutput_UInt8 (
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
  reg  rValid;
  wire  _rValid_T = io_enq_ready & io_enq_valid;
  reg [7:0] io_deq_bits_r;

  assign io_enq_ready = io_deq_ready | ~rValid;
  assign io_deq_valid = rValid;
  assign io_deq_bits = io_deq_bits_r;

  always @(posedge clock) begin
    if (reset) begin
      rValid <= 1'h0;
    end else begin
      rValid <= _rValid_T | rValid & ~io_deq_ready;
    end
    if (_rValid_T) begin
      io_deq_bits_r <= io_enq_bits;
    end
  end
endmodule

module dut(
  input        clock,
  input        reset,
  output       io_a_0_ready,
  input        io_a_0_valid,
  input  [7:0] io_a_0_bits,
  output       io_a_1_ready,
  input        io_a_1_valid,
  input  [7:0] io_a_1_bits,
  output       io_a_2_ready,
  input        io_a_2_valid,
  input  [7:0] io_a_2_bits,
  output       io_a_3_ready,
  input        io_a_3_valid,
  input  [7:0] io_a_3_bits,
  output       io_a_4_ready,
  input        io_a_4_valid,
  input  [7:0] io_a_4_bits,
  output       io_a_5_ready,
  input        io_a_5_valid,
  input  [7:0] io_a_5_bits,
  input        io_z_ready,
  output       io_z_valid,
  output [7:0] io_z_bits
);

  wire [5:0] aInt_ready;
  wire [5:0] aInt_valid;
  wire [7:0] aInt_bits[5:0];
  
  wire zInt_ready, zInt_valid;
  wire [7:0] zInt_bits;

  reg [7:0] reduction_result;

  // Instantiate DCInput blocks for each input
  DCInput_UInt8 aInt_0 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_0_ready),
    .io_enq_valid(io_a_0_valid),
    .io_enq_bits(io_a_0_bits),
    .io_deq_ready(aInt_ready[0]),
    .io_deq_valid(aInt_valid[0]),
    .io_deq_bits(aInt_bits[0])
  );

  DCInput_UInt8 aInt_1 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_1_ready),
    .io_enq_valid(io_a_1_valid),
    .io_enq_bits(io_a_1_bits),
    .io_deq_ready(aInt_ready[1]),
    .io_deq_valid(aInt_valid[1]),
    .io_deq_bits(aInt_bits[1])
  );

  DCInput_UInt8 aInt_2 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_2_ready),
    .io_enq_valid(io_a_2_valid),
    .io_enq_bits(io_a_2_bits),
    .io_deq_ready(aInt_ready[2]),
    .io_deq_valid(aInt_valid[2]),
    .io_deq_bits(aInt_bits[2])
  );

  DCInput_UInt8 aInt_3 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_3_ready),
    .io_enq_valid(io_a_3_valid),
    .io_enq_bits(io_a_3_bits),
    .io_deq_ready(aInt_ready[3]),
    .io_deq_valid(aInt_valid[3]),
    .io_deq_bits(aInt_bits[3])
  );

  DCInput_UInt8 aInt_4 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_4_ready),
    .io_enq_valid(io_a_4_valid),
    .io_enq_bits(io_a_4_bits),
    .io_deq_ready(aInt_ready[4]),
    .io_deq_valid(aInt_valid[4]),
    .io_deq_bits(aInt_bits[4])
  );

  DCInput_UInt8 aInt_5 (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(io_a_5_ready),
    .io_enq_valid(io_a_5_valid),
    .io_enq_bits(io_a_5_bits),
    .io_deq_ready(aInt_ready[5]),
    .io_deq_valid(aInt_valid[5]),
    .io_deq_bits(aInt_bits[5])
  );

  // Compute 'all_valid' signal
  wire all_valid = aInt_valid[0] & aInt_valid[1] & aInt_valid[2] & aInt_valid[3] & aInt_valid[4] & aInt_valid[5];

  // Perform reduction operation
  always @(*) begin
    reduction_result = aInt_bits[0];
    reduction_result = reduction_result + aInt_bits[1];
    reduction_result = reduction_result + aInt_bits[2];
    reduction_result = reduction_result + aInt_bits[3];
    reduction_result = reduction_result + aInt_bits[4];
    reduction_result = reduction_result + aInt_bits[5];
  end

  assign zInt_valid = all_valid & zInt_ready;
  assign zInt_bits = reduction_result;

  // Connect to DCOutput
  DCOutput_UInt8 zDcout (
    .clock(clock),
    .reset(reset),
    .io_enq_ready(zInt_ready),
    .io_enq_valid(zInt_valid),
    .io_enq_bits(zInt_bits),
    .io_deq_ready(io_z_ready),
    .io_deq_valid(io_z_valid),
    .io_deq_bits(io_z_bits)
  );

  // Ready signals for inputs
  assign aInt_ready[0] = zInt_ready & all_valid;
  assign aInt_ready[1] = zInt_ready & all_valid;
  assign aInt_ready[2] = zInt_ready & all_valid;
  assign aInt_ready[3] = zInt_ready & all_valid;
  assign aInt_ready[4] = zInt_ready & all_valid;
  assign aInt_ready[5] = zInt_ready & all_valid;

endmodule
