`timescale 1ns / 1ps
`define P 20

module test_padder;

    // Inputs
    reg clk;
    reg reset;
    reg [63:0] in;
    reg in_ready;
    reg is_last;
    reg [2:0] byte_num;
    reg f_ack;

    // Outputs
    wire buffer_full_ref, buffer_full_dut;
    wire [575:0] out_ref, out_dut;
    wire out_ready_ref, out_ready_dut;

    wire match;

    integer total_tests = 0;
          integer failed_tests = 0;

    assign match = ({buffer_full_ref, out_ref, out_ready_ref} === ({buffer_full_ref, out_ref, out_ready_ref} ^ {buffer_full_dut, out_dut, out_ready_dut} ^ {buffer_full_ref, out_ref, out_ready_ref}));

    // Var
    integer i;

    // Instantiate the Unit Under Test (UUT)
    padder_ref ref_model (
        .clk(clk),
        .reset(reset),
        .in(in),
        .in_ready(in_ready),
        .is_last(is_last),
        .byte_num(byte_num),
        .buffer_full_ref(buffer_full_ref),
        .out_ref(out_ref),
        .out_ready_ref(out_ready_ref),
        .f_ack(f_ack)
    );

    padder dut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .in_ready(in_ready),
        .is_last(is_last),
        .byte_num(byte_num),
        .buffer_full(buffer_full_dut),
        .out(out_dut),
        .out_ready(out_ready_dut),
        .f_ack(f_ack)
    );

   initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        in = 0;
        in_ready = 0;
        is_last = 0;
        byte_num = 0;
        f_ack = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        @ (negedge clk);

        // pad an empty string, should not eat next input
        reset = 1; #(`P); reset = 0;
        #(7*`P); // wait some cycles
        compare();
        in_ready = 1;
        is_last = 1;
        #(`P);
        in_ready = 1; // next input
        is_last = 1;
        #(`P);
        in_ready = 0;
        is_last = 0;

        while (out_ready_ref !== 1)
            #(`P);
        compare();
        f_ack = 1; #(`P); f_ack = 0;
        #(5*`P);
        compare();

        // pad an (576-8) bit string
        reset = 1; #(`P); reset = 0;
        #(4*`P); // wait some cycles
        in_ready = 1;
        byte_num = 7; /* should have no effect */
        is_last = 0;
        for (i=0; i<8; i=i+1)
          begin
            in = 64'h1234567890ABCDEF;
            #(`P);
          end
        is_last = 1;
        #(`P);
        in_ready = 0;
        is_last = 0;
        compare();

        // pad an (576-64) bit string
        reset = 1; #(`P); reset = 0;
        // don't wait any cycle
        in_ready = 1;
        byte_num = 7; /* should have no effect */
        is_last = 0;
        for (i=0; i<8; i=i+1)
          begin
            in = 64'h1234567890ABCDEF;
            #(`P);
          end
        is_last = 1;
        byte_num = 0;

       #(`P);
        in_ready = 0;
        is_last = 0;
        compare();

        // pad an (576*2-16) bit string
        reset = 1; #(`P); reset = 0;
        in_ready = 1;
        byte_num = 7; /* should have no effect */
        is_last = 0;
        for (i=0; i<9; i=i+1)
          begin
            in = 64'h1234567890ABCDEF;
            #(`P);
          end
        compare();
        #(`P/2);
        compare();
        #(`P/2);
        in = 64'h999; // should not eat this
        #(`P/2);
        compare();
        #(`P/2);
        f_ack = 1; #(`P); f_ack = 0;
        compare();
        // feed next (576-16) bit
        for (i=0; i<8; i=i+1)
          begin
            in = 64'h1234567890ABCDEF; #(`P);
          end
        byte_num = 6;
        is_last = 1;
        in = 64'h1234567890ABCDEF; #(`P);
        compare();
        is_last = 0;
        // eat these bits
        f_ack = 1; #(`P); f_ack = 0;
        // should not provide any more bits, if user provides nothing
        in_ready = 0;
        is_last = 0;
        #(10*`P);
        compare();
        in_ready = 0;

        repeat (89) begin
          reset = 1; #(`P); reset = 0;
          in_ready = $random;
          byte_num = $random;
          is_last = 0;
          f_ack = $random;
          for (i=0; i<8; i=i+1)
            begin
              in = {$random,$random};
              #(`P);
            end
          is_last = 1;
          #(`P);
          compare();
          in_ready = 0;
          is_last = 0;
        end

        $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
        $finish;
    end

    always #(`P/2) clk = ~ clk;

    task compare;
        total_tests = total_tests + 1;

        if (match)                                //condition to check DUT outputs and calculated 
                                                    //outputs from task are equal 
                        begin
                                $display("\033[1;32mtestcase is passed!!!\033[0m");
//                              $display("testcase is passed!!!");
                $display("reset = %h, in = %h, in_ready = %h, is_last = %h, byte_num = %h, f_ack = %h, buffer_full_dut = %h, out_dut = %h, out_ready_dut = %h, buffer_full_ref = %h, out_ref = %h, out_ready_ref = %h", reset, in, in_ready, is_last, byte_num, f_ack, buffer_full_dut, out_dut, out_ready_dut, buffer_full_ref, out_ref, out_ready_ref);      //displaying inputs, outputs and result
                        end

                else begin
                        $display("\033[1;31mtestcase is failed!!!\033[0m");
            $display("reset = %h, in = %h, in_ready = %h, is_last = %h, byte_num = %h, f_ack = %h, buffer_full_dut = %h, out_dut = %h, out_ready_dut = %h, buffer_full_ref = %h, out_ref = %h, out_ready_ref = %h", reset, in, in_ready, is_last, byte_num, f_ack, buffer_full_dut, out_dut, out_ready_dut, buffer_full_ref, out_ref, out_ready_ref);      //displaying inputs, outputs and result
            failed_tests = failed_tests + 1;
                end

          endtask

    initial begin
        $dumpfile("sim.fsdb");
        $dumpvars(0);

    end

endmodule
`undef P

                                                                                                                                                                                                                                                                 218,0-1      底端