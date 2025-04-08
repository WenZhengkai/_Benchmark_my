circuit dut :
  module FullAdder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder @[dut.scala 14:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_1 @[dut.scala 14:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_2 @[dut.scala 14:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_3 @[dut.scala 14:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_4 @[dut.scala 14:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_5 @[dut.scala 14:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_6 @[dut.scala 14:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_7 @[dut.scala 14:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_8 @[dut.scala 14:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_9 @[dut.scala 14:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_10 @[dut.scala 14:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_11 @[dut.scala 14:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_12 @[dut.scala 14:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_13 @[dut.scala 14:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_14 @[dut.scala 14:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_15 @[dut.scala 14:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:30]
    FullAdder.io.a <= _T @[dut.scala 18:23]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:30]
    FullAdder.io.b <= _T_1 @[dut.scala 19:23]
    FullAdder.io.cin <= io.cin @[dut.scala 20:25]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 22:30]
    FullAdder_1.io.a <= _T_2 @[dut.scala 22:23]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 23:30]
    FullAdder_1.io.b <= _T_3 @[dut.scala 23:23]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 24:25]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 22:30]
    FullAdder_2.io.a <= _T_4 @[dut.scala 22:23]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 23:30]
    FullAdder_2.io.b <= _T_5 @[dut.scala 23:23]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 24:25]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 22:30]
    FullAdder_3.io.a <= _T_6 @[dut.scala 22:23]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 23:30]
    FullAdder_3.io.b <= _T_7 @[dut.scala 23:23]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 24:25]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 22:30]
    FullAdder_4.io.a <= _T_8 @[dut.scala 22:23]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 23:30]
    FullAdder_4.io.b <= _T_9 @[dut.scala 23:23]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 24:25]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 22:30]
    FullAdder_5.io.a <= _T_10 @[dut.scala 22:23]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 23:30]
    FullAdder_5.io.b <= _T_11 @[dut.scala 23:23]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 24:25]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 22:30]
    FullAdder_6.io.a <= _T_12 @[dut.scala 22:23]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 23:30]
    FullAdder_6.io.b <= _T_13 @[dut.scala 23:23]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 24:25]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 22:30]
    FullAdder_7.io.a <= _T_14 @[dut.scala 22:23]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 23:30]
    FullAdder_7.io.b <= _T_15 @[dut.scala 23:23]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 24:25]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 22:30]
    FullAdder_8.io.a <= _T_16 @[dut.scala 22:23]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 23:30]
    FullAdder_8.io.b <= _T_17 @[dut.scala 23:23]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 24:25]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 22:30]
    FullAdder_9.io.a <= _T_18 @[dut.scala 22:23]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 23:30]
    FullAdder_9.io.b <= _T_19 @[dut.scala 23:23]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 24:25]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 22:30]
    FullAdder_10.io.a <= _T_20 @[dut.scala 22:23]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 23:30]
    FullAdder_10.io.b <= _T_21 @[dut.scala 23:23]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 24:25]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 22:30]
    FullAdder_11.io.a <= _T_22 @[dut.scala 22:23]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 23:30]
    FullAdder_11.io.b <= _T_23 @[dut.scala 23:23]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 24:25]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 22:30]
    FullAdder_12.io.a <= _T_24 @[dut.scala 22:23]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 23:30]
    FullAdder_12.io.b <= _T_25 @[dut.scala 23:23]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 24:25]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 22:30]
    FullAdder_13.io.a <= _T_26 @[dut.scala 22:23]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 23:30]
    FullAdder_13.io.b <= _T_27 @[dut.scala 23:23]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 24:25]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 22:30]
    FullAdder_14.io.a <= _T_28 @[dut.scala 22:23]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 23:30]
    FullAdder_14.io.b <= _T_29 @[dut.scala 23:23]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 24:25]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 22:30]
    FullAdder_15.io.a <= _T_30 @[dut.scala 22:23]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 23:30]
    FullAdder_15.io.b <= _T_31 @[dut.scala 23:23]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 24:25]
    node io_sum_lo_lo_lo = cat(FullAdder_1.io.sum, FullAdder.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo_hi = cat(FullAdder_3.io.sum, FullAdder_2.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[Cat.scala 33:92]
    node io_sum_lo_hi_lo = cat(FullAdder_5.io.sum, FullAdder_4.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi_hi = cat(FullAdder_7.io.sum, FullAdder_6.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[Cat.scala 33:92]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_lo_lo = cat(FullAdder_9.io.sum, FullAdder_8.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo_hi = cat(FullAdder_11.io.sum, FullAdder_10.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_hi_lo = cat(FullAdder_13.io.sum, FullAdder_12.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi_hi = cat(FullAdder_15.io.sum, FullAdder_14.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[Cat.scala 33:92]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[Cat.scala 33:92]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[Cat.scala 33:92]
    io.sum <= _io_sum_T @[dut.scala 28:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 29:11]

  module FullAdder_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_20 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_21 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_22 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_23 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_24 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_25 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_26 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_27 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_28 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_29 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_30 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_31 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_16 @[dut.scala 14:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_17 @[dut.scala 14:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_18 @[dut.scala 14:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_19 @[dut.scala 14:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_20 @[dut.scala 14:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_21 @[dut.scala 14:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_22 @[dut.scala 14:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_23 @[dut.scala 14:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_24 @[dut.scala 14:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_25 @[dut.scala 14:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_26 @[dut.scala 14:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_27 @[dut.scala 14:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_28 @[dut.scala 14:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_29 @[dut.scala 14:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_30 @[dut.scala 14:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_31 @[dut.scala 14:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:30]
    FullAdder.io.a <= _T @[dut.scala 18:23]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:30]
    FullAdder.io.b <= _T_1 @[dut.scala 19:23]
    FullAdder.io.cin <= io.cin @[dut.scala 20:25]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 22:30]
    FullAdder_1.io.a <= _T_2 @[dut.scala 22:23]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 23:30]
    FullAdder_1.io.b <= _T_3 @[dut.scala 23:23]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 24:25]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 22:30]
    FullAdder_2.io.a <= _T_4 @[dut.scala 22:23]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 23:30]
    FullAdder_2.io.b <= _T_5 @[dut.scala 23:23]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 24:25]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 22:30]
    FullAdder_3.io.a <= _T_6 @[dut.scala 22:23]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 23:30]
    FullAdder_3.io.b <= _T_7 @[dut.scala 23:23]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 24:25]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 22:30]
    FullAdder_4.io.a <= _T_8 @[dut.scala 22:23]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 23:30]
    FullAdder_4.io.b <= _T_9 @[dut.scala 23:23]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 24:25]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 22:30]
    FullAdder_5.io.a <= _T_10 @[dut.scala 22:23]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 23:30]
    FullAdder_5.io.b <= _T_11 @[dut.scala 23:23]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 24:25]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 22:30]
    FullAdder_6.io.a <= _T_12 @[dut.scala 22:23]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 23:30]
    FullAdder_6.io.b <= _T_13 @[dut.scala 23:23]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 24:25]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 22:30]
    FullAdder_7.io.a <= _T_14 @[dut.scala 22:23]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 23:30]
    FullAdder_7.io.b <= _T_15 @[dut.scala 23:23]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 24:25]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 22:30]
    FullAdder_8.io.a <= _T_16 @[dut.scala 22:23]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 23:30]
    FullAdder_8.io.b <= _T_17 @[dut.scala 23:23]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 24:25]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 22:30]
    FullAdder_9.io.a <= _T_18 @[dut.scala 22:23]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 23:30]
    FullAdder_9.io.b <= _T_19 @[dut.scala 23:23]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 24:25]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 22:30]
    FullAdder_10.io.a <= _T_20 @[dut.scala 22:23]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 23:30]
    FullAdder_10.io.b <= _T_21 @[dut.scala 23:23]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 24:25]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 22:30]
    FullAdder_11.io.a <= _T_22 @[dut.scala 22:23]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 23:30]
    FullAdder_11.io.b <= _T_23 @[dut.scala 23:23]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 24:25]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 22:30]
    FullAdder_12.io.a <= _T_24 @[dut.scala 22:23]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 23:30]
    FullAdder_12.io.b <= _T_25 @[dut.scala 23:23]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 24:25]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 22:30]
    FullAdder_13.io.a <= _T_26 @[dut.scala 22:23]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 23:30]
    FullAdder_13.io.b <= _T_27 @[dut.scala 23:23]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 24:25]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 22:30]
    FullAdder_14.io.a <= _T_28 @[dut.scala 22:23]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 23:30]
    FullAdder_14.io.b <= _T_29 @[dut.scala 23:23]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 24:25]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 22:30]
    FullAdder_15.io.a <= _T_30 @[dut.scala 22:23]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 23:30]
    FullAdder_15.io.b <= _T_31 @[dut.scala 23:23]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 24:25]
    node io_sum_lo_lo_lo = cat(FullAdder_1.io.sum, FullAdder.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo_hi = cat(FullAdder_3.io.sum, FullAdder_2.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[Cat.scala 33:92]
    node io_sum_lo_hi_lo = cat(FullAdder_5.io.sum, FullAdder_4.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi_hi = cat(FullAdder_7.io.sum, FullAdder_6.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[Cat.scala 33:92]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_lo_lo = cat(FullAdder_9.io.sum, FullAdder_8.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo_hi = cat(FullAdder_11.io.sum, FullAdder_10.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_hi_lo = cat(FullAdder_13.io.sum, FullAdder_12.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi_hi = cat(FullAdder_15.io.sum, FullAdder_14.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[Cat.scala 33:92]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[Cat.scala 33:92]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[Cat.scala 33:92]
    io.sum <= _io_sum_T @[dut.scala 28:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 29:11]

  module FullAdder_32 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_33 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_34 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_35 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_36 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_37 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_38 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_39 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_40 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_41 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_42 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_43 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_44 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_45 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_46 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_47 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_32 @[dut.scala 14:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_33 @[dut.scala 14:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_34 @[dut.scala 14:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_35 @[dut.scala 14:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_36 @[dut.scala 14:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_37 @[dut.scala 14:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_38 @[dut.scala 14:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_39 @[dut.scala 14:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_40 @[dut.scala 14:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_41 @[dut.scala 14:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_42 @[dut.scala 14:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_43 @[dut.scala 14:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_44 @[dut.scala 14:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_45 @[dut.scala 14:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_46 @[dut.scala 14:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_47 @[dut.scala 14:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:30]
    FullAdder.io.a <= _T @[dut.scala 18:23]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:30]
    FullAdder.io.b <= _T_1 @[dut.scala 19:23]
    FullAdder.io.cin <= io.cin @[dut.scala 20:25]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 22:30]
    FullAdder_1.io.a <= _T_2 @[dut.scala 22:23]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 23:30]
    FullAdder_1.io.b <= _T_3 @[dut.scala 23:23]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 24:25]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 22:30]
    FullAdder_2.io.a <= _T_4 @[dut.scala 22:23]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 23:30]
    FullAdder_2.io.b <= _T_5 @[dut.scala 23:23]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 24:25]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 22:30]
    FullAdder_3.io.a <= _T_6 @[dut.scala 22:23]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 23:30]
    FullAdder_3.io.b <= _T_7 @[dut.scala 23:23]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 24:25]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 22:30]
    FullAdder_4.io.a <= _T_8 @[dut.scala 22:23]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 23:30]
    FullAdder_4.io.b <= _T_9 @[dut.scala 23:23]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 24:25]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 22:30]
    FullAdder_5.io.a <= _T_10 @[dut.scala 22:23]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 23:30]
    FullAdder_5.io.b <= _T_11 @[dut.scala 23:23]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 24:25]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 22:30]
    FullAdder_6.io.a <= _T_12 @[dut.scala 22:23]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 23:30]
    FullAdder_6.io.b <= _T_13 @[dut.scala 23:23]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 24:25]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 22:30]
    FullAdder_7.io.a <= _T_14 @[dut.scala 22:23]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 23:30]
    FullAdder_7.io.b <= _T_15 @[dut.scala 23:23]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 24:25]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 22:30]
    FullAdder_8.io.a <= _T_16 @[dut.scala 22:23]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 23:30]
    FullAdder_8.io.b <= _T_17 @[dut.scala 23:23]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 24:25]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 22:30]
    FullAdder_9.io.a <= _T_18 @[dut.scala 22:23]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 23:30]
    FullAdder_9.io.b <= _T_19 @[dut.scala 23:23]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 24:25]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 22:30]
    FullAdder_10.io.a <= _T_20 @[dut.scala 22:23]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 23:30]
    FullAdder_10.io.b <= _T_21 @[dut.scala 23:23]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 24:25]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 22:30]
    FullAdder_11.io.a <= _T_22 @[dut.scala 22:23]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 23:30]
    FullAdder_11.io.b <= _T_23 @[dut.scala 23:23]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 24:25]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 22:30]
    FullAdder_12.io.a <= _T_24 @[dut.scala 22:23]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 23:30]
    FullAdder_12.io.b <= _T_25 @[dut.scala 23:23]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 24:25]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 22:30]
    FullAdder_13.io.a <= _T_26 @[dut.scala 22:23]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 23:30]
    FullAdder_13.io.b <= _T_27 @[dut.scala 23:23]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 24:25]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 22:30]
    FullAdder_14.io.a <= _T_28 @[dut.scala 22:23]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 23:30]
    FullAdder_14.io.b <= _T_29 @[dut.scala 23:23]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 24:25]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 22:30]
    FullAdder_15.io.a <= _T_30 @[dut.scala 22:23]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 23:30]
    FullAdder_15.io.b <= _T_31 @[dut.scala 23:23]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 24:25]
    node io_sum_lo_lo_lo = cat(FullAdder_1.io.sum, FullAdder.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo_hi = cat(FullAdder_3.io.sum, FullAdder_2.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[Cat.scala 33:92]
    node io_sum_lo_hi_lo = cat(FullAdder_5.io.sum, FullAdder_4.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi_hi = cat(FullAdder_7.io.sum, FullAdder_6.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[Cat.scala 33:92]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_lo_lo = cat(FullAdder_9.io.sum, FullAdder_8.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo_hi = cat(FullAdder_11.io.sum, FullAdder_10.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_hi_lo = cat(FullAdder_13.io.sum, FullAdder_12.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi_hi = cat(FullAdder_15.io.sum, FullAdder_14.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[Cat.scala 33:92]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[Cat.scala 33:92]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[Cat.scala 33:92]
    io.sum <= _io_sum_T @[dut.scala 28:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 29:11]

  module FullAdder_48 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_49 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_50 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_51 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_52 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_53 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_54 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_55 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_56 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_57 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_58 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_59 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_60 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_61 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_62 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module FullAdder_63 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 41:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 41:25]
    io.sum <= _io_sum_T_1 @[dut.scala 41:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 42:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 42:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 42:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 42:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 42:46]
    io.cout <= _io_cout_T_4 @[dut.scala 42:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_48 @[dut.scala 14:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_49 @[dut.scala 14:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_50 @[dut.scala 14:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_51 @[dut.scala 14:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_52 @[dut.scala 14:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_53 @[dut.scala 14:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_54 @[dut.scala 14:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_55 @[dut.scala 14:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_56 @[dut.scala 14:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_57 @[dut.scala 14:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_58 @[dut.scala 14:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_59 @[dut.scala 14:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_60 @[dut.scala 14:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_61 @[dut.scala 14:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_62 @[dut.scala 14:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_63 @[dut.scala 14:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 18:30]
    FullAdder.io.a <= _T @[dut.scala 18:23]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 19:30]
    FullAdder.io.b <= _T_1 @[dut.scala 19:23]
    FullAdder.io.cin <= io.cin @[dut.scala 20:25]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 22:30]
    FullAdder_1.io.a <= _T_2 @[dut.scala 22:23]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 23:30]
    FullAdder_1.io.b <= _T_3 @[dut.scala 23:23]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 24:25]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 22:30]
    FullAdder_2.io.a <= _T_4 @[dut.scala 22:23]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 23:30]
    FullAdder_2.io.b <= _T_5 @[dut.scala 23:23]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 24:25]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 22:30]
    FullAdder_3.io.a <= _T_6 @[dut.scala 22:23]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 23:30]
    FullAdder_3.io.b <= _T_7 @[dut.scala 23:23]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 24:25]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 22:30]
    FullAdder_4.io.a <= _T_8 @[dut.scala 22:23]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 23:30]
    FullAdder_4.io.b <= _T_9 @[dut.scala 23:23]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 24:25]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 22:30]
    FullAdder_5.io.a <= _T_10 @[dut.scala 22:23]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 23:30]
    FullAdder_5.io.b <= _T_11 @[dut.scala 23:23]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 24:25]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 22:30]
    FullAdder_6.io.a <= _T_12 @[dut.scala 22:23]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 23:30]
    FullAdder_6.io.b <= _T_13 @[dut.scala 23:23]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 24:25]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 22:30]
    FullAdder_7.io.a <= _T_14 @[dut.scala 22:23]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 23:30]
    FullAdder_7.io.b <= _T_15 @[dut.scala 23:23]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 24:25]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 22:30]
    FullAdder_8.io.a <= _T_16 @[dut.scala 22:23]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 23:30]
    FullAdder_8.io.b <= _T_17 @[dut.scala 23:23]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 24:25]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 22:30]
    FullAdder_9.io.a <= _T_18 @[dut.scala 22:23]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 23:30]
    FullAdder_9.io.b <= _T_19 @[dut.scala 23:23]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 24:25]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 22:30]
    FullAdder_10.io.a <= _T_20 @[dut.scala 22:23]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 23:30]
    FullAdder_10.io.b <= _T_21 @[dut.scala 23:23]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 24:25]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 22:30]
    FullAdder_11.io.a <= _T_22 @[dut.scala 22:23]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 23:30]
    FullAdder_11.io.b <= _T_23 @[dut.scala 23:23]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 24:25]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 22:30]
    FullAdder_12.io.a <= _T_24 @[dut.scala 22:23]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 23:30]
    FullAdder_12.io.b <= _T_25 @[dut.scala 23:23]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 24:25]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 22:30]
    FullAdder_13.io.a <= _T_26 @[dut.scala 22:23]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 23:30]
    FullAdder_13.io.b <= _T_27 @[dut.scala 23:23]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 24:25]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 22:30]
    FullAdder_14.io.a <= _T_28 @[dut.scala 22:23]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 23:30]
    FullAdder_14.io.b <= _T_29 @[dut.scala 23:23]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 24:25]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 22:30]
    FullAdder_15.io.a <= _T_30 @[dut.scala 22:23]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 23:30]
    FullAdder_15.io.b <= _T_31 @[dut.scala 23:23]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 24:25]
    node io_sum_lo_lo_lo = cat(FullAdder_1.io.sum, FullAdder.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo_hi = cat(FullAdder_3.io.sum, FullAdder_2.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[Cat.scala 33:92]
    node io_sum_lo_hi_lo = cat(FullAdder_5.io.sum, FullAdder_4.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi_hi = cat(FullAdder_7.io.sum, FullAdder_6.io.sum) @[Cat.scala 33:92]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[Cat.scala 33:92]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_lo_lo = cat(FullAdder_9.io.sum, FullAdder_8.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo_hi = cat(FullAdder_11.io.sum, FullAdder_10.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[Cat.scala 33:92]
    node io_sum_hi_hi_lo = cat(FullAdder_13.io.sum, FullAdder_12.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi_hi = cat(FullAdder_15.io.sum, FullAdder_14.io.sum) @[Cat.scala 33:92]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[Cat.scala 33:92]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[Cat.scala 33:92]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[Cat.scala 33:92]
    io.sum <= _io_sum_T @[dut.scala 28:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 29:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      adda_reg <= io.adda @[Reg.scala 36:22]
    reg addb_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addb_reg <= io.addb @[Reg.scala 36:22]
    wire _en_pipeline_WIRE : UInt<1>[4] @[dut.scala 57:36]
    _en_pipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 57:36]
    _en_pipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 57:36]
    _en_pipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 57:36]
    _en_pipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 57:36]
    reg en_pipeline : UInt<1>[4], clock with :
      reset => (reset, _en_pipeline_WIRE) @[dut.scala 57:28]
    en_pipeline[0] <= io.i_en @[dut.scala 58:18]
    en_pipeline[1] <= en_pipeline[0] @[dut.scala 60:20]
    en_pipeline[2] <= en_pipeline[1] @[dut.scala 60:20]
    en_pipeline[3] <= en_pipeline[2] @[dut.scala 60:20]
    inst rca1 of RCA16 @[dut.scala 64:20]
    rca1.clock <= clock
    rca1.reset <= reset
    inst rca2 of RCA16_1 @[dut.scala 65:20]
    rca2.clock <= clock
    rca2.reset <= reset
    inst rca3 of RCA16_2 @[dut.scala 66:20]
    rca3.clock <= clock
    rca3.reset <= reset
    inst rca4 of RCA16_3 @[dut.scala 67:20]
    rca4.clock <= clock
    rca4.reset <= reset
    reg stage1_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 70:23]
    reg stage1_cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1_cout) @[dut.scala 71:24]
    reg stage2_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 72:23]
    reg stage2_cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2_cout) @[dut.scala 73:24]
    reg stage3_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 74:23]
    reg stage3_cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3_cout) @[dut.scala 75:24]
    reg stage4_sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 76:23]
    reg stage4_cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage4_cout) @[dut.scala 77:24]
    node _rca1_io_a_T = bits(adda_reg, 15, 0) @[dut.scala 80:24]
    rca1.io.a <= _rca1_io_a_T @[dut.scala 80:13]
    node _rca1_io_b_T = bits(addb_reg, 15, 0) @[dut.scala 81:24]
    rca1.io.b <= _rca1_io_b_T @[dut.scala 81:13]
    rca1.io.cin <= UInt<1>("h0") @[dut.scala 82:15]
    stage1_sum <= rca1.io.sum @[dut.scala 83:14]
    stage1_cout <= rca1.io.cout @[dut.scala 84:15]
    node _rca2_io_a_T = bits(adda_reg, 31, 16) @[dut.scala 87:24]
    rca2.io.a <= _rca2_io_a_T @[dut.scala 87:13]
    node _rca2_io_b_T = bits(addb_reg, 31, 16) @[dut.scala 88:24]
    rca2.io.b <= _rca2_io_b_T @[dut.scala 88:13]
    rca2.io.cin <= stage1_cout @[dut.scala 89:15]
    stage2_sum <= rca2.io.sum @[dut.scala 90:14]
    stage2_cout <= rca2.io.cout @[dut.scala 91:15]
    node _rca3_io_a_T = bits(adda_reg, 47, 32) @[dut.scala 94:24]
    rca3.io.a <= _rca3_io_a_T @[dut.scala 94:13]
    node _rca3_io_b_T = bits(addb_reg, 47, 32) @[dut.scala 95:24]
    rca3.io.b <= _rca3_io_b_T @[dut.scala 95:13]
    rca3.io.cin <= stage2_cout @[dut.scala 96:15]
    stage3_sum <= rca3.io.sum @[dut.scala 97:14]
    stage3_cout <= rca3.io.cout @[dut.scala 98:15]
    node _rca4_io_a_T = bits(adda_reg, 63, 48) @[dut.scala 101:24]
    rca4.io.a <= _rca4_io_a_T @[dut.scala 101:13]
    node _rca4_io_b_T = bits(addb_reg, 63, 48) @[dut.scala 102:24]
    rca4.io.b <= _rca4_io_b_T @[dut.scala 102:13]
    rca4.io.cin <= stage3_cout @[dut.scala 103:15]
    stage4_sum <= rca4.io.sum @[dut.scala 104:14]
    stage4_cout <= rca4.io.cout @[dut.scala 105:15]
    reg result_reg : UInt<65>, clock with :
      reset => (UInt<1>("h0"), result_reg) @[dut.scala 108:23]
    node result_reg_lo = cat(stage2_sum, stage1_sum) @[Cat.scala 33:92]
    node result_reg_hi_hi = cat(stage4_cout, stage4_sum) @[Cat.scala 33:92]
    node result_reg_hi = cat(result_reg_hi_hi, stage3_sum) @[Cat.scala 33:92]
    node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
    result_reg <= _result_reg_T @[dut.scala 109:14]
    io.result <= result_reg @[dut.scala 110:13]
    io.o_en <= en_pipeline[3] @[dut.scala 113:11]

