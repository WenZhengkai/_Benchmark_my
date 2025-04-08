circuit dut :
  module FullAdder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire carry : UInt<1>[17] @[dut.scala 31:19]
    carry[0] <= io.cin @[dut.scala 32:12]
    wire sum : UInt<1>[16] @[dut.scala 34:17]
    inst fa of FullAdder @[dut.scala 37:20]
    fa.clock <= clock
    fa.reset <= reset
    node _fa_io_a_T = bits(io.a, 0, 0) @[dut.scala 38:20]
    fa.io.a <= _fa_io_a_T @[dut.scala 38:13]
    node _fa_io_b_T = bits(io.b, 0, 0) @[dut.scala 39:20]
    fa.io.b <= _fa_io_b_T @[dut.scala 39:13]
    fa.io.cin <= carry[0] @[dut.scala 40:15]
    sum[0] <= fa.io.sum @[dut.scala 41:12]
    carry[1] <= fa.io.cout @[dut.scala 42:18]
    inst fa_1 of FullAdder_1 @[dut.scala 37:20]
    fa_1.clock <= clock
    fa_1.reset <= reset
    node _fa_io_a_T_1 = bits(io.a, 1, 1) @[dut.scala 38:20]
    fa_1.io.a <= _fa_io_a_T_1 @[dut.scala 38:13]
    node _fa_io_b_T_1 = bits(io.b, 1, 1) @[dut.scala 39:20]
    fa_1.io.b <= _fa_io_b_T_1 @[dut.scala 39:13]
    fa_1.io.cin <= carry[1] @[dut.scala 40:15]
    sum[1] <= fa_1.io.sum @[dut.scala 41:12]
    carry[2] <= fa_1.io.cout @[dut.scala 42:18]
    inst fa_2 of FullAdder_2 @[dut.scala 37:20]
    fa_2.clock <= clock
    fa_2.reset <= reset
    node _fa_io_a_T_2 = bits(io.a, 2, 2) @[dut.scala 38:20]
    fa_2.io.a <= _fa_io_a_T_2 @[dut.scala 38:13]
    node _fa_io_b_T_2 = bits(io.b, 2, 2) @[dut.scala 39:20]
    fa_2.io.b <= _fa_io_b_T_2 @[dut.scala 39:13]
    fa_2.io.cin <= carry[2] @[dut.scala 40:15]
    sum[2] <= fa_2.io.sum @[dut.scala 41:12]
    carry[3] <= fa_2.io.cout @[dut.scala 42:18]
    inst fa_3 of FullAdder_3 @[dut.scala 37:20]
    fa_3.clock <= clock
    fa_3.reset <= reset
    node _fa_io_a_T_3 = bits(io.a, 3, 3) @[dut.scala 38:20]
    fa_3.io.a <= _fa_io_a_T_3 @[dut.scala 38:13]
    node _fa_io_b_T_3 = bits(io.b, 3, 3) @[dut.scala 39:20]
    fa_3.io.b <= _fa_io_b_T_3 @[dut.scala 39:13]
    fa_3.io.cin <= carry[3] @[dut.scala 40:15]
    sum[3] <= fa_3.io.sum @[dut.scala 41:12]
    carry[4] <= fa_3.io.cout @[dut.scala 42:18]
    inst fa_4 of FullAdder_4 @[dut.scala 37:20]
    fa_4.clock <= clock
    fa_4.reset <= reset
    node _fa_io_a_T_4 = bits(io.a, 4, 4) @[dut.scala 38:20]
    fa_4.io.a <= _fa_io_a_T_4 @[dut.scala 38:13]
    node _fa_io_b_T_4 = bits(io.b, 4, 4) @[dut.scala 39:20]
    fa_4.io.b <= _fa_io_b_T_4 @[dut.scala 39:13]
    fa_4.io.cin <= carry[4] @[dut.scala 40:15]
    sum[4] <= fa_4.io.sum @[dut.scala 41:12]
    carry[5] <= fa_4.io.cout @[dut.scala 42:18]
    inst fa_5 of FullAdder_5 @[dut.scala 37:20]
    fa_5.clock <= clock
    fa_5.reset <= reset
    node _fa_io_a_T_5 = bits(io.a, 5, 5) @[dut.scala 38:20]
    fa_5.io.a <= _fa_io_a_T_5 @[dut.scala 38:13]
    node _fa_io_b_T_5 = bits(io.b, 5, 5) @[dut.scala 39:20]
    fa_5.io.b <= _fa_io_b_T_5 @[dut.scala 39:13]
    fa_5.io.cin <= carry[5] @[dut.scala 40:15]
    sum[5] <= fa_5.io.sum @[dut.scala 41:12]
    carry[6] <= fa_5.io.cout @[dut.scala 42:18]
    inst fa_6 of FullAdder_6 @[dut.scala 37:20]
    fa_6.clock <= clock
    fa_6.reset <= reset
    node _fa_io_a_T_6 = bits(io.a, 6, 6) @[dut.scala 38:20]
    fa_6.io.a <= _fa_io_a_T_6 @[dut.scala 38:13]
    node _fa_io_b_T_6 = bits(io.b, 6, 6) @[dut.scala 39:20]
    fa_6.io.b <= _fa_io_b_T_6 @[dut.scala 39:13]
    fa_6.io.cin <= carry[6] @[dut.scala 40:15]
    sum[6] <= fa_6.io.sum @[dut.scala 41:12]
    carry[7] <= fa_6.io.cout @[dut.scala 42:18]
    inst fa_7 of FullAdder_7 @[dut.scala 37:20]
    fa_7.clock <= clock
    fa_7.reset <= reset
    node _fa_io_a_T_7 = bits(io.a, 7, 7) @[dut.scala 38:20]
    fa_7.io.a <= _fa_io_a_T_7 @[dut.scala 38:13]
    node _fa_io_b_T_7 = bits(io.b, 7, 7) @[dut.scala 39:20]
    fa_7.io.b <= _fa_io_b_T_7 @[dut.scala 39:13]
    fa_7.io.cin <= carry[7] @[dut.scala 40:15]
    sum[7] <= fa_7.io.sum @[dut.scala 41:12]
    carry[8] <= fa_7.io.cout @[dut.scala 42:18]
    inst fa_8 of FullAdder_8 @[dut.scala 37:20]
    fa_8.clock <= clock
    fa_8.reset <= reset
    node _fa_io_a_T_8 = bits(io.a, 8, 8) @[dut.scala 38:20]
    fa_8.io.a <= _fa_io_a_T_8 @[dut.scala 38:13]
    node _fa_io_b_T_8 = bits(io.b, 8, 8) @[dut.scala 39:20]
    fa_8.io.b <= _fa_io_b_T_8 @[dut.scala 39:13]
    fa_8.io.cin <= carry[8] @[dut.scala 40:15]
    sum[8] <= fa_8.io.sum @[dut.scala 41:12]
    carry[9] <= fa_8.io.cout @[dut.scala 42:18]
    inst fa_9 of FullAdder_9 @[dut.scala 37:20]
    fa_9.clock <= clock
    fa_9.reset <= reset
    node _fa_io_a_T_9 = bits(io.a, 9, 9) @[dut.scala 38:20]
    fa_9.io.a <= _fa_io_a_T_9 @[dut.scala 38:13]
    node _fa_io_b_T_9 = bits(io.b, 9, 9) @[dut.scala 39:20]
    fa_9.io.b <= _fa_io_b_T_9 @[dut.scala 39:13]
    fa_9.io.cin <= carry[9] @[dut.scala 40:15]
    sum[9] <= fa_9.io.sum @[dut.scala 41:12]
    carry[10] <= fa_9.io.cout @[dut.scala 42:18]
    inst fa_10 of FullAdder_10 @[dut.scala 37:20]
    fa_10.clock <= clock
    fa_10.reset <= reset
    node _fa_io_a_T_10 = bits(io.a, 10, 10) @[dut.scala 38:20]
    fa_10.io.a <= _fa_io_a_T_10 @[dut.scala 38:13]
    node _fa_io_b_T_10 = bits(io.b, 10, 10) @[dut.scala 39:20]
    fa_10.io.b <= _fa_io_b_T_10 @[dut.scala 39:13]
    fa_10.io.cin <= carry[10] @[dut.scala 40:15]
    sum[10] <= fa_10.io.sum @[dut.scala 41:12]
    carry[11] <= fa_10.io.cout @[dut.scala 42:18]
    inst fa_11 of FullAdder_11 @[dut.scala 37:20]
    fa_11.clock <= clock
    fa_11.reset <= reset
    node _fa_io_a_T_11 = bits(io.a, 11, 11) @[dut.scala 38:20]
    fa_11.io.a <= _fa_io_a_T_11 @[dut.scala 38:13]
    node _fa_io_b_T_11 = bits(io.b, 11, 11) @[dut.scala 39:20]
    fa_11.io.b <= _fa_io_b_T_11 @[dut.scala 39:13]
    fa_11.io.cin <= carry[11] @[dut.scala 40:15]
    sum[11] <= fa_11.io.sum @[dut.scala 41:12]
    carry[12] <= fa_11.io.cout @[dut.scala 42:18]
    inst fa_12 of FullAdder_12 @[dut.scala 37:20]
    fa_12.clock <= clock
    fa_12.reset <= reset
    node _fa_io_a_T_12 = bits(io.a, 12, 12) @[dut.scala 38:20]
    fa_12.io.a <= _fa_io_a_T_12 @[dut.scala 38:13]
    node _fa_io_b_T_12 = bits(io.b, 12, 12) @[dut.scala 39:20]
    fa_12.io.b <= _fa_io_b_T_12 @[dut.scala 39:13]
    fa_12.io.cin <= carry[12] @[dut.scala 40:15]
    sum[12] <= fa_12.io.sum @[dut.scala 41:12]
    carry[13] <= fa_12.io.cout @[dut.scala 42:18]
    inst fa_13 of FullAdder_13 @[dut.scala 37:20]
    fa_13.clock <= clock
    fa_13.reset <= reset
    node _fa_io_a_T_13 = bits(io.a, 13, 13) @[dut.scala 38:20]
    fa_13.io.a <= _fa_io_a_T_13 @[dut.scala 38:13]
    node _fa_io_b_T_13 = bits(io.b, 13, 13) @[dut.scala 39:20]
    fa_13.io.b <= _fa_io_b_T_13 @[dut.scala 39:13]
    fa_13.io.cin <= carry[13] @[dut.scala 40:15]
    sum[13] <= fa_13.io.sum @[dut.scala 41:12]
    carry[14] <= fa_13.io.cout @[dut.scala 42:18]
    inst fa_14 of FullAdder_14 @[dut.scala 37:20]
    fa_14.clock <= clock
    fa_14.reset <= reset
    node _fa_io_a_T_14 = bits(io.a, 14, 14) @[dut.scala 38:20]
    fa_14.io.a <= _fa_io_a_T_14 @[dut.scala 38:13]
    node _fa_io_b_T_14 = bits(io.b, 14, 14) @[dut.scala 39:20]
    fa_14.io.b <= _fa_io_b_T_14 @[dut.scala 39:13]
    fa_14.io.cin <= carry[14] @[dut.scala 40:15]
    sum[14] <= fa_14.io.sum @[dut.scala 41:12]
    carry[15] <= fa_14.io.cout @[dut.scala 42:18]
    inst fa_15 of FullAdder_15 @[dut.scala 37:20]
    fa_15.clock <= clock
    fa_15.reset <= reset
    node _fa_io_a_T_15 = bits(io.a, 15, 15) @[dut.scala 38:20]
    fa_15.io.a <= _fa_io_a_T_15 @[dut.scala 38:13]
    node _fa_io_b_T_15 = bits(io.b, 15, 15) @[dut.scala 39:20]
    fa_15.io.b <= _fa_io_b_T_15 @[dut.scala 39:13]
    fa_15.io.cin <= carry[15] @[dut.scala 40:15]
    sum[15] <= fa_15.io.sum @[dut.scala 41:12]
    carry[16] <= fa_15.io.cout @[dut.scala 42:18]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 45:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 45:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 45:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 45:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 45:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 45:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 45:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 45:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 45:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 45:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 45:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 45:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 45:17]
    io.sum <= _io_sum_T @[dut.scala 45:10]
    io.cout <= carry[16] @[dut.scala 46:11]

  module FullAdder_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_20 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_21 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_22 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_23 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_24 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_25 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_26 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_27 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_28 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_29 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_30 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_31 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire carry : UInt<1>[17] @[dut.scala 31:19]
    carry[0] <= io.cin @[dut.scala 32:12]
    wire sum : UInt<1>[16] @[dut.scala 34:17]
    inst fa of FullAdder_16 @[dut.scala 37:20]
    fa.clock <= clock
    fa.reset <= reset
    node _fa_io_a_T = bits(io.a, 0, 0) @[dut.scala 38:20]
    fa.io.a <= _fa_io_a_T @[dut.scala 38:13]
    node _fa_io_b_T = bits(io.b, 0, 0) @[dut.scala 39:20]
    fa.io.b <= _fa_io_b_T @[dut.scala 39:13]
    fa.io.cin <= carry[0] @[dut.scala 40:15]
    sum[0] <= fa.io.sum @[dut.scala 41:12]
    carry[1] <= fa.io.cout @[dut.scala 42:18]
    inst fa_1 of FullAdder_17 @[dut.scala 37:20]
    fa_1.clock <= clock
    fa_1.reset <= reset
    node _fa_io_a_T_1 = bits(io.a, 1, 1) @[dut.scala 38:20]
    fa_1.io.a <= _fa_io_a_T_1 @[dut.scala 38:13]
    node _fa_io_b_T_1 = bits(io.b, 1, 1) @[dut.scala 39:20]
    fa_1.io.b <= _fa_io_b_T_1 @[dut.scala 39:13]
    fa_1.io.cin <= carry[1] @[dut.scala 40:15]
    sum[1] <= fa_1.io.sum @[dut.scala 41:12]
    carry[2] <= fa_1.io.cout @[dut.scala 42:18]
    inst fa_2 of FullAdder_18 @[dut.scala 37:20]
    fa_2.clock <= clock
    fa_2.reset <= reset
    node _fa_io_a_T_2 = bits(io.a, 2, 2) @[dut.scala 38:20]
    fa_2.io.a <= _fa_io_a_T_2 @[dut.scala 38:13]
    node _fa_io_b_T_2 = bits(io.b, 2, 2) @[dut.scala 39:20]
    fa_2.io.b <= _fa_io_b_T_2 @[dut.scala 39:13]
    fa_2.io.cin <= carry[2] @[dut.scala 40:15]
    sum[2] <= fa_2.io.sum @[dut.scala 41:12]
    carry[3] <= fa_2.io.cout @[dut.scala 42:18]
    inst fa_3 of FullAdder_19 @[dut.scala 37:20]
    fa_3.clock <= clock
    fa_3.reset <= reset
    node _fa_io_a_T_3 = bits(io.a, 3, 3) @[dut.scala 38:20]
    fa_3.io.a <= _fa_io_a_T_3 @[dut.scala 38:13]
    node _fa_io_b_T_3 = bits(io.b, 3, 3) @[dut.scala 39:20]
    fa_3.io.b <= _fa_io_b_T_3 @[dut.scala 39:13]
    fa_3.io.cin <= carry[3] @[dut.scala 40:15]
    sum[3] <= fa_3.io.sum @[dut.scala 41:12]
    carry[4] <= fa_3.io.cout @[dut.scala 42:18]
    inst fa_4 of FullAdder_20 @[dut.scala 37:20]
    fa_4.clock <= clock
    fa_4.reset <= reset
    node _fa_io_a_T_4 = bits(io.a, 4, 4) @[dut.scala 38:20]
    fa_4.io.a <= _fa_io_a_T_4 @[dut.scala 38:13]
    node _fa_io_b_T_4 = bits(io.b, 4, 4) @[dut.scala 39:20]
    fa_4.io.b <= _fa_io_b_T_4 @[dut.scala 39:13]
    fa_4.io.cin <= carry[4] @[dut.scala 40:15]
    sum[4] <= fa_4.io.sum @[dut.scala 41:12]
    carry[5] <= fa_4.io.cout @[dut.scala 42:18]
    inst fa_5 of FullAdder_21 @[dut.scala 37:20]
    fa_5.clock <= clock
    fa_5.reset <= reset
    node _fa_io_a_T_5 = bits(io.a, 5, 5) @[dut.scala 38:20]
    fa_5.io.a <= _fa_io_a_T_5 @[dut.scala 38:13]
    node _fa_io_b_T_5 = bits(io.b, 5, 5) @[dut.scala 39:20]
    fa_5.io.b <= _fa_io_b_T_5 @[dut.scala 39:13]
    fa_5.io.cin <= carry[5] @[dut.scala 40:15]
    sum[5] <= fa_5.io.sum @[dut.scala 41:12]
    carry[6] <= fa_5.io.cout @[dut.scala 42:18]
    inst fa_6 of FullAdder_22 @[dut.scala 37:20]
    fa_6.clock <= clock
    fa_6.reset <= reset
    node _fa_io_a_T_6 = bits(io.a, 6, 6) @[dut.scala 38:20]
    fa_6.io.a <= _fa_io_a_T_6 @[dut.scala 38:13]
    node _fa_io_b_T_6 = bits(io.b, 6, 6) @[dut.scala 39:20]
    fa_6.io.b <= _fa_io_b_T_6 @[dut.scala 39:13]
    fa_6.io.cin <= carry[6] @[dut.scala 40:15]
    sum[6] <= fa_6.io.sum @[dut.scala 41:12]
    carry[7] <= fa_6.io.cout @[dut.scala 42:18]
    inst fa_7 of FullAdder_23 @[dut.scala 37:20]
    fa_7.clock <= clock
    fa_7.reset <= reset
    node _fa_io_a_T_7 = bits(io.a, 7, 7) @[dut.scala 38:20]
    fa_7.io.a <= _fa_io_a_T_7 @[dut.scala 38:13]
    node _fa_io_b_T_7 = bits(io.b, 7, 7) @[dut.scala 39:20]
    fa_7.io.b <= _fa_io_b_T_7 @[dut.scala 39:13]
    fa_7.io.cin <= carry[7] @[dut.scala 40:15]
    sum[7] <= fa_7.io.sum @[dut.scala 41:12]
    carry[8] <= fa_7.io.cout @[dut.scala 42:18]
    inst fa_8 of FullAdder_24 @[dut.scala 37:20]
    fa_8.clock <= clock
    fa_8.reset <= reset
    node _fa_io_a_T_8 = bits(io.a, 8, 8) @[dut.scala 38:20]
    fa_8.io.a <= _fa_io_a_T_8 @[dut.scala 38:13]
    node _fa_io_b_T_8 = bits(io.b, 8, 8) @[dut.scala 39:20]
    fa_8.io.b <= _fa_io_b_T_8 @[dut.scala 39:13]
    fa_8.io.cin <= carry[8] @[dut.scala 40:15]
    sum[8] <= fa_8.io.sum @[dut.scala 41:12]
    carry[9] <= fa_8.io.cout @[dut.scala 42:18]
    inst fa_9 of FullAdder_25 @[dut.scala 37:20]
    fa_9.clock <= clock
    fa_9.reset <= reset
    node _fa_io_a_T_9 = bits(io.a, 9, 9) @[dut.scala 38:20]
    fa_9.io.a <= _fa_io_a_T_9 @[dut.scala 38:13]
    node _fa_io_b_T_9 = bits(io.b, 9, 9) @[dut.scala 39:20]
    fa_9.io.b <= _fa_io_b_T_9 @[dut.scala 39:13]
    fa_9.io.cin <= carry[9] @[dut.scala 40:15]
    sum[9] <= fa_9.io.sum @[dut.scala 41:12]
    carry[10] <= fa_9.io.cout @[dut.scala 42:18]
    inst fa_10 of FullAdder_26 @[dut.scala 37:20]
    fa_10.clock <= clock
    fa_10.reset <= reset
    node _fa_io_a_T_10 = bits(io.a, 10, 10) @[dut.scala 38:20]
    fa_10.io.a <= _fa_io_a_T_10 @[dut.scala 38:13]
    node _fa_io_b_T_10 = bits(io.b, 10, 10) @[dut.scala 39:20]
    fa_10.io.b <= _fa_io_b_T_10 @[dut.scala 39:13]
    fa_10.io.cin <= carry[10] @[dut.scala 40:15]
    sum[10] <= fa_10.io.sum @[dut.scala 41:12]
    carry[11] <= fa_10.io.cout @[dut.scala 42:18]
    inst fa_11 of FullAdder_27 @[dut.scala 37:20]
    fa_11.clock <= clock
    fa_11.reset <= reset
    node _fa_io_a_T_11 = bits(io.a, 11, 11) @[dut.scala 38:20]
    fa_11.io.a <= _fa_io_a_T_11 @[dut.scala 38:13]
    node _fa_io_b_T_11 = bits(io.b, 11, 11) @[dut.scala 39:20]
    fa_11.io.b <= _fa_io_b_T_11 @[dut.scala 39:13]
    fa_11.io.cin <= carry[11] @[dut.scala 40:15]
    sum[11] <= fa_11.io.sum @[dut.scala 41:12]
    carry[12] <= fa_11.io.cout @[dut.scala 42:18]
    inst fa_12 of FullAdder_28 @[dut.scala 37:20]
    fa_12.clock <= clock
    fa_12.reset <= reset
    node _fa_io_a_T_12 = bits(io.a, 12, 12) @[dut.scala 38:20]
    fa_12.io.a <= _fa_io_a_T_12 @[dut.scala 38:13]
    node _fa_io_b_T_12 = bits(io.b, 12, 12) @[dut.scala 39:20]
    fa_12.io.b <= _fa_io_b_T_12 @[dut.scala 39:13]
    fa_12.io.cin <= carry[12] @[dut.scala 40:15]
    sum[12] <= fa_12.io.sum @[dut.scala 41:12]
    carry[13] <= fa_12.io.cout @[dut.scala 42:18]
    inst fa_13 of FullAdder_29 @[dut.scala 37:20]
    fa_13.clock <= clock
    fa_13.reset <= reset
    node _fa_io_a_T_13 = bits(io.a, 13, 13) @[dut.scala 38:20]
    fa_13.io.a <= _fa_io_a_T_13 @[dut.scala 38:13]
    node _fa_io_b_T_13 = bits(io.b, 13, 13) @[dut.scala 39:20]
    fa_13.io.b <= _fa_io_b_T_13 @[dut.scala 39:13]
    fa_13.io.cin <= carry[13] @[dut.scala 40:15]
    sum[13] <= fa_13.io.sum @[dut.scala 41:12]
    carry[14] <= fa_13.io.cout @[dut.scala 42:18]
    inst fa_14 of FullAdder_30 @[dut.scala 37:20]
    fa_14.clock <= clock
    fa_14.reset <= reset
    node _fa_io_a_T_14 = bits(io.a, 14, 14) @[dut.scala 38:20]
    fa_14.io.a <= _fa_io_a_T_14 @[dut.scala 38:13]
    node _fa_io_b_T_14 = bits(io.b, 14, 14) @[dut.scala 39:20]
    fa_14.io.b <= _fa_io_b_T_14 @[dut.scala 39:13]
    fa_14.io.cin <= carry[14] @[dut.scala 40:15]
    sum[14] <= fa_14.io.sum @[dut.scala 41:12]
    carry[15] <= fa_14.io.cout @[dut.scala 42:18]
    inst fa_15 of FullAdder_31 @[dut.scala 37:20]
    fa_15.clock <= clock
    fa_15.reset <= reset
    node _fa_io_a_T_15 = bits(io.a, 15, 15) @[dut.scala 38:20]
    fa_15.io.a <= _fa_io_a_T_15 @[dut.scala 38:13]
    node _fa_io_b_T_15 = bits(io.b, 15, 15) @[dut.scala 39:20]
    fa_15.io.b <= _fa_io_b_T_15 @[dut.scala 39:13]
    fa_15.io.cin <= carry[15] @[dut.scala 40:15]
    sum[15] <= fa_15.io.sum @[dut.scala 41:12]
    carry[16] <= fa_15.io.cout @[dut.scala 42:18]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 45:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 45:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 45:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 45:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 45:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 45:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 45:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 45:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 45:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 45:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 45:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 45:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 45:17]
    io.sum <= _io_sum_T @[dut.scala 45:10]
    io.cout <= carry[16] @[dut.scala 46:11]

  module FullAdder_32 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_33 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_34 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_35 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_36 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_37 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_38 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_39 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_40 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_41 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_42 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_43 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_44 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_45 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_46 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_47 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire carry : UInt<1>[17] @[dut.scala 31:19]
    carry[0] <= io.cin @[dut.scala 32:12]
    wire sum : UInt<1>[16] @[dut.scala 34:17]
    inst fa of FullAdder_32 @[dut.scala 37:20]
    fa.clock <= clock
    fa.reset <= reset
    node _fa_io_a_T = bits(io.a, 0, 0) @[dut.scala 38:20]
    fa.io.a <= _fa_io_a_T @[dut.scala 38:13]
    node _fa_io_b_T = bits(io.b, 0, 0) @[dut.scala 39:20]
    fa.io.b <= _fa_io_b_T @[dut.scala 39:13]
    fa.io.cin <= carry[0] @[dut.scala 40:15]
    sum[0] <= fa.io.sum @[dut.scala 41:12]
    carry[1] <= fa.io.cout @[dut.scala 42:18]
    inst fa_1 of FullAdder_33 @[dut.scala 37:20]
    fa_1.clock <= clock
    fa_1.reset <= reset
    node _fa_io_a_T_1 = bits(io.a, 1, 1) @[dut.scala 38:20]
    fa_1.io.a <= _fa_io_a_T_1 @[dut.scala 38:13]
    node _fa_io_b_T_1 = bits(io.b, 1, 1) @[dut.scala 39:20]
    fa_1.io.b <= _fa_io_b_T_1 @[dut.scala 39:13]
    fa_1.io.cin <= carry[1] @[dut.scala 40:15]
    sum[1] <= fa_1.io.sum @[dut.scala 41:12]
    carry[2] <= fa_1.io.cout @[dut.scala 42:18]
    inst fa_2 of FullAdder_34 @[dut.scala 37:20]
    fa_2.clock <= clock
    fa_2.reset <= reset
    node _fa_io_a_T_2 = bits(io.a, 2, 2) @[dut.scala 38:20]
    fa_2.io.a <= _fa_io_a_T_2 @[dut.scala 38:13]
    node _fa_io_b_T_2 = bits(io.b, 2, 2) @[dut.scala 39:20]
    fa_2.io.b <= _fa_io_b_T_2 @[dut.scala 39:13]
    fa_2.io.cin <= carry[2] @[dut.scala 40:15]
    sum[2] <= fa_2.io.sum @[dut.scala 41:12]
    carry[3] <= fa_2.io.cout @[dut.scala 42:18]
    inst fa_3 of FullAdder_35 @[dut.scala 37:20]
    fa_3.clock <= clock
    fa_3.reset <= reset
    node _fa_io_a_T_3 = bits(io.a, 3, 3) @[dut.scala 38:20]
    fa_3.io.a <= _fa_io_a_T_3 @[dut.scala 38:13]
    node _fa_io_b_T_3 = bits(io.b, 3, 3) @[dut.scala 39:20]
    fa_3.io.b <= _fa_io_b_T_3 @[dut.scala 39:13]
    fa_3.io.cin <= carry[3] @[dut.scala 40:15]
    sum[3] <= fa_3.io.sum @[dut.scala 41:12]
    carry[4] <= fa_3.io.cout @[dut.scala 42:18]
    inst fa_4 of FullAdder_36 @[dut.scala 37:20]
    fa_4.clock <= clock
    fa_4.reset <= reset
    node _fa_io_a_T_4 = bits(io.a, 4, 4) @[dut.scala 38:20]
    fa_4.io.a <= _fa_io_a_T_4 @[dut.scala 38:13]
    node _fa_io_b_T_4 = bits(io.b, 4, 4) @[dut.scala 39:20]
    fa_4.io.b <= _fa_io_b_T_4 @[dut.scala 39:13]
    fa_4.io.cin <= carry[4] @[dut.scala 40:15]
    sum[4] <= fa_4.io.sum @[dut.scala 41:12]
    carry[5] <= fa_4.io.cout @[dut.scala 42:18]
    inst fa_5 of FullAdder_37 @[dut.scala 37:20]
    fa_5.clock <= clock
    fa_5.reset <= reset
    node _fa_io_a_T_5 = bits(io.a, 5, 5) @[dut.scala 38:20]
    fa_5.io.a <= _fa_io_a_T_5 @[dut.scala 38:13]
    node _fa_io_b_T_5 = bits(io.b, 5, 5) @[dut.scala 39:20]
    fa_5.io.b <= _fa_io_b_T_5 @[dut.scala 39:13]
    fa_5.io.cin <= carry[5] @[dut.scala 40:15]
    sum[5] <= fa_5.io.sum @[dut.scala 41:12]
    carry[6] <= fa_5.io.cout @[dut.scala 42:18]
    inst fa_6 of FullAdder_38 @[dut.scala 37:20]
    fa_6.clock <= clock
    fa_6.reset <= reset
    node _fa_io_a_T_6 = bits(io.a, 6, 6) @[dut.scala 38:20]
    fa_6.io.a <= _fa_io_a_T_6 @[dut.scala 38:13]
    node _fa_io_b_T_6 = bits(io.b, 6, 6) @[dut.scala 39:20]
    fa_6.io.b <= _fa_io_b_T_6 @[dut.scala 39:13]
    fa_6.io.cin <= carry[6] @[dut.scala 40:15]
    sum[6] <= fa_6.io.sum @[dut.scala 41:12]
    carry[7] <= fa_6.io.cout @[dut.scala 42:18]
    inst fa_7 of FullAdder_39 @[dut.scala 37:20]
    fa_7.clock <= clock
    fa_7.reset <= reset
    node _fa_io_a_T_7 = bits(io.a, 7, 7) @[dut.scala 38:20]
    fa_7.io.a <= _fa_io_a_T_7 @[dut.scala 38:13]
    node _fa_io_b_T_7 = bits(io.b, 7, 7) @[dut.scala 39:20]
    fa_7.io.b <= _fa_io_b_T_7 @[dut.scala 39:13]
    fa_7.io.cin <= carry[7] @[dut.scala 40:15]
    sum[7] <= fa_7.io.sum @[dut.scala 41:12]
    carry[8] <= fa_7.io.cout @[dut.scala 42:18]
    inst fa_8 of FullAdder_40 @[dut.scala 37:20]
    fa_8.clock <= clock
    fa_8.reset <= reset
    node _fa_io_a_T_8 = bits(io.a, 8, 8) @[dut.scala 38:20]
    fa_8.io.a <= _fa_io_a_T_8 @[dut.scala 38:13]
    node _fa_io_b_T_8 = bits(io.b, 8, 8) @[dut.scala 39:20]
    fa_8.io.b <= _fa_io_b_T_8 @[dut.scala 39:13]
    fa_8.io.cin <= carry[8] @[dut.scala 40:15]
    sum[8] <= fa_8.io.sum @[dut.scala 41:12]
    carry[9] <= fa_8.io.cout @[dut.scala 42:18]
    inst fa_9 of FullAdder_41 @[dut.scala 37:20]
    fa_9.clock <= clock
    fa_9.reset <= reset
    node _fa_io_a_T_9 = bits(io.a, 9, 9) @[dut.scala 38:20]
    fa_9.io.a <= _fa_io_a_T_9 @[dut.scala 38:13]
    node _fa_io_b_T_9 = bits(io.b, 9, 9) @[dut.scala 39:20]
    fa_9.io.b <= _fa_io_b_T_9 @[dut.scala 39:13]
    fa_9.io.cin <= carry[9] @[dut.scala 40:15]
    sum[9] <= fa_9.io.sum @[dut.scala 41:12]
    carry[10] <= fa_9.io.cout @[dut.scala 42:18]
    inst fa_10 of FullAdder_42 @[dut.scala 37:20]
    fa_10.clock <= clock
    fa_10.reset <= reset
    node _fa_io_a_T_10 = bits(io.a, 10, 10) @[dut.scala 38:20]
    fa_10.io.a <= _fa_io_a_T_10 @[dut.scala 38:13]
    node _fa_io_b_T_10 = bits(io.b, 10, 10) @[dut.scala 39:20]
    fa_10.io.b <= _fa_io_b_T_10 @[dut.scala 39:13]
    fa_10.io.cin <= carry[10] @[dut.scala 40:15]
    sum[10] <= fa_10.io.sum @[dut.scala 41:12]
    carry[11] <= fa_10.io.cout @[dut.scala 42:18]
    inst fa_11 of FullAdder_43 @[dut.scala 37:20]
    fa_11.clock <= clock
    fa_11.reset <= reset
    node _fa_io_a_T_11 = bits(io.a, 11, 11) @[dut.scala 38:20]
    fa_11.io.a <= _fa_io_a_T_11 @[dut.scala 38:13]
    node _fa_io_b_T_11 = bits(io.b, 11, 11) @[dut.scala 39:20]
    fa_11.io.b <= _fa_io_b_T_11 @[dut.scala 39:13]
    fa_11.io.cin <= carry[11] @[dut.scala 40:15]
    sum[11] <= fa_11.io.sum @[dut.scala 41:12]
    carry[12] <= fa_11.io.cout @[dut.scala 42:18]
    inst fa_12 of FullAdder_44 @[dut.scala 37:20]
    fa_12.clock <= clock
    fa_12.reset <= reset
    node _fa_io_a_T_12 = bits(io.a, 12, 12) @[dut.scala 38:20]
    fa_12.io.a <= _fa_io_a_T_12 @[dut.scala 38:13]
    node _fa_io_b_T_12 = bits(io.b, 12, 12) @[dut.scala 39:20]
    fa_12.io.b <= _fa_io_b_T_12 @[dut.scala 39:13]
    fa_12.io.cin <= carry[12] @[dut.scala 40:15]
    sum[12] <= fa_12.io.sum @[dut.scala 41:12]
    carry[13] <= fa_12.io.cout @[dut.scala 42:18]
    inst fa_13 of FullAdder_45 @[dut.scala 37:20]
    fa_13.clock <= clock
    fa_13.reset <= reset
    node _fa_io_a_T_13 = bits(io.a, 13, 13) @[dut.scala 38:20]
    fa_13.io.a <= _fa_io_a_T_13 @[dut.scala 38:13]
    node _fa_io_b_T_13 = bits(io.b, 13, 13) @[dut.scala 39:20]
    fa_13.io.b <= _fa_io_b_T_13 @[dut.scala 39:13]
    fa_13.io.cin <= carry[13] @[dut.scala 40:15]
    sum[13] <= fa_13.io.sum @[dut.scala 41:12]
    carry[14] <= fa_13.io.cout @[dut.scala 42:18]
    inst fa_14 of FullAdder_46 @[dut.scala 37:20]
    fa_14.clock <= clock
    fa_14.reset <= reset
    node _fa_io_a_T_14 = bits(io.a, 14, 14) @[dut.scala 38:20]
    fa_14.io.a <= _fa_io_a_T_14 @[dut.scala 38:13]
    node _fa_io_b_T_14 = bits(io.b, 14, 14) @[dut.scala 39:20]
    fa_14.io.b <= _fa_io_b_T_14 @[dut.scala 39:13]
    fa_14.io.cin <= carry[14] @[dut.scala 40:15]
    sum[14] <= fa_14.io.sum @[dut.scala 41:12]
    carry[15] <= fa_14.io.cout @[dut.scala 42:18]
    inst fa_15 of FullAdder_47 @[dut.scala 37:20]
    fa_15.clock <= clock
    fa_15.reset <= reset
    node _fa_io_a_T_15 = bits(io.a, 15, 15) @[dut.scala 38:20]
    fa_15.io.a <= _fa_io_a_T_15 @[dut.scala 38:13]
    node _fa_io_b_T_15 = bits(io.b, 15, 15) @[dut.scala 39:20]
    fa_15.io.b <= _fa_io_b_T_15 @[dut.scala 39:13]
    fa_15.io.cin <= carry[15] @[dut.scala 40:15]
    sum[15] <= fa_15.io.sum @[dut.scala 41:12]
    carry[16] <= fa_15.io.cout @[dut.scala 42:18]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 45:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 45:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 45:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 45:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 45:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 45:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 45:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 45:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 45:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 45:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 45:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 45:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 45:17]
    io.sum <= _io_sum_T @[dut.scala 45:10]
    io.cout <= carry[16] @[dut.scala 46:11]

  module FullAdder_48 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_49 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_50 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_51 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_52 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_53 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_54 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_55 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_56 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_57 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_58 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_59 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_60 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_61 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_62 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module FullAdder_63 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _sum_T = xor(io.a, io.b) @[dut.scala 14:18]
    node sum = xor(_sum_T, io.cin) @[dut.scala 14:25]
    node _cout_T = and(io.a, io.b) @[dut.scala 15:20]
    node _cout_T_1 = and(io.a, io.cin) @[dut.scala 15:36]
    node _cout_T_2 = or(_cout_T, _cout_T_1) @[dut.scala 15:28]
    node _cout_T_3 = and(io.b, io.cin) @[dut.scala 15:54]
    node cout = or(_cout_T_2, _cout_T_3) @[dut.scala 15:46]
    io.sum <= sum @[dut.scala 17:10]
    io.cout <= cout @[dut.scala 18:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire carry : UInt<1>[17] @[dut.scala 31:19]
    carry[0] <= io.cin @[dut.scala 32:12]
    wire sum : UInt<1>[16] @[dut.scala 34:17]
    inst fa of FullAdder_48 @[dut.scala 37:20]
    fa.clock <= clock
    fa.reset <= reset
    node _fa_io_a_T = bits(io.a, 0, 0) @[dut.scala 38:20]
    fa.io.a <= _fa_io_a_T @[dut.scala 38:13]
    node _fa_io_b_T = bits(io.b, 0, 0) @[dut.scala 39:20]
    fa.io.b <= _fa_io_b_T @[dut.scala 39:13]
    fa.io.cin <= carry[0] @[dut.scala 40:15]
    sum[0] <= fa.io.sum @[dut.scala 41:12]
    carry[1] <= fa.io.cout @[dut.scala 42:18]
    inst fa_1 of FullAdder_49 @[dut.scala 37:20]
    fa_1.clock <= clock
    fa_1.reset <= reset
    node _fa_io_a_T_1 = bits(io.a, 1, 1) @[dut.scala 38:20]
    fa_1.io.a <= _fa_io_a_T_1 @[dut.scala 38:13]
    node _fa_io_b_T_1 = bits(io.b, 1, 1) @[dut.scala 39:20]
    fa_1.io.b <= _fa_io_b_T_1 @[dut.scala 39:13]
    fa_1.io.cin <= carry[1] @[dut.scala 40:15]
    sum[1] <= fa_1.io.sum @[dut.scala 41:12]
    carry[2] <= fa_1.io.cout @[dut.scala 42:18]
    inst fa_2 of FullAdder_50 @[dut.scala 37:20]
    fa_2.clock <= clock
    fa_2.reset <= reset
    node _fa_io_a_T_2 = bits(io.a, 2, 2) @[dut.scala 38:20]
    fa_2.io.a <= _fa_io_a_T_2 @[dut.scala 38:13]
    node _fa_io_b_T_2 = bits(io.b, 2, 2) @[dut.scala 39:20]
    fa_2.io.b <= _fa_io_b_T_2 @[dut.scala 39:13]
    fa_2.io.cin <= carry[2] @[dut.scala 40:15]
    sum[2] <= fa_2.io.sum @[dut.scala 41:12]
    carry[3] <= fa_2.io.cout @[dut.scala 42:18]
    inst fa_3 of FullAdder_51 @[dut.scala 37:20]
    fa_3.clock <= clock
    fa_3.reset <= reset
    node _fa_io_a_T_3 = bits(io.a, 3, 3) @[dut.scala 38:20]
    fa_3.io.a <= _fa_io_a_T_3 @[dut.scala 38:13]
    node _fa_io_b_T_3 = bits(io.b, 3, 3) @[dut.scala 39:20]
    fa_3.io.b <= _fa_io_b_T_3 @[dut.scala 39:13]
    fa_3.io.cin <= carry[3] @[dut.scala 40:15]
    sum[3] <= fa_3.io.sum @[dut.scala 41:12]
    carry[4] <= fa_3.io.cout @[dut.scala 42:18]
    inst fa_4 of FullAdder_52 @[dut.scala 37:20]
    fa_4.clock <= clock
    fa_4.reset <= reset
    node _fa_io_a_T_4 = bits(io.a, 4, 4) @[dut.scala 38:20]
    fa_4.io.a <= _fa_io_a_T_4 @[dut.scala 38:13]
    node _fa_io_b_T_4 = bits(io.b, 4, 4) @[dut.scala 39:20]
    fa_4.io.b <= _fa_io_b_T_4 @[dut.scala 39:13]
    fa_4.io.cin <= carry[4] @[dut.scala 40:15]
    sum[4] <= fa_4.io.sum @[dut.scala 41:12]
    carry[5] <= fa_4.io.cout @[dut.scala 42:18]
    inst fa_5 of FullAdder_53 @[dut.scala 37:20]
    fa_5.clock <= clock
    fa_5.reset <= reset
    node _fa_io_a_T_5 = bits(io.a, 5, 5) @[dut.scala 38:20]
    fa_5.io.a <= _fa_io_a_T_5 @[dut.scala 38:13]
    node _fa_io_b_T_5 = bits(io.b, 5, 5) @[dut.scala 39:20]
    fa_5.io.b <= _fa_io_b_T_5 @[dut.scala 39:13]
    fa_5.io.cin <= carry[5] @[dut.scala 40:15]
    sum[5] <= fa_5.io.sum @[dut.scala 41:12]
    carry[6] <= fa_5.io.cout @[dut.scala 42:18]
    inst fa_6 of FullAdder_54 @[dut.scala 37:20]
    fa_6.clock <= clock
    fa_6.reset <= reset
    node _fa_io_a_T_6 = bits(io.a, 6, 6) @[dut.scala 38:20]
    fa_6.io.a <= _fa_io_a_T_6 @[dut.scala 38:13]
    node _fa_io_b_T_6 = bits(io.b, 6, 6) @[dut.scala 39:20]
    fa_6.io.b <= _fa_io_b_T_6 @[dut.scala 39:13]
    fa_6.io.cin <= carry[6] @[dut.scala 40:15]
    sum[6] <= fa_6.io.sum @[dut.scala 41:12]
    carry[7] <= fa_6.io.cout @[dut.scala 42:18]
    inst fa_7 of FullAdder_55 @[dut.scala 37:20]
    fa_7.clock <= clock
    fa_7.reset <= reset
    node _fa_io_a_T_7 = bits(io.a, 7, 7) @[dut.scala 38:20]
    fa_7.io.a <= _fa_io_a_T_7 @[dut.scala 38:13]
    node _fa_io_b_T_7 = bits(io.b, 7, 7) @[dut.scala 39:20]
    fa_7.io.b <= _fa_io_b_T_7 @[dut.scala 39:13]
    fa_7.io.cin <= carry[7] @[dut.scala 40:15]
    sum[7] <= fa_7.io.sum @[dut.scala 41:12]
    carry[8] <= fa_7.io.cout @[dut.scala 42:18]
    inst fa_8 of FullAdder_56 @[dut.scala 37:20]
    fa_8.clock <= clock
    fa_8.reset <= reset
    node _fa_io_a_T_8 = bits(io.a, 8, 8) @[dut.scala 38:20]
    fa_8.io.a <= _fa_io_a_T_8 @[dut.scala 38:13]
    node _fa_io_b_T_8 = bits(io.b, 8, 8) @[dut.scala 39:20]
    fa_8.io.b <= _fa_io_b_T_8 @[dut.scala 39:13]
    fa_8.io.cin <= carry[8] @[dut.scala 40:15]
    sum[8] <= fa_8.io.sum @[dut.scala 41:12]
    carry[9] <= fa_8.io.cout @[dut.scala 42:18]
    inst fa_9 of FullAdder_57 @[dut.scala 37:20]
    fa_9.clock <= clock
    fa_9.reset <= reset
    node _fa_io_a_T_9 = bits(io.a, 9, 9) @[dut.scala 38:20]
    fa_9.io.a <= _fa_io_a_T_9 @[dut.scala 38:13]
    node _fa_io_b_T_9 = bits(io.b, 9, 9) @[dut.scala 39:20]
    fa_9.io.b <= _fa_io_b_T_9 @[dut.scala 39:13]
    fa_9.io.cin <= carry[9] @[dut.scala 40:15]
    sum[9] <= fa_9.io.sum @[dut.scala 41:12]
    carry[10] <= fa_9.io.cout @[dut.scala 42:18]
    inst fa_10 of FullAdder_58 @[dut.scala 37:20]
    fa_10.clock <= clock
    fa_10.reset <= reset
    node _fa_io_a_T_10 = bits(io.a, 10, 10) @[dut.scala 38:20]
    fa_10.io.a <= _fa_io_a_T_10 @[dut.scala 38:13]
    node _fa_io_b_T_10 = bits(io.b, 10, 10) @[dut.scala 39:20]
    fa_10.io.b <= _fa_io_b_T_10 @[dut.scala 39:13]
    fa_10.io.cin <= carry[10] @[dut.scala 40:15]
    sum[10] <= fa_10.io.sum @[dut.scala 41:12]
    carry[11] <= fa_10.io.cout @[dut.scala 42:18]
    inst fa_11 of FullAdder_59 @[dut.scala 37:20]
    fa_11.clock <= clock
    fa_11.reset <= reset
    node _fa_io_a_T_11 = bits(io.a, 11, 11) @[dut.scala 38:20]
    fa_11.io.a <= _fa_io_a_T_11 @[dut.scala 38:13]
    node _fa_io_b_T_11 = bits(io.b, 11, 11) @[dut.scala 39:20]
    fa_11.io.b <= _fa_io_b_T_11 @[dut.scala 39:13]
    fa_11.io.cin <= carry[11] @[dut.scala 40:15]
    sum[11] <= fa_11.io.sum @[dut.scala 41:12]
    carry[12] <= fa_11.io.cout @[dut.scala 42:18]
    inst fa_12 of FullAdder_60 @[dut.scala 37:20]
    fa_12.clock <= clock
    fa_12.reset <= reset
    node _fa_io_a_T_12 = bits(io.a, 12, 12) @[dut.scala 38:20]
    fa_12.io.a <= _fa_io_a_T_12 @[dut.scala 38:13]
    node _fa_io_b_T_12 = bits(io.b, 12, 12) @[dut.scala 39:20]
    fa_12.io.b <= _fa_io_b_T_12 @[dut.scala 39:13]
    fa_12.io.cin <= carry[12] @[dut.scala 40:15]
    sum[12] <= fa_12.io.sum @[dut.scala 41:12]
    carry[13] <= fa_12.io.cout @[dut.scala 42:18]
    inst fa_13 of FullAdder_61 @[dut.scala 37:20]
    fa_13.clock <= clock
    fa_13.reset <= reset
    node _fa_io_a_T_13 = bits(io.a, 13, 13) @[dut.scala 38:20]
    fa_13.io.a <= _fa_io_a_T_13 @[dut.scala 38:13]
    node _fa_io_b_T_13 = bits(io.b, 13, 13) @[dut.scala 39:20]
    fa_13.io.b <= _fa_io_b_T_13 @[dut.scala 39:13]
    fa_13.io.cin <= carry[13] @[dut.scala 40:15]
    sum[13] <= fa_13.io.sum @[dut.scala 41:12]
    carry[14] <= fa_13.io.cout @[dut.scala 42:18]
    inst fa_14 of FullAdder_62 @[dut.scala 37:20]
    fa_14.clock <= clock
    fa_14.reset <= reset
    node _fa_io_a_T_14 = bits(io.a, 14, 14) @[dut.scala 38:20]
    fa_14.io.a <= _fa_io_a_T_14 @[dut.scala 38:13]
    node _fa_io_b_T_14 = bits(io.b, 14, 14) @[dut.scala 39:20]
    fa_14.io.b <= _fa_io_b_T_14 @[dut.scala 39:13]
    fa_14.io.cin <= carry[14] @[dut.scala 40:15]
    sum[14] <= fa_14.io.sum @[dut.scala 41:12]
    carry[15] <= fa_14.io.cout @[dut.scala 42:18]
    inst fa_15 of FullAdder_63 @[dut.scala 37:20]
    fa_15.clock <= clock
    fa_15.reset <= reset
    node _fa_io_a_T_15 = bits(io.a, 15, 15) @[dut.scala 38:20]
    fa_15.io.a <= _fa_io_a_T_15 @[dut.scala 38:13]
    node _fa_io_b_T_15 = bits(io.b, 15, 15) @[dut.scala 39:20]
    fa_15.io.b <= _fa_io_b_T_15 @[dut.scala 39:13]
    fa_15.io.cin <= carry[15] @[dut.scala 40:15]
    sum[15] <= fa_15.io.sum @[dut.scala 41:12]
    carry[16] <= fa_15.io.cout @[dut.scala 42:18]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 45:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 45:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 45:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 45:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 45:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 45:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 45:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 45:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 45:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 45:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 45:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 45:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 45:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 45:17]
    io.sum <= _io_sum_T @[dut.scala 45:10]
    io.cout <= carry[16] @[dut.scala 46:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg addaReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addaReg <= io.adda @[Reg.scala 36:22]
    reg addbReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addbReg <= io.addb @[Reg.scala 36:22]
    wire _enPipeline_WIRE : UInt<1>[4] @[dut.scala 63:35]
    _enPipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 63:35]
    _enPipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 63:35]
    _enPipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 63:35]
    _enPipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 63:35]
    reg enPipeline : UInt<1>[4], clock with :
      reset => (reset, _enPipeline_WIRE) @[dut.scala 63:27]
    when io.i_en : @[dut.scala 64:17]
      enPipeline[0] <= UInt<1>("h1") @[dut.scala 65:19]
    else :
      enPipeline[0] <= UInt<1>("h0") @[dut.scala 67:19]
    enPipeline[1] <= enPipeline[0] @[dut.scala 70:19]
    enPipeline[2] <= enPipeline[1] @[dut.scala 70:19]
    enPipeline[3] <= enPipeline[2] @[dut.scala 70:19]
    inst stage1 of RCA16 @[dut.scala 74:22]
    stage1.clock <= clock
    stage1.reset <= reset
    node _stage1_io_a_T = bits(addaReg, 15, 0) @[dut.scala 75:25]
    stage1.io.a <= _stage1_io_a_T @[dut.scala 75:15]
    node _stage1_io_b_T = bits(addbReg, 15, 0) @[dut.scala 76:25]
    stage1.io.b <= _stage1_io_b_T @[dut.scala 76:15]
    stage1.io.cin <= UInt<1>("h0") @[dut.scala 77:17]
    reg stage1SumReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[0] : @[Reg.scala 36:18]
      stage1SumReg <= stage1.io.sum @[Reg.scala 36:22]
    reg carry1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[0] : @[Reg.scala 36:18]
      carry1Reg <= stage1.io.cout @[Reg.scala 36:22]
    inst stage2 of RCA16_1 @[dut.scala 82:22]
    stage2.clock <= clock
    stage2.reset <= reset
    node _stage2_io_a_T = bits(addaReg, 31, 16) @[dut.scala 83:25]
    stage2.io.a <= _stage2_io_a_T @[dut.scala 83:15]
    node _stage2_io_b_T = bits(addbReg, 31, 16) @[dut.scala 84:25]
    stage2.io.b <= _stage2_io_b_T @[dut.scala 84:15]
    stage2.io.cin <= carry1Reg @[dut.scala 85:17]
    reg stage2SumReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[1] : @[Reg.scala 36:18]
      stage2SumReg <= stage2.io.sum @[Reg.scala 36:22]
    reg carry2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[1] : @[Reg.scala 36:18]
      carry2Reg <= stage2.io.cout @[Reg.scala 36:22]
    inst stage3 of RCA16_2 @[dut.scala 90:22]
    stage3.clock <= clock
    stage3.reset <= reset
    node _stage3_io_a_T = bits(addaReg, 47, 32) @[dut.scala 91:25]
    stage3.io.a <= _stage3_io_a_T @[dut.scala 91:15]
    node _stage3_io_b_T = bits(addbReg, 47, 32) @[dut.scala 92:25]
    stage3.io.b <= _stage3_io_b_T @[dut.scala 92:15]
    stage3.io.cin <= carry2Reg @[dut.scala 93:17]
    reg stage3SumReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[2] : @[Reg.scala 36:18]
      stage3SumReg <= stage3.io.sum @[Reg.scala 36:22]
    reg carry3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[2] : @[Reg.scala 36:18]
      carry3Reg <= stage3.io.cout @[Reg.scala 36:22]
    inst stage4 of RCA16_3 @[dut.scala 98:22]
    stage4.clock <= clock
    stage4.reset <= reset
    node _stage4_io_a_T = bits(addaReg, 63, 48) @[dut.scala 99:25]
    stage4.io.a <= _stage4_io_a_T @[dut.scala 99:15]
    node _stage4_io_b_T = bits(addbReg, 63, 48) @[dut.scala 100:25]
    stage4.io.b <= _stage4_io_b_T @[dut.scala 100:15]
    stage4.io.cin <= carry3Reg @[dut.scala 101:17]
    reg stage4SumReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[3] : @[Reg.scala 36:18]
      stage4SumReg <= stage4.io.sum @[Reg.scala 36:22]
    reg finalCarryReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when enPipeline[3] : @[Reg.scala 36:18]
      finalCarryReg <= stage4.io.cout @[Reg.scala 36:22]
    node resultReg_lo = cat(stage2SumReg, stage1SumReg) @[Cat.scala 33:92]
    node resultReg_hi_hi = cat(finalCarryReg, stage4SumReg) @[Cat.scala 33:92]
    node resultReg_hi = cat(resultReg_hi_hi, stage3SumReg) @[Cat.scala 33:92]
    node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
    reg resultReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 107:26]
    resultReg <= _resultReg_T @[dut.scala 107:26]
    io.result <= resultReg @[dut.scala 109:13]
    reg io_o_en_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 112:21]
    io_o_en_REG <= enPipeline[3] @[dut.scala 112:21]
    io.o_en <= io_o_en_REG @[dut.scala 112:11]

