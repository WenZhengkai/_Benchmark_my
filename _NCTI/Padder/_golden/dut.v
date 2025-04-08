module padder_ref(clk, reset, in, in_ready, is_last, byte_num, buffer_full_ref, out_ref, out_ready_ref, f_ack);
    input              clk, reset;
    input      [63:0]  in;
    input              in_ready, is_last;
    input      [2:0]   byte_num;
    output             buffer_full_ref; /* to "user" module */
    output reg [575:0] out_ref;         /* to "f_permutation" module */
    output             out_ready_ref;   /* to "f_permutation" module */
    input              f_ack;       /* from "f_permutation" module */

    reg                state;       /* state == 0: user will send more input data
                                     * state == 1: user will not send any data */
    reg                done;        /* == 1: out_ready_ref should be 0 */
    reg        [8:0]   i;           /* length of "out_ref" buffer */
    wire       [63:0]  v0;          /* output of module "padder1" */
    reg        [63:0]  v1;          /* to be shifted into register "out_ref" */
    wire               accept,      /* accept user input? */
                       update;

    assign buffer_full_ref = i[8];
    assign out_ready_ref = buffer_full_ref;
    assign accept = (~ state) & in_ready & (~ buffer_full_ref); // if state == 1, do not eat input
    assign update = (accept | (state & (~ buffer_full_ref))) & (~ done); // don't fill buffer if done

    always @ (posedge clk)
      if (reset)
        out_ref <= 0;
      else if (update)
        out_ref <= {out_ref[575-64:0], v1};

    always @ (posedge clk)
      if (reset)
        i <= 0;
      else if (f_ack | update)
        i <= {i[7:0], 1'b1} & {9{~ f_ack}};
/*    if (f_ack)  i <= 0; */
/*    if (update) i <= {i[7:0], 1'b1}; // increase length */

    always @ (posedge clk)
      if (reset)
        state <= 0;
      else if (is_last)
        state <= 1;

    always @ (posedge clk)
      if (reset)
        done <= 0;
      else if (state & out_ready_ref)
        done <= 1;

    padder1_ref p0 (in, byte_num, v0);

    always @ (*)
      begin
        if (state)
          begin
            v1 = 0;
            v1[7] = v1[7] | i[7]; /* "v1[7]" is the MSB of its last byte */
          end
        else if (is_last == 0)
          v1 = in;
        else
          begin
            v1 = v0;
            v1[7] = v1[7] | i[7];
          end
      end
endmodulemodule padder_ref(clk, reset, in, in_ready, is_last, byte_num, buffer_full_ref, out_ref, out_ready_ref, f_ack);
    input              clk, reset;
    input      [63:0]  in;
    input              in_ready, is_last;
    input      [2:0]   byte_num;
    output             buffer_full_ref; /* to "user" module */
    output reg [575:0] out_ref;         /* to "f_permutation" module */
    output             out_ready_ref;   /* to "f_permutation" module */
    input              f_ack;       /* from "f_permutation" module */

    reg                state;       /* state == 0: user will send more input data
                                     * state == 1: user will not send any data */
    reg                done;        /* == 1: out_ready_ref should be 0 */
    reg        [8:0]   i;           /* length of "out_ref" buffer */
    wire       [63:0]  v0;          /* output of module "padder1" */
    reg        [63:0]  v1;          /* to be shifted into register "out_ref" */
    wire               accept,      /* accept user input? */
                       update;

    assign buffer_full_ref = i[8];
    assign out_ready_ref = buffer_full_ref;
    assign accept = (~ state) & in_ready & (~ buffer_full_ref); // if state == 1, do not eat input
    assign update = (accept | (state & (~ buffer_full_ref))) & (~ done); // don't fill buffer if done

    always @ (posedge clk)
      if (reset)
        out_ref <= 0;
      else if (update)
        out_ref <= {out_ref[575-64:0], v1};

    always @ (posedge clk)
      if (reset)
        i <= 0;
      else if (f_ack | update)
        i <= {i[7:0], 1'b1} & {9{~ f_ack}};
/*    if (f_ack)  i <= 0; */
/*    if (update) i <= {i[7:0], 1'b1}; // increase length */

    always @ (posedge clk)
      if (reset)
        state <= 0;
      else if (is_last)
        state <= 1;

    always @ (posedge clk)
      if (reset)
        done <= 0;
      else if (state & out_ready_ref)
        done <= 1;

    padder1_ref p0 (in, byte_num, v0);

    always @ (*)
      begin
        if (state)
          begin
            v1 = 0;
            v1[7] = v1[7] | i[7]; /* "v1[7]" is the MSB of its last byte */
          end
        else if (is_last == 0)
          v1 = in;
        else
          begin
            v1 = v0;
            v1[7] = v1[7] | i[7];
          end
      end
endmodule
module padder1_ref(in, byte_num, out_ref);
    input      [63:0] in;
    input      [2:0]  byte_num;
    output reg [63:0] out_ref;

    always @ (*)
      case (byte_num)
        0: out_ref =             64'h0100000000000000;
        1: out_ref = {in[63:56], 56'h01000000000000};
        2: out_ref = {in[63:48], 48'h010000000000};
        3: out_ref = {in[63:40], 40'h0100000000};
        4: out_ref = {in[63:32], 32'h01000000};
        5: out_ref = {in[63:24], 24'h010000};
        6: out_ref = {in[63:16], 16'h0100};
        7: out_ref = {in[63:8],   8'h01};
      endcase
endmodule