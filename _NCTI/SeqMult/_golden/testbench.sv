 module seqmult_tb;

//port declaration
reg   [ 7:0]   in_a                                               ;//8 bit multiplicand declaration
reg   [ 7:0]   in_b                                               ;//8 bitmultiplier declaration
reg            clk                                                ;//clock declaration
reg            load                                               ;//load declaration
reg            reset                                              ;//reset declaration
reg   [15:0]   new_out                                            ;//register for testbench output
reg            new_valid                                          ;//register for testbench valid signal
wire           out_valid                                          ;//wire for valid signal declaration
wire  [15:0]   out_prod                                           ;//16 bit output product declaration

integer total_tests = 0;
integer failed_tests = 0;

//instantiation of the design under the test
seqmult dut(
            .in_a       (in_a       )                             ,//input
            .in_b       (in_b       )                             ,//input
            .clk        (clk        )                             ,//clock
            .load       (load       )                             ,//load
            .reset      (reset      )                             ,//reset
            .out_valid  (out_valid  )                             ,//output valid signal
            .out_prod   (out_prod   )                              //output product
             )                                                    ;


initial begin
   clk            = 1'b0                                          ;//clock initialization
   forever #5 clk = ~clk                                          ;//toggling clock
end

initial begin
   reset       = 1                                                ;//initialize reset
   load        = 1                                                ;//load to 1 
   #20 reset   = 0                                                ;//reset to 0
   repeat(20) begin
        in_a = $random % 256                                              ;//random input generation
      in_b = $random % 256                                             ;//random input generation
        #20 check;
    end
   #200
   reset       = 1                                                ;//initialize reset
   load        = 0                                                ;//load to 1 
   #20 reset   = 0                                                ;//reset to 0
    #200
   reset       = 1                                                ;//initialize reset
   load        = 1                                                ;//load to 1 
   #20 reset   = 0                                                ;//reset to 0
   repeat(20) begin
        in_a = $random % 256                                              ;//random input generation
      in_b = $random % 256                                             ;//random input generation
        #20 check;
    end
   $display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
   $finish                                                   ;//end execution with delay
end

//reference model
always @ (posedge clk or posedge reset)
   begin
      if (reset)
         begin
            new_out    <= 16'bz                                   ;//no output
            new_valid  <= 1'b0                                    ;//invalid output
         end
      else
         begin
            if (load)
               new_out     <= in_a * in_b                         ;
               new_valid   <=  1'b1                               ;//valid signal to 1
         end
   end

//check
    task check;
        begin
                total_tests = total_tests + 1;
                if (new_out == out_prod && new_valid == out_valid) begin
                  $display("\033[1;32mtime = %0t, new_out = %d, out_prod = %d, new_valid = %b, out_valid = %b, testcase is passed!!!\033[0m",$time,new_out,out_prod,new_valid,out_valid);
             end
         else begin
                 $display("\033[1;31mtime = %0t,new_out = %d, out_prod = %d, new_valid = %b, out_valid = %b, testcase is failed!!!\033[0m",$time,new_out,out_prod,new_valid,out_valid);
                 failed_tests = failed_tests + 1;
         end
        end
        endtask





endmodule                                                          //end of testbench