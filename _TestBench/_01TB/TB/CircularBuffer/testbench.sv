module testbench;

  // Inputs
  reg clock;
  reg reset;
  reg io_enq;
  reg io_deq;

  // Outputs
  wire io_full_golden, io_full;
  wire io_empty_golden, io_empty;
  wire [31:0] io_head_golden, io_head;
  wire [127:0] io_tail_golden, io_tail;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_full_golden, io_empty_golden, io_head_golden, io_tail_golden} === ({io_full_golden, io_empty_golden, io_head_golden, io_tail_golden} ^ {io_full, io_empty, io_head, io_tail} ^ {io_full_golden, io_empty_golden, io_head_golden, io_tail_golden}));

  // Instantiate the Unit Under Test (UUT)
  CircularBuffer uut (
    .clock(clock),
    .reset(reset),
    .io_enq(io_enq),
    .io_deq(io_deq),
    .io_full(io_full),
    .io_empty(io_empty),
    .io_head(io_head),
    .io_tail(io_tail)
  );

  CircularBuffer_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_enq(io_enq),
    .io_deq(io_deq),
    .io_full(io_full_golden),
    .io_empty(io_empty_golden),
    .io_head(io_head_golden),
    .io_tail(io_tail_golden)
  );

  // Clock toggle generation
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
    io_enq = 0;
    io_deq = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here
    // Initial stimulus
    io_enq = 0;
    io_deq = 0;
    #100;
    io_enq = 1;
    io_deq = 0;
    #100;
    io_enq = 0;
    io_deq = 1;
    #100;
    io_enq = 0;
    io_deq = 0;
    #100;

    // Test Case 2: Data Enqueue (Normal Operation)
    for (integer i = 0; i < 100; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end

    // Test Case 3: Data Dequeue (Normal Operation)
    for (integer i = 0; i < 100; i++) begin
      io_enq = 0;
      io_deq = 1;
      #10;
    end

    // Test Case 4: Buffer Full Condition
    for (integer i = 0; i < 100; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end
    io_enq = 1;
    #10;

    // Test Case 5: Buffer Empty Condition
    for (integer i = 0; i < 100; i++) begin
      io_enq = 0;
      io_deq = 1;
      #10;
    end
    io_deq = 1;
    #10;

    // Test Case 6: Buffer Wrap-around
    for (integer i = 0; i < 50; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end
    for (integer i = 0; i < 50; i++) begin
      io_enq = 0;
      io_deq = 1;
      #10;
    end
    for (integer i = 0; i < 50; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end

    // Test Case 7: Simultaneous Enqueue and Dequeue
    for (integer i = 0; i < 100; i++) begin
      io_enq = 1;
      io_deq = 1;
      #10;
    end

    // Test Case 8: Reset During Operation
    for (integer i = 0; i < 50; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Additional Test Case 9: Rapid Reset Toggle
    reset = 1;
    #10;
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Additional Test Case 10: Alternating Enqueue/Dequeue
    for (integer i = 0; i < 50; i++) begin
      io_enq = 1;
      io_deq = 0;
      #5;
      io_enq = 0;
      io_deq = 1;
      #5;
    end

    // Additional Test Case 11: Stress Test with Random Inputs
    for (integer i = 0; i < 200; i++) begin
      io_enq = $random % 2;
      io_deq = $random % 2;
      #10;
    end

    // Additional Test Case 12: Edge Case for Toggle Coverage
    // Ensure each bit of head and tail transitions from 0 to 1 and 1 to 0
    for (integer i = 0; i < 32; i++) begin
      io_enq = 1;
      io_deq = 0;
      #10;
    end
    for (integer i = 0; i < 128; i++) begin
      io_enq = 0;
      io_deq = 1;
      #10;
    end

    // Final stimulus for reset toggle
    reset = 1;
    #10;
    reset = 0;
    #10;

    $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
    $finish;
  end

endmodule