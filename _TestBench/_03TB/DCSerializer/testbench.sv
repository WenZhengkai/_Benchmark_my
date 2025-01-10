`timescale 1ns / 1ps

module testbench;

//parameter or localparam

// Inputs
reg clock;
reg reset;
reg io_dataIn_valid;
reg [7:0] io_dataIn_bits;
reg io_dataOut_ready;

// Outputs or inout
  wire io_dataIn_ready, io_dataIn_ready_golden;
  wire io_dataOut_valid, io_dataOut_valid_golden;
  wire [4:0] io_dataOut_bits, io_dataOut_bits_golden;

  integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden} === ({io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden} ^ {io_dataIn_ready, io_dataOut_valid, io_dataOut_bits} ^ {io_dataIn_ready_golden, io_dataOut_valid_golden, io_dataOut_bits_golden}));
// Instantiate the Unit Under Test (UUT)
DCSerializer_golden golden_model (
  .clock(clock),
  .reset(reset),
  .io_dataIn_ready(io_dataIn_ready_golden),
  .io_dataIn_valid(io_dataIn_valid),
  .io_dataIn_bits(io_dataIn_bits),
  .io_dataOut_ready(io_dataOut_ready),
  .io_dataOut_valid(io_dataOut_valid_golden),
  .io_dataOut_bits(io_dataOut_bits_golden)
);


DCSerializer uut (
  .clock(clock),
  .reset(reset),
  .io_dataIn_ready(io_dataIn_ready),
  .io_dataIn_valid(io_dataIn_valid),
  .io_dataIn_bits(io_dataIn_bits),
  .io_dataOut_ready(io_dataOut_ready),
  .io_dataOut_valid(io_dataOut_valid),
  .io_dataOut_bits(io_dataOut_bits)
);

//clk toggle generate
always #5 clock = ~clock;

always @(posedge clock) begin
    total_tests = total_tests + 1; 
    if (match) begin
        $display("\033[1;32mtestcase is passed!!!\033[0m");
    end
    else begin
        $display("\033[1;31mtestcase is failed!!!\033[0m");
        failed_tests = failed_tests + 1; 
    end
end

initial begin
    // Initialize Inputs
    clock = 0;
    reset = 1;
    io_dataIn_valid = 0;
    io_dataIn_bits = 8'h00;
    io_dataOut_ready = 0;

    // Wait 100ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus: set all inputs to zero, wait 100ns, set all inputs to one, wait another 100ns, and finally set all inputs back to zero
    io_dataIn_valid = 0;
    io_dataIn_bits = 8'h00;
    io_dataOut_ready = 0;
    #100;
    io_dataIn_valid = 1;
    io_dataIn_bits = 8'hFF;
    io_dataOut_ready = 1;
    #100;
    io_dataIn_valid = 0;
    io_dataIn_bits = 8'h00;
    io_dataOut_ready = 0;
    #100;

    // Test Case 1: Basic Serialization Functionality
    io_dataIn_valid = 1;
    io_dataOut_ready = 1;
    io_dataIn_bits = 8'hAB;
    #10;
    io_dataIn_bits = 8'h00;

    // Test Case 2: Cycle Control and Output Management
    for (integer i = 0; i < 100; i = i + 1) begin
        io_dataIn_bits = $random;
        #10;
    end

    // Test Case 3: Handshake Mechanism for Data Flow Control
    io_dataIn_valid = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_dataOut_ready = (i % 2 == 0) ? 1 : 0;
        #10;
    end

    // Test Case 4: Input Data Readiness and Output Data Validity Management
    io_dataIn_valid = 1;
    io_dataOut_ready = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_dataIn_bits = i;
        #10;
    end

    // Test Case 5: Reset and Initialization
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Stimuli to toggle reset
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Ensure 100 complete stimuli and at least 100 clock cycles
    for (integer i = 0; i < 100; i = i + 1) begin
        io_dataIn_bits = $random;
        io_dataIn_valid = (i % 2 == 0) ? 1 : 0;
        io_dataOut_ready = (i % 3 == 0) ? 1 : 0;
        #10;
    end

    // Toggle each bit of io_dataIn_bits using a for loop
    for (integer i = 0; i < 8; i = i + 1) begin
        io_dataIn_bits = 1 << i;
        #10;
    end

    
$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);

    $finish;
end

endmodule