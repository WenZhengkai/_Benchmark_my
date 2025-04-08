circuit dut :
  module FullAdder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<1>[16] @[dut.scala 15:52]
    inst FullAdder of FullAdder @[dut.scala 17:29]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:29]
    FullAdder.io.a <= _T @[dut.scala 18:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:29]
    FullAdder.io.b <= _T_1 @[dut.scala 19:22]
    FullAdder.io.cin <= io.cin @[dut.scala 20:24]
    sum[0] <= FullAdder.io.sum @[dut.scala 22:17]
    inst FullAdder_1 of FullAdder_1 @[dut.scala 17:29]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 18:29]
    FullAdder_1.io.a <= _T_2 @[dut.scala 18:22]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 19:29]
    FullAdder_1.io.b <= _T_3 @[dut.scala 19:22]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 20:24]
    sum[1] <= FullAdder_1.io.sum @[dut.scala 22:17]
    inst FullAdder_2 of FullAdder_2 @[dut.scala 17:29]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 18:29]
    FullAdder_2.io.a <= _T_4 @[dut.scala 18:22]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 19:29]
    FullAdder_2.io.b <= _T_5 @[dut.scala 19:22]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 20:24]
    sum[2] <= FullAdder_2.io.sum @[dut.scala 22:17]
    inst FullAdder_3 of FullAdder_3 @[dut.scala 17:29]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 18:29]
    FullAdder_3.io.a <= _T_6 @[dut.scala 18:22]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 19:29]
    FullAdder_3.io.b <= _T_7 @[dut.scala 19:22]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 20:24]
    sum[3] <= FullAdder_3.io.sum @[dut.scala 22:17]
    inst FullAdder_4 of FullAdder_4 @[dut.scala 17:29]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 18:29]
    FullAdder_4.io.a <= _T_8 @[dut.scala 18:22]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 19:29]
    FullAdder_4.io.b <= _T_9 @[dut.scala 19:22]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 20:24]
    sum[4] <= FullAdder_4.io.sum @[dut.scala 22:17]
    inst FullAdder_5 of FullAdder_5 @[dut.scala 17:29]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 18:29]
    FullAdder_5.io.a <= _T_10 @[dut.scala 18:22]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 19:29]
    FullAdder_5.io.b <= _T_11 @[dut.scala 19:22]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 20:24]
    sum[5] <= FullAdder_5.io.sum @[dut.scala 22:17]
    inst FullAdder_6 of FullAdder_6 @[dut.scala 17:29]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 18:29]
    FullAdder_6.io.a <= _T_12 @[dut.scala 18:22]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 19:29]
    FullAdder_6.io.b <= _T_13 @[dut.scala 19:22]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 20:24]
    sum[6] <= FullAdder_6.io.sum @[dut.scala 22:17]
    inst FullAdder_7 of FullAdder_7 @[dut.scala 17:29]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 18:29]
    FullAdder_7.io.a <= _T_14 @[dut.scala 18:22]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 19:29]
    FullAdder_7.io.b <= _T_15 @[dut.scala 19:22]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 20:24]
    sum[7] <= FullAdder_7.io.sum @[dut.scala 22:17]
    inst FullAdder_8 of FullAdder_8 @[dut.scala 17:29]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 18:29]
    FullAdder_8.io.a <= _T_16 @[dut.scala 18:22]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 19:29]
    FullAdder_8.io.b <= _T_17 @[dut.scala 19:22]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 20:24]
    sum[8] <= FullAdder_8.io.sum @[dut.scala 22:17]
    inst FullAdder_9 of FullAdder_9 @[dut.scala 17:29]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 18:29]
    FullAdder_9.io.a <= _T_18 @[dut.scala 18:22]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 19:29]
    FullAdder_9.io.b <= _T_19 @[dut.scala 19:22]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 20:24]
    sum[9] <= FullAdder_9.io.sum @[dut.scala 22:17]
    inst FullAdder_10 of FullAdder_10 @[dut.scala 17:29]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 18:29]
    FullAdder_10.io.a <= _T_20 @[dut.scala 18:22]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 19:29]
    FullAdder_10.io.b <= _T_21 @[dut.scala 19:22]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 20:24]
    sum[10] <= FullAdder_10.io.sum @[dut.scala 22:17]
    inst FullAdder_11 of FullAdder_11 @[dut.scala 17:29]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 18:29]
    FullAdder_11.io.a <= _T_22 @[dut.scala 18:22]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 19:29]
    FullAdder_11.io.b <= _T_23 @[dut.scala 19:22]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 20:24]
    sum[11] <= FullAdder_11.io.sum @[dut.scala 22:17]
    inst FullAdder_12 of FullAdder_12 @[dut.scala 17:29]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 18:29]
    FullAdder_12.io.a <= _T_24 @[dut.scala 18:22]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 19:29]
    FullAdder_12.io.b <= _T_25 @[dut.scala 19:22]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 20:24]
    sum[12] <= FullAdder_12.io.sum @[dut.scala 22:17]
    inst FullAdder_13 of FullAdder_13 @[dut.scala 17:29]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 18:29]
    FullAdder_13.io.a <= _T_26 @[dut.scala 18:22]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 19:29]
    FullAdder_13.io.b <= _T_27 @[dut.scala 19:22]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 20:24]
    sum[13] <= FullAdder_13.io.sum @[dut.scala 22:17]
    inst FullAdder_14 of FullAdder_14 @[dut.scala 17:29]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 18:29]
    FullAdder_14.io.a <= _T_28 @[dut.scala 18:22]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 19:29]
    FullAdder_14.io.b <= _T_29 @[dut.scala 19:22]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 20:24]
    sum[14] <= FullAdder_14.io.sum @[dut.scala 22:17]
    inst FullAdder_15 of FullAdder_15 @[dut.scala 17:29]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 18:29]
    FullAdder_15.io.a <= _T_30 @[dut.scala 18:22]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 19:29]
    FullAdder_15.io.b <= _T_31 @[dut.scala 19:22]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 20:24]
    sum[15] <= FullAdder_15.io.sum @[dut.scala 22:17]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 26:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 26:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 26:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 26:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 26:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 26:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 26:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 26:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 26:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 26:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 26:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 26:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 26:17]
    io.sum <= _io_sum_T @[dut.scala 26:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 27:11]

  module FullAdder_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_20 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_21 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_22 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_23 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_24 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_25 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_26 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_27 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_28 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_29 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_30 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_31 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<1>[16] @[dut.scala 15:52]
    inst FullAdder of FullAdder_16 @[dut.scala 17:29]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:29]
    FullAdder.io.a <= _T @[dut.scala 18:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:29]
    FullAdder.io.b <= _T_1 @[dut.scala 19:22]
    FullAdder.io.cin <= io.cin @[dut.scala 20:24]
    sum[0] <= FullAdder.io.sum @[dut.scala 22:17]
    inst FullAdder_1 of FullAdder_17 @[dut.scala 17:29]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 18:29]
    FullAdder_1.io.a <= _T_2 @[dut.scala 18:22]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 19:29]
    FullAdder_1.io.b <= _T_3 @[dut.scala 19:22]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 20:24]
    sum[1] <= FullAdder_1.io.sum @[dut.scala 22:17]
    inst FullAdder_2 of FullAdder_18 @[dut.scala 17:29]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 18:29]
    FullAdder_2.io.a <= _T_4 @[dut.scala 18:22]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 19:29]
    FullAdder_2.io.b <= _T_5 @[dut.scala 19:22]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 20:24]
    sum[2] <= FullAdder_2.io.sum @[dut.scala 22:17]
    inst FullAdder_3 of FullAdder_19 @[dut.scala 17:29]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 18:29]
    FullAdder_3.io.a <= _T_6 @[dut.scala 18:22]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 19:29]
    FullAdder_3.io.b <= _T_7 @[dut.scala 19:22]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 20:24]
    sum[3] <= FullAdder_3.io.sum @[dut.scala 22:17]
    inst FullAdder_4 of FullAdder_20 @[dut.scala 17:29]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 18:29]
    FullAdder_4.io.a <= _T_8 @[dut.scala 18:22]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 19:29]
    FullAdder_4.io.b <= _T_9 @[dut.scala 19:22]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 20:24]
    sum[4] <= FullAdder_4.io.sum @[dut.scala 22:17]
    inst FullAdder_5 of FullAdder_21 @[dut.scala 17:29]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 18:29]
    FullAdder_5.io.a <= _T_10 @[dut.scala 18:22]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 19:29]
    FullAdder_5.io.b <= _T_11 @[dut.scala 19:22]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 20:24]
    sum[5] <= FullAdder_5.io.sum @[dut.scala 22:17]
    inst FullAdder_6 of FullAdder_22 @[dut.scala 17:29]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 18:29]
    FullAdder_6.io.a <= _T_12 @[dut.scala 18:22]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 19:29]
    FullAdder_6.io.b <= _T_13 @[dut.scala 19:22]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 20:24]
    sum[6] <= FullAdder_6.io.sum @[dut.scala 22:17]
    inst FullAdder_7 of FullAdder_23 @[dut.scala 17:29]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 18:29]
    FullAdder_7.io.a <= _T_14 @[dut.scala 18:22]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 19:29]
    FullAdder_7.io.b <= _T_15 @[dut.scala 19:22]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 20:24]
    sum[7] <= FullAdder_7.io.sum @[dut.scala 22:17]
    inst FullAdder_8 of FullAdder_24 @[dut.scala 17:29]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 18:29]
    FullAdder_8.io.a <= _T_16 @[dut.scala 18:22]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 19:29]
    FullAdder_8.io.b <= _T_17 @[dut.scala 19:22]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 20:24]
    sum[8] <= FullAdder_8.io.sum @[dut.scala 22:17]
    inst FullAdder_9 of FullAdder_25 @[dut.scala 17:29]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 18:29]
    FullAdder_9.io.a <= _T_18 @[dut.scala 18:22]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 19:29]
    FullAdder_9.io.b <= _T_19 @[dut.scala 19:22]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 20:24]
    sum[9] <= FullAdder_9.io.sum @[dut.scala 22:17]
    inst FullAdder_10 of FullAdder_26 @[dut.scala 17:29]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 18:29]
    FullAdder_10.io.a <= _T_20 @[dut.scala 18:22]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 19:29]
    FullAdder_10.io.b <= _T_21 @[dut.scala 19:22]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 20:24]
    sum[10] <= FullAdder_10.io.sum @[dut.scala 22:17]
    inst FullAdder_11 of FullAdder_27 @[dut.scala 17:29]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 18:29]
    FullAdder_11.io.a <= _T_22 @[dut.scala 18:22]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 19:29]
    FullAdder_11.io.b <= _T_23 @[dut.scala 19:22]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 20:24]
    sum[11] <= FullAdder_11.io.sum @[dut.scala 22:17]
    inst FullAdder_12 of FullAdder_28 @[dut.scala 17:29]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 18:29]
    FullAdder_12.io.a <= _T_24 @[dut.scala 18:22]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 19:29]
    FullAdder_12.io.b <= _T_25 @[dut.scala 19:22]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 20:24]
    sum[12] <= FullAdder_12.io.sum @[dut.scala 22:17]
    inst FullAdder_13 of FullAdder_29 @[dut.scala 17:29]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 18:29]
    FullAdder_13.io.a <= _T_26 @[dut.scala 18:22]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 19:29]
    FullAdder_13.io.b <= _T_27 @[dut.scala 19:22]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 20:24]
    sum[13] <= FullAdder_13.io.sum @[dut.scala 22:17]
    inst FullAdder_14 of FullAdder_30 @[dut.scala 17:29]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 18:29]
    FullAdder_14.io.a <= _T_28 @[dut.scala 18:22]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 19:29]
    FullAdder_14.io.b <= _T_29 @[dut.scala 19:22]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 20:24]
    sum[14] <= FullAdder_14.io.sum @[dut.scala 22:17]
    inst FullAdder_15 of FullAdder_31 @[dut.scala 17:29]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 18:29]
    FullAdder_15.io.a <= _T_30 @[dut.scala 18:22]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 19:29]
    FullAdder_15.io.b <= _T_31 @[dut.scala 19:22]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 20:24]
    sum[15] <= FullAdder_15.io.sum @[dut.scala 22:17]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 26:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 26:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 26:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 26:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 26:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 26:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 26:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 26:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 26:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 26:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 26:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 26:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 26:17]
    io.sum <= _io_sum_T @[dut.scala 26:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 27:11]

  module FullAdder_32 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_33 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_34 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_35 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_36 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_37 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_38 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_39 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_40 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_41 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_42 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_43 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_44 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_45 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_46 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_47 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<1>[16] @[dut.scala 15:52]
    inst FullAdder of FullAdder_32 @[dut.scala 17:29]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:29]
    FullAdder.io.a <= _T @[dut.scala 18:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:29]
    FullAdder.io.b <= _T_1 @[dut.scala 19:22]
    FullAdder.io.cin <= io.cin @[dut.scala 20:24]
    sum[0] <= FullAdder.io.sum @[dut.scala 22:17]
    inst FullAdder_1 of FullAdder_33 @[dut.scala 17:29]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 18:29]
    FullAdder_1.io.a <= _T_2 @[dut.scala 18:22]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 19:29]
    FullAdder_1.io.b <= _T_3 @[dut.scala 19:22]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 20:24]
    sum[1] <= FullAdder_1.io.sum @[dut.scala 22:17]
    inst FullAdder_2 of FullAdder_34 @[dut.scala 17:29]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 18:29]
    FullAdder_2.io.a <= _T_4 @[dut.scala 18:22]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 19:29]
    FullAdder_2.io.b <= _T_5 @[dut.scala 19:22]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 20:24]
    sum[2] <= FullAdder_2.io.sum @[dut.scala 22:17]
    inst FullAdder_3 of FullAdder_35 @[dut.scala 17:29]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 18:29]
    FullAdder_3.io.a <= _T_6 @[dut.scala 18:22]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 19:29]
    FullAdder_3.io.b <= _T_7 @[dut.scala 19:22]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 20:24]
    sum[3] <= FullAdder_3.io.sum @[dut.scala 22:17]
    inst FullAdder_4 of FullAdder_36 @[dut.scala 17:29]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 18:29]
    FullAdder_4.io.a <= _T_8 @[dut.scala 18:22]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 19:29]
    FullAdder_4.io.b <= _T_9 @[dut.scala 19:22]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 20:24]
    sum[4] <= FullAdder_4.io.sum @[dut.scala 22:17]
    inst FullAdder_5 of FullAdder_37 @[dut.scala 17:29]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 18:29]
    FullAdder_5.io.a <= _T_10 @[dut.scala 18:22]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 19:29]
    FullAdder_5.io.b <= _T_11 @[dut.scala 19:22]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 20:24]
    sum[5] <= FullAdder_5.io.sum @[dut.scala 22:17]
    inst FullAdder_6 of FullAdder_38 @[dut.scala 17:29]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 18:29]
    FullAdder_6.io.a <= _T_12 @[dut.scala 18:22]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 19:29]
    FullAdder_6.io.b <= _T_13 @[dut.scala 19:22]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 20:24]
    sum[6] <= FullAdder_6.io.sum @[dut.scala 22:17]
    inst FullAdder_7 of FullAdder_39 @[dut.scala 17:29]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 18:29]
    FullAdder_7.io.a <= _T_14 @[dut.scala 18:22]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 19:29]
    FullAdder_7.io.b <= _T_15 @[dut.scala 19:22]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 20:24]
    sum[7] <= FullAdder_7.io.sum @[dut.scala 22:17]
    inst FullAdder_8 of FullAdder_40 @[dut.scala 17:29]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 18:29]
    FullAdder_8.io.a <= _T_16 @[dut.scala 18:22]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 19:29]
    FullAdder_8.io.b <= _T_17 @[dut.scala 19:22]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 20:24]
    sum[8] <= FullAdder_8.io.sum @[dut.scala 22:17]
    inst FullAdder_9 of FullAdder_41 @[dut.scala 17:29]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 18:29]
    FullAdder_9.io.a <= _T_18 @[dut.scala 18:22]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 19:29]
    FullAdder_9.io.b <= _T_19 @[dut.scala 19:22]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 20:24]
    sum[9] <= FullAdder_9.io.sum @[dut.scala 22:17]
    inst FullAdder_10 of FullAdder_42 @[dut.scala 17:29]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 18:29]
    FullAdder_10.io.a <= _T_20 @[dut.scala 18:22]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 19:29]
    FullAdder_10.io.b <= _T_21 @[dut.scala 19:22]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 20:24]
    sum[10] <= FullAdder_10.io.sum @[dut.scala 22:17]
    inst FullAdder_11 of FullAdder_43 @[dut.scala 17:29]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 18:29]
    FullAdder_11.io.a <= _T_22 @[dut.scala 18:22]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 19:29]
    FullAdder_11.io.b <= _T_23 @[dut.scala 19:22]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 20:24]
    sum[11] <= FullAdder_11.io.sum @[dut.scala 22:17]
    inst FullAdder_12 of FullAdder_44 @[dut.scala 17:29]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 18:29]
    FullAdder_12.io.a <= _T_24 @[dut.scala 18:22]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 19:29]
    FullAdder_12.io.b <= _T_25 @[dut.scala 19:22]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 20:24]
    sum[12] <= FullAdder_12.io.sum @[dut.scala 22:17]
    inst FullAdder_13 of FullAdder_45 @[dut.scala 17:29]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 18:29]
    FullAdder_13.io.a <= _T_26 @[dut.scala 18:22]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 19:29]
    FullAdder_13.io.b <= _T_27 @[dut.scala 19:22]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 20:24]
    sum[13] <= FullAdder_13.io.sum @[dut.scala 22:17]
    inst FullAdder_14 of FullAdder_46 @[dut.scala 17:29]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 18:29]
    FullAdder_14.io.a <= _T_28 @[dut.scala 18:22]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 19:29]
    FullAdder_14.io.b <= _T_29 @[dut.scala 19:22]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 20:24]
    sum[14] <= FullAdder_14.io.sum @[dut.scala 22:17]
    inst FullAdder_15 of FullAdder_47 @[dut.scala 17:29]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 18:29]
    FullAdder_15.io.a <= _T_30 @[dut.scala 18:22]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 19:29]
    FullAdder_15.io.b <= _T_31 @[dut.scala 19:22]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 20:24]
    sum[15] <= FullAdder_15.io.sum @[dut.scala 22:17]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 26:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 26:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 26:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 26:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 26:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 26:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 26:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 26:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 26:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 26:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 26:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 26:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 26:17]
    io.sum <= _io_sum_T @[dut.scala 26:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 27:11]

  module FullAdder_48 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_49 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_50 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_51 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_52 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_53 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_54 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_55 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_56 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_57 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_58 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_59 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_60 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_61 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_62 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module FullAdder_63 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 39:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 39:25]
    io.sum <= _io_sum_T_1 @[dut.scala 39:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 40:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 40:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 40:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 40:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 40:46]
    io.cout <= _io_cout_T_4 @[dut.scala 40:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<1>[16] @[dut.scala 15:52]
    inst FullAdder of FullAdder_48 @[dut.scala 17:29]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:29]
    FullAdder.io.a <= _T @[dut.scala 18:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:29]
    FullAdder.io.b <= _T_1 @[dut.scala 19:22]
    FullAdder.io.cin <= io.cin @[dut.scala 20:24]
    sum[0] <= FullAdder.io.sum @[dut.scala 22:17]
    inst FullAdder_1 of FullAdder_49 @[dut.scala 17:29]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 18:29]
    FullAdder_1.io.a <= _T_2 @[dut.scala 18:22]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 19:29]
    FullAdder_1.io.b <= _T_3 @[dut.scala 19:22]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 20:24]
    sum[1] <= FullAdder_1.io.sum @[dut.scala 22:17]
    inst FullAdder_2 of FullAdder_50 @[dut.scala 17:29]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 18:29]
    FullAdder_2.io.a <= _T_4 @[dut.scala 18:22]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 19:29]
    FullAdder_2.io.b <= _T_5 @[dut.scala 19:22]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 20:24]
    sum[2] <= FullAdder_2.io.sum @[dut.scala 22:17]
    inst FullAdder_3 of FullAdder_51 @[dut.scala 17:29]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 18:29]
    FullAdder_3.io.a <= _T_6 @[dut.scala 18:22]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 19:29]
    FullAdder_3.io.b <= _T_7 @[dut.scala 19:22]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 20:24]
    sum[3] <= FullAdder_3.io.sum @[dut.scala 22:17]
    inst FullAdder_4 of FullAdder_52 @[dut.scala 17:29]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 18:29]
    FullAdder_4.io.a <= _T_8 @[dut.scala 18:22]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 19:29]
    FullAdder_4.io.b <= _T_9 @[dut.scala 19:22]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 20:24]
    sum[4] <= FullAdder_4.io.sum @[dut.scala 22:17]
    inst FullAdder_5 of FullAdder_53 @[dut.scala 17:29]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 18:29]
    FullAdder_5.io.a <= _T_10 @[dut.scala 18:22]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 19:29]
    FullAdder_5.io.b <= _T_11 @[dut.scala 19:22]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 20:24]
    sum[5] <= FullAdder_5.io.sum @[dut.scala 22:17]
    inst FullAdder_6 of FullAdder_54 @[dut.scala 17:29]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 18:29]
    FullAdder_6.io.a <= _T_12 @[dut.scala 18:22]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 19:29]
    FullAdder_6.io.b <= _T_13 @[dut.scala 19:22]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 20:24]
    sum[6] <= FullAdder_6.io.sum @[dut.scala 22:17]
    inst FullAdder_7 of FullAdder_55 @[dut.scala 17:29]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 18:29]
    FullAdder_7.io.a <= _T_14 @[dut.scala 18:22]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 19:29]
    FullAdder_7.io.b <= _T_15 @[dut.scala 19:22]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 20:24]
    sum[7] <= FullAdder_7.io.sum @[dut.scala 22:17]
    inst FullAdder_8 of FullAdder_56 @[dut.scala 17:29]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 18:29]
    FullAdder_8.io.a <= _T_16 @[dut.scala 18:22]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 19:29]
    FullAdder_8.io.b <= _T_17 @[dut.scala 19:22]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 20:24]
    sum[8] <= FullAdder_8.io.sum @[dut.scala 22:17]
    inst FullAdder_9 of FullAdder_57 @[dut.scala 17:29]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 18:29]
    FullAdder_9.io.a <= _T_18 @[dut.scala 18:22]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 19:29]
    FullAdder_9.io.b <= _T_19 @[dut.scala 19:22]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 20:24]
    sum[9] <= FullAdder_9.io.sum @[dut.scala 22:17]
    inst FullAdder_10 of FullAdder_58 @[dut.scala 17:29]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 18:29]
    FullAdder_10.io.a <= _T_20 @[dut.scala 18:22]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 19:29]
    FullAdder_10.io.b <= _T_21 @[dut.scala 19:22]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 20:24]
    sum[10] <= FullAdder_10.io.sum @[dut.scala 22:17]
    inst FullAdder_11 of FullAdder_59 @[dut.scala 17:29]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 18:29]
    FullAdder_11.io.a <= _T_22 @[dut.scala 18:22]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 19:29]
    FullAdder_11.io.b <= _T_23 @[dut.scala 19:22]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 20:24]
    sum[11] <= FullAdder_11.io.sum @[dut.scala 22:17]
    inst FullAdder_12 of FullAdder_60 @[dut.scala 17:29]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 18:29]
    FullAdder_12.io.a <= _T_24 @[dut.scala 18:22]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 19:29]
    FullAdder_12.io.b <= _T_25 @[dut.scala 19:22]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 20:24]
    sum[12] <= FullAdder_12.io.sum @[dut.scala 22:17]
    inst FullAdder_13 of FullAdder_61 @[dut.scala 17:29]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 18:29]
    FullAdder_13.io.a <= _T_26 @[dut.scala 18:22]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 19:29]
    FullAdder_13.io.b <= _T_27 @[dut.scala 19:22]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 20:24]
    sum[13] <= FullAdder_13.io.sum @[dut.scala 22:17]
    inst FullAdder_14 of FullAdder_62 @[dut.scala 17:29]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 18:29]
    FullAdder_14.io.a <= _T_28 @[dut.scala 18:22]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 19:29]
    FullAdder_14.io.b <= _T_29 @[dut.scala 19:22]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 20:24]
    sum[14] <= FullAdder_14.io.sum @[dut.scala 22:17]
    inst FullAdder_15 of FullAdder_63 @[dut.scala 17:29]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 18:29]
    FullAdder_15.io.a <= _T_30 @[dut.scala 18:22]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 19:29]
    FullAdder_15.io.b <= _T_31 @[dut.scala 19:22]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 20:24]
    sum[15] <= FullAdder_15.io.sum @[dut.scala 22:17]
    node io_sum_lo_lo_lo = cat(sum[1], sum[0]) @[dut.scala 26:17]
    node io_sum_lo_lo_hi = cat(sum[3], sum[2]) @[dut.scala 26:17]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 26:17]
    node io_sum_lo_hi_lo = cat(sum[5], sum[4]) @[dut.scala 26:17]
    node io_sum_lo_hi_hi = cat(sum[7], sum[6]) @[dut.scala 26:17]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 26:17]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_lo_lo = cat(sum[9], sum[8]) @[dut.scala 26:17]
    node io_sum_hi_lo_hi = cat(sum[11], sum[10]) @[dut.scala 26:17]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 26:17]
    node io_sum_hi_hi_lo = cat(sum[13], sum[12]) @[dut.scala 26:17]
    node io_sum_hi_hi_hi = cat(sum[15], sum[14]) @[dut.scala 26:17]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 26:17]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 26:17]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 26:17]
    io.sum <= _io_sum_T @[dut.scala 26:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 27:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg addaReg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addaReg <= io.adda @[Reg.scala 36:22]
    reg addbReg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addbReg <= io.addb @[Reg.scala 36:22]
    wire _enPipeline_WIRE : UInt<1>[4] @[dut.scala 56:35]
    _enPipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 56:35]
    _enPipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 56:35]
    _enPipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 56:35]
    _enPipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 56:35]
    reg enPipeline : UInt<1>[4], clock with :
      reset => (reset, _enPipeline_WIRE) @[dut.scala 56:27]
    enPipeline[0] <= io.i_en @[dut.scala 58:17]
    enPipeline[1] <= enPipeline[0] @[dut.scala 60:19]
    enPipeline[2] <= enPipeline[1] @[dut.scala 60:19]
    enPipeline[3] <= enPipeline[2] @[dut.scala 60:19]
    inst rca1 of RCA16 @[dut.scala 64:20]
    rca1.clock <= clock
    rca1.reset <= reset
    node _rca1_io_a_T = bits(addaReg, 15, 0) @[dut.scala 65:23]
    rca1.io.a <= _rca1_io_a_T @[dut.scala 65:13]
    node _rca1_io_b_T = bits(addbReg, 15, 0) @[dut.scala 66:23]
    rca1.io.b <= _rca1_io_b_T @[dut.scala 66:13]
    rca1.io.cin <= UInt<1>("h0") @[dut.scala 67:15]
    reg stage1Sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage1Sum) @[dut.scala 68:26]
    stage1Sum <= rca1.io.sum @[dut.scala 68:26]
    reg stage1Cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage1Cout) @[dut.scala 69:27]
    stage1Cout <= rca1.io.cout @[dut.scala 69:27]
    inst rca2 of RCA16_1 @[dut.scala 71:20]
    rca2.clock <= clock
    rca2.reset <= reset
    node _rca2_io_a_T = bits(addaReg, 31, 16) @[dut.scala 72:23]
    rca2.io.a <= _rca2_io_a_T @[dut.scala 72:13]
    node _rca2_io_b_T = bits(addbReg, 31, 16) @[dut.scala 73:23]
    rca2.io.b <= _rca2_io_b_T @[dut.scala 73:13]
    rca2.io.cin <= stage1Cout @[dut.scala 74:15]
    reg stage2Sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage2Sum) @[dut.scala 75:26]
    stage2Sum <= rca2.io.sum @[dut.scala 75:26]
    reg stage2Cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage2Cout) @[dut.scala 76:27]
    stage2Cout <= rca2.io.cout @[dut.scala 76:27]
    inst rca3 of RCA16_2 @[dut.scala 78:20]
    rca3.clock <= clock
    rca3.reset <= reset
    node _rca3_io_a_T = bits(addaReg, 47, 32) @[dut.scala 79:23]
    rca3.io.a <= _rca3_io_a_T @[dut.scala 79:13]
    node _rca3_io_b_T = bits(addbReg, 47, 32) @[dut.scala 80:23]
    rca3.io.b <= _rca3_io_b_T @[dut.scala 80:13]
    rca3.io.cin <= stage2Cout @[dut.scala 81:15]
    reg stage3Sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage3Sum) @[dut.scala 82:26]
    stage3Sum <= rca3.io.sum @[dut.scala 82:26]
    reg stage3Cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage3Cout) @[dut.scala 83:27]
    stage3Cout <= rca3.io.cout @[dut.scala 83:27]
    inst rca4 of RCA16_3 @[dut.scala 85:20]
    rca4.clock <= clock
    rca4.reset <= reset
    node _rca4_io_a_T = bits(addaReg, 63, 48) @[dut.scala 86:23]
    rca4.io.a <= _rca4_io_a_T @[dut.scala 86:13]
    node _rca4_io_b_T = bits(addbReg, 63, 48) @[dut.scala 87:23]
    rca4.io.b <= _rca4_io_b_T @[dut.scala 87:13]
    rca4.io.cin <= stage3Cout @[dut.scala 88:15]
    reg stage4Sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage4Sum) @[dut.scala 89:26]
    stage4Sum <= rca4.io.sum @[dut.scala 89:26]
    reg stage4Cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage4Cout) @[dut.scala 90:27]
    stage4Cout <= rca4.io.cout @[dut.scala 90:27]
    node resultReg_lo = cat(stage2Sum, stage1Sum) @[Cat.scala 33:92]
    node resultReg_hi_hi = cat(stage4Cout, stage4Sum) @[Cat.scala 33:92]
    node resultReg_hi = cat(resultReg_hi_hi, stage3Sum) @[Cat.scala 33:92]
    node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
    reg resultReg : UInt, clock with :
      reset => (UInt<1>("h0"), resultReg) @[dut.scala 93:26]
    resultReg <= _resultReg_T @[dut.scala 93:26]
    io.result <= resultReg @[dut.scala 94:13]
    io.o_en <= enPipeline[3] @[dut.scala 97:11]

