circuit dut :
  module FullAdder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder @[dut.scala 13:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_1 @[dut.scala 13:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_2 @[dut.scala 13:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_3 @[dut.scala 13:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_4 @[dut.scala 13:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_5 @[dut.scala 13:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_6 @[dut.scala 13:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_7 @[dut.scala 13:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_8 @[dut.scala 13:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_9 @[dut.scala 13:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_10 @[dut.scala 13:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_11 @[dut.scala 13:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_12 @[dut.scala 13:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_13 @[dut.scala 13:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_14 @[dut.scala 13:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_15 @[dut.scala 13:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    wire sumBits : UInt<1>[16] @[dut.scala 14:21]
    wire coutBits : UInt<1>[16] @[dut.scala 15:22]
    sumBits[0] <= FullAdder.io.sum @[dut.scala 17:14]
    coutBits[0] <= FullAdder.io.cout @[dut.scala 18:15]
    node _T = bits(io.a, 0, 0) @[dut.scala 20:29]
    FullAdder.io.a <= _T @[dut.scala 20:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 21:29]
    FullAdder.io.b <= _T_1 @[dut.scala 21:22]
    FullAdder.io.cin <= io.cin @[dut.scala 22:24]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 25:31]
    FullAdder_1.io.a <= _T_2 @[dut.scala 25:24]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 26:31]
    FullAdder_1.io.b <= _T_3 @[dut.scala 26:24]
    FullAdder_1.io.cin <= coutBits[0] @[dut.scala 27:26]
    sumBits[1] <= FullAdder_1.io.sum @[dut.scala 28:16]
    coutBits[1] <= FullAdder_1.io.cout @[dut.scala 29:17]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 25:31]
    FullAdder_2.io.a <= _T_4 @[dut.scala 25:24]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 26:31]
    FullAdder_2.io.b <= _T_5 @[dut.scala 26:24]
    FullAdder_2.io.cin <= coutBits[1] @[dut.scala 27:26]
    sumBits[2] <= FullAdder_2.io.sum @[dut.scala 28:16]
    coutBits[2] <= FullAdder_2.io.cout @[dut.scala 29:17]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 25:31]
    FullAdder_3.io.a <= _T_6 @[dut.scala 25:24]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 26:31]
    FullAdder_3.io.b <= _T_7 @[dut.scala 26:24]
    FullAdder_3.io.cin <= coutBits[2] @[dut.scala 27:26]
    sumBits[3] <= FullAdder_3.io.sum @[dut.scala 28:16]
    coutBits[3] <= FullAdder_3.io.cout @[dut.scala 29:17]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 25:31]
    FullAdder_4.io.a <= _T_8 @[dut.scala 25:24]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 26:31]
    FullAdder_4.io.b <= _T_9 @[dut.scala 26:24]
    FullAdder_4.io.cin <= coutBits[3] @[dut.scala 27:26]
    sumBits[4] <= FullAdder_4.io.sum @[dut.scala 28:16]
    coutBits[4] <= FullAdder_4.io.cout @[dut.scala 29:17]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 25:31]
    FullAdder_5.io.a <= _T_10 @[dut.scala 25:24]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 26:31]
    FullAdder_5.io.b <= _T_11 @[dut.scala 26:24]
    FullAdder_5.io.cin <= coutBits[4] @[dut.scala 27:26]
    sumBits[5] <= FullAdder_5.io.sum @[dut.scala 28:16]
    coutBits[5] <= FullAdder_5.io.cout @[dut.scala 29:17]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 25:31]
    FullAdder_6.io.a <= _T_12 @[dut.scala 25:24]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 26:31]
    FullAdder_6.io.b <= _T_13 @[dut.scala 26:24]
    FullAdder_6.io.cin <= coutBits[5] @[dut.scala 27:26]
    sumBits[6] <= FullAdder_6.io.sum @[dut.scala 28:16]
    coutBits[6] <= FullAdder_6.io.cout @[dut.scala 29:17]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 25:31]
    FullAdder_7.io.a <= _T_14 @[dut.scala 25:24]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 26:31]
    FullAdder_7.io.b <= _T_15 @[dut.scala 26:24]
    FullAdder_7.io.cin <= coutBits[6] @[dut.scala 27:26]
    sumBits[7] <= FullAdder_7.io.sum @[dut.scala 28:16]
    coutBits[7] <= FullAdder_7.io.cout @[dut.scala 29:17]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 25:31]
    FullAdder_8.io.a <= _T_16 @[dut.scala 25:24]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 26:31]
    FullAdder_8.io.b <= _T_17 @[dut.scala 26:24]
    FullAdder_8.io.cin <= coutBits[7] @[dut.scala 27:26]
    sumBits[8] <= FullAdder_8.io.sum @[dut.scala 28:16]
    coutBits[8] <= FullAdder_8.io.cout @[dut.scala 29:17]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 25:31]
    FullAdder_9.io.a <= _T_18 @[dut.scala 25:24]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 26:31]
    FullAdder_9.io.b <= _T_19 @[dut.scala 26:24]
    FullAdder_9.io.cin <= coutBits[8] @[dut.scala 27:26]
    sumBits[9] <= FullAdder_9.io.sum @[dut.scala 28:16]
    coutBits[9] <= FullAdder_9.io.cout @[dut.scala 29:17]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 25:31]
    FullAdder_10.io.a <= _T_20 @[dut.scala 25:24]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 26:31]
    FullAdder_10.io.b <= _T_21 @[dut.scala 26:24]
    FullAdder_10.io.cin <= coutBits[9] @[dut.scala 27:26]
    sumBits[10] <= FullAdder_10.io.sum @[dut.scala 28:16]
    coutBits[10] <= FullAdder_10.io.cout @[dut.scala 29:17]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 25:31]
    FullAdder_11.io.a <= _T_22 @[dut.scala 25:24]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 26:31]
    FullAdder_11.io.b <= _T_23 @[dut.scala 26:24]
    FullAdder_11.io.cin <= coutBits[10] @[dut.scala 27:26]
    sumBits[11] <= FullAdder_11.io.sum @[dut.scala 28:16]
    coutBits[11] <= FullAdder_11.io.cout @[dut.scala 29:17]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 25:31]
    FullAdder_12.io.a <= _T_24 @[dut.scala 25:24]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 26:31]
    FullAdder_12.io.b <= _T_25 @[dut.scala 26:24]
    FullAdder_12.io.cin <= coutBits[11] @[dut.scala 27:26]
    sumBits[12] <= FullAdder_12.io.sum @[dut.scala 28:16]
    coutBits[12] <= FullAdder_12.io.cout @[dut.scala 29:17]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 25:31]
    FullAdder_13.io.a <= _T_26 @[dut.scala 25:24]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 26:31]
    FullAdder_13.io.b <= _T_27 @[dut.scala 26:24]
    FullAdder_13.io.cin <= coutBits[12] @[dut.scala 27:26]
    sumBits[13] <= FullAdder_13.io.sum @[dut.scala 28:16]
    coutBits[13] <= FullAdder_13.io.cout @[dut.scala 29:17]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 25:31]
    FullAdder_14.io.a <= _T_28 @[dut.scala 25:24]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 26:31]
    FullAdder_14.io.b <= _T_29 @[dut.scala 26:24]
    FullAdder_14.io.cin <= coutBits[13] @[dut.scala 27:26]
    sumBits[14] <= FullAdder_14.io.sum @[dut.scala 28:16]
    coutBits[14] <= FullAdder_14.io.cout @[dut.scala 29:17]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 25:31]
    FullAdder_15.io.a <= _T_30 @[dut.scala 25:24]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 26:31]
    FullAdder_15.io.b <= _T_31 @[dut.scala 26:24]
    FullAdder_15.io.cin <= coutBits[14] @[dut.scala 27:26]
    sumBits[15] <= FullAdder_15.io.sum @[dut.scala 28:16]
    coutBits[15] <= FullAdder_15.io.cout @[dut.scala 29:17]
    node io_sum_lo_lo_lo = cat(sumBits[1], sumBits[0]) @[dut.scala 32:27]
    node io_sum_lo_lo_hi = cat(sumBits[3], sumBits[2]) @[dut.scala 32:27]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 32:27]
    node io_sum_lo_hi_lo = cat(sumBits[5], sumBits[4]) @[dut.scala 32:27]
    node io_sum_lo_hi_hi = cat(sumBits[7], sumBits[6]) @[dut.scala 32:27]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 32:27]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_lo_lo = cat(sumBits[9], sumBits[8]) @[dut.scala 32:27]
    node io_sum_hi_lo_hi = cat(sumBits[11], sumBits[10]) @[dut.scala 32:27]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_hi_lo = cat(sumBits[13], sumBits[12]) @[dut.scala 32:27]
    node io_sum_hi_hi_hi = cat(sumBits[15], sumBits[14]) @[dut.scala 32:27]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 32:27]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 32:27]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 32:27]
    io.sum <= _io_sum_T @[dut.scala 32:10]
    io.cout <= coutBits[15] @[dut.scala 33:11]

  module FullAdder_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_20 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_21 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_22 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_23 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_24 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_25 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_26 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_27 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_28 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_29 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_30 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_31 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_16 @[dut.scala 13:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_17 @[dut.scala 13:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_18 @[dut.scala 13:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_19 @[dut.scala 13:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_20 @[dut.scala 13:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_21 @[dut.scala 13:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_22 @[dut.scala 13:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_23 @[dut.scala 13:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_24 @[dut.scala 13:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_25 @[dut.scala 13:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_26 @[dut.scala 13:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_27 @[dut.scala 13:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_28 @[dut.scala 13:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_29 @[dut.scala 13:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_30 @[dut.scala 13:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_31 @[dut.scala 13:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    wire sumBits : UInt<1>[16] @[dut.scala 14:21]
    wire coutBits : UInt<1>[16] @[dut.scala 15:22]
    sumBits[0] <= FullAdder.io.sum @[dut.scala 17:14]
    coutBits[0] <= FullAdder.io.cout @[dut.scala 18:15]
    node _T = bits(io.a, 0, 0) @[dut.scala 20:29]
    FullAdder.io.a <= _T @[dut.scala 20:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 21:29]
    FullAdder.io.b <= _T_1 @[dut.scala 21:22]
    FullAdder.io.cin <= io.cin @[dut.scala 22:24]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 25:31]
    FullAdder_1.io.a <= _T_2 @[dut.scala 25:24]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 26:31]
    FullAdder_1.io.b <= _T_3 @[dut.scala 26:24]
    FullAdder_1.io.cin <= coutBits[0] @[dut.scala 27:26]
    sumBits[1] <= FullAdder_1.io.sum @[dut.scala 28:16]
    coutBits[1] <= FullAdder_1.io.cout @[dut.scala 29:17]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 25:31]
    FullAdder_2.io.a <= _T_4 @[dut.scala 25:24]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 26:31]
    FullAdder_2.io.b <= _T_5 @[dut.scala 26:24]
    FullAdder_2.io.cin <= coutBits[1] @[dut.scala 27:26]
    sumBits[2] <= FullAdder_2.io.sum @[dut.scala 28:16]
    coutBits[2] <= FullAdder_2.io.cout @[dut.scala 29:17]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 25:31]
    FullAdder_3.io.a <= _T_6 @[dut.scala 25:24]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 26:31]
    FullAdder_3.io.b <= _T_7 @[dut.scala 26:24]
    FullAdder_3.io.cin <= coutBits[2] @[dut.scala 27:26]
    sumBits[3] <= FullAdder_3.io.sum @[dut.scala 28:16]
    coutBits[3] <= FullAdder_3.io.cout @[dut.scala 29:17]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 25:31]
    FullAdder_4.io.a <= _T_8 @[dut.scala 25:24]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 26:31]
    FullAdder_4.io.b <= _T_9 @[dut.scala 26:24]
    FullAdder_4.io.cin <= coutBits[3] @[dut.scala 27:26]
    sumBits[4] <= FullAdder_4.io.sum @[dut.scala 28:16]
    coutBits[4] <= FullAdder_4.io.cout @[dut.scala 29:17]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 25:31]
    FullAdder_5.io.a <= _T_10 @[dut.scala 25:24]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 26:31]
    FullAdder_5.io.b <= _T_11 @[dut.scala 26:24]
    FullAdder_5.io.cin <= coutBits[4] @[dut.scala 27:26]
    sumBits[5] <= FullAdder_5.io.sum @[dut.scala 28:16]
    coutBits[5] <= FullAdder_5.io.cout @[dut.scala 29:17]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 25:31]
    FullAdder_6.io.a <= _T_12 @[dut.scala 25:24]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 26:31]
    FullAdder_6.io.b <= _T_13 @[dut.scala 26:24]
    FullAdder_6.io.cin <= coutBits[5] @[dut.scala 27:26]
    sumBits[6] <= FullAdder_6.io.sum @[dut.scala 28:16]
    coutBits[6] <= FullAdder_6.io.cout @[dut.scala 29:17]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 25:31]
    FullAdder_7.io.a <= _T_14 @[dut.scala 25:24]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 26:31]
    FullAdder_7.io.b <= _T_15 @[dut.scala 26:24]
    FullAdder_7.io.cin <= coutBits[6] @[dut.scala 27:26]
    sumBits[7] <= FullAdder_7.io.sum @[dut.scala 28:16]
    coutBits[7] <= FullAdder_7.io.cout @[dut.scala 29:17]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 25:31]
    FullAdder_8.io.a <= _T_16 @[dut.scala 25:24]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 26:31]
    FullAdder_8.io.b <= _T_17 @[dut.scala 26:24]
    FullAdder_8.io.cin <= coutBits[7] @[dut.scala 27:26]
    sumBits[8] <= FullAdder_8.io.sum @[dut.scala 28:16]
    coutBits[8] <= FullAdder_8.io.cout @[dut.scala 29:17]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 25:31]
    FullAdder_9.io.a <= _T_18 @[dut.scala 25:24]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 26:31]
    FullAdder_9.io.b <= _T_19 @[dut.scala 26:24]
    FullAdder_9.io.cin <= coutBits[8] @[dut.scala 27:26]
    sumBits[9] <= FullAdder_9.io.sum @[dut.scala 28:16]
    coutBits[9] <= FullAdder_9.io.cout @[dut.scala 29:17]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 25:31]
    FullAdder_10.io.a <= _T_20 @[dut.scala 25:24]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 26:31]
    FullAdder_10.io.b <= _T_21 @[dut.scala 26:24]
    FullAdder_10.io.cin <= coutBits[9] @[dut.scala 27:26]
    sumBits[10] <= FullAdder_10.io.sum @[dut.scala 28:16]
    coutBits[10] <= FullAdder_10.io.cout @[dut.scala 29:17]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 25:31]
    FullAdder_11.io.a <= _T_22 @[dut.scala 25:24]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 26:31]
    FullAdder_11.io.b <= _T_23 @[dut.scala 26:24]
    FullAdder_11.io.cin <= coutBits[10] @[dut.scala 27:26]
    sumBits[11] <= FullAdder_11.io.sum @[dut.scala 28:16]
    coutBits[11] <= FullAdder_11.io.cout @[dut.scala 29:17]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 25:31]
    FullAdder_12.io.a <= _T_24 @[dut.scala 25:24]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 26:31]
    FullAdder_12.io.b <= _T_25 @[dut.scala 26:24]
    FullAdder_12.io.cin <= coutBits[11] @[dut.scala 27:26]
    sumBits[12] <= FullAdder_12.io.sum @[dut.scala 28:16]
    coutBits[12] <= FullAdder_12.io.cout @[dut.scala 29:17]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 25:31]
    FullAdder_13.io.a <= _T_26 @[dut.scala 25:24]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 26:31]
    FullAdder_13.io.b <= _T_27 @[dut.scala 26:24]
    FullAdder_13.io.cin <= coutBits[12] @[dut.scala 27:26]
    sumBits[13] <= FullAdder_13.io.sum @[dut.scala 28:16]
    coutBits[13] <= FullAdder_13.io.cout @[dut.scala 29:17]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 25:31]
    FullAdder_14.io.a <= _T_28 @[dut.scala 25:24]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 26:31]
    FullAdder_14.io.b <= _T_29 @[dut.scala 26:24]
    FullAdder_14.io.cin <= coutBits[13] @[dut.scala 27:26]
    sumBits[14] <= FullAdder_14.io.sum @[dut.scala 28:16]
    coutBits[14] <= FullAdder_14.io.cout @[dut.scala 29:17]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 25:31]
    FullAdder_15.io.a <= _T_30 @[dut.scala 25:24]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 26:31]
    FullAdder_15.io.b <= _T_31 @[dut.scala 26:24]
    FullAdder_15.io.cin <= coutBits[14] @[dut.scala 27:26]
    sumBits[15] <= FullAdder_15.io.sum @[dut.scala 28:16]
    coutBits[15] <= FullAdder_15.io.cout @[dut.scala 29:17]
    node io_sum_lo_lo_lo = cat(sumBits[1], sumBits[0]) @[dut.scala 32:27]
    node io_sum_lo_lo_hi = cat(sumBits[3], sumBits[2]) @[dut.scala 32:27]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 32:27]
    node io_sum_lo_hi_lo = cat(sumBits[5], sumBits[4]) @[dut.scala 32:27]
    node io_sum_lo_hi_hi = cat(sumBits[7], sumBits[6]) @[dut.scala 32:27]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 32:27]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_lo_lo = cat(sumBits[9], sumBits[8]) @[dut.scala 32:27]
    node io_sum_hi_lo_hi = cat(sumBits[11], sumBits[10]) @[dut.scala 32:27]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_hi_lo = cat(sumBits[13], sumBits[12]) @[dut.scala 32:27]
    node io_sum_hi_hi_hi = cat(sumBits[15], sumBits[14]) @[dut.scala 32:27]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 32:27]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 32:27]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 32:27]
    io.sum <= _io_sum_T @[dut.scala 32:10]
    io.cout <= coutBits[15] @[dut.scala 33:11]

  module FullAdder_32 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_33 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_34 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_35 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_36 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_37 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_38 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_39 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_40 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_41 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_42 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_43 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_44 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_45 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_46 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_47 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_32 @[dut.scala 13:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_33 @[dut.scala 13:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_34 @[dut.scala 13:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_35 @[dut.scala 13:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_36 @[dut.scala 13:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_37 @[dut.scala 13:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_38 @[dut.scala 13:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_39 @[dut.scala 13:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_40 @[dut.scala 13:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_41 @[dut.scala 13:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_42 @[dut.scala 13:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_43 @[dut.scala 13:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_44 @[dut.scala 13:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_45 @[dut.scala 13:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_46 @[dut.scala 13:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_47 @[dut.scala 13:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    wire sumBits : UInt<1>[16] @[dut.scala 14:21]
    wire coutBits : UInt<1>[16] @[dut.scala 15:22]
    sumBits[0] <= FullAdder.io.sum @[dut.scala 17:14]
    coutBits[0] <= FullAdder.io.cout @[dut.scala 18:15]
    node _T = bits(io.a, 0, 0) @[dut.scala 20:29]
    FullAdder.io.a <= _T @[dut.scala 20:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 21:29]
    FullAdder.io.b <= _T_1 @[dut.scala 21:22]
    FullAdder.io.cin <= io.cin @[dut.scala 22:24]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 25:31]
    FullAdder_1.io.a <= _T_2 @[dut.scala 25:24]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 26:31]
    FullAdder_1.io.b <= _T_3 @[dut.scala 26:24]
    FullAdder_1.io.cin <= coutBits[0] @[dut.scala 27:26]
    sumBits[1] <= FullAdder_1.io.sum @[dut.scala 28:16]
    coutBits[1] <= FullAdder_1.io.cout @[dut.scala 29:17]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 25:31]
    FullAdder_2.io.a <= _T_4 @[dut.scala 25:24]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 26:31]
    FullAdder_2.io.b <= _T_5 @[dut.scala 26:24]
    FullAdder_2.io.cin <= coutBits[1] @[dut.scala 27:26]
    sumBits[2] <= FullAdder_2.io.sum @[dut.scala 28:16]
    coutBits[2] <= FullAdder_2.io.cout @[dut.scala 29:17]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 25:31]
    FullAdder_3.io.a <= _T_6 @[dut.scala 25:24]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 26:31]
    FullAdder_3.io.b <= _T_7 @[dut.scala 26:24]
    FullAdder_3.io.cin <= coutBits[2] @[dut.scala 27:26]
    sumBits[3] <= FullAdder_3.io.sum @[dut.scala 28:16]
    coutBits[3] <= FullAdder_3.io.cout @[dut.scala 29:17]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 25:31]
    FullAdder_4.io.a <= _T_8 @[dut.scala 25:24]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 26:31]
    FullAdder_4.io.b <= _T_9 @[dut.scala 26:24]
    FullAdder_4.io.cin <= coutBits[3] @[dut.scala 27:26]
    sumBits[4] <= FullAdder_4.io.sum @[dut.scala 28:16]
    coutBits[4] <= FullAdder_4.io.cout @[dut.scala 29:17]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 25:31]
    FullAdder_5.io.a <= _T_10 @[dut.scala 25:24]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 26:31]
    FullAdder_5.io.b <= _T_11 @[dut.scala 26:24]
    FullAdder_5.io.cin <= coutBits[4] @[dut.scala 27:26]
    sumBits[5] <= FullAdder_5.io.sum @[dut.scala 28:16]
    coutBits[5] <= FullAdder_5.io.cout @[dut.scala 29:17]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 25:31]
    FullAdder_6.io.a <= _T_12 @[dut.scala 25:24]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 26:31]
    FullAdder_6.io.b <= _T_13 @[dut.scala 26:24]
    FullAdder_6.io.cin <= coutBits[5] @[dut.scala 27:26]
    sumBits[6] <= FullAdder_6.io.sum @[dut.scala 28:16]
    coutBits[6] <= FullAdder_6.io.cout @[dut.scala 29:17]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 25:31]
    FullAdder_7.io.a <= _T_14 @[dut.scala 25:24]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 26:31]
    FullAdder_7.io.b <= _T_15 @[dut.scala 26:24]
    FullAdder_7.io.cin <= coutBits[6] @[dut.scala 27:26]
    sumBits[7] <= FullAdder_7.io.sum @[dut.scala 28:16]
    coutBits[7] <= FullAdder_7.io.cout @[dut.scala 29:17]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 25:31]
    FullAdder_8.io.a <= _T_16 @[dut.scala 25:24]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 26:31]
    FullAdder_8.io.b <= _T_17 @[dut.scala 26:24]
    FullAdder_8.io.cin <= coutBits[7] @[dut.scala 27:26]
    sumBits[8] <= FullAdder_8.io.sum @[dut.scala 28:16]
    coutBits[8] <= FullAdder_8.io.cout @[dut.scala 29:17]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 25:31]
    FullAdder_9.io.a <= _T_18 @[dut.scala 25:24]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 26:31]
    FullAdder_9.io.b <= _T_19 @[dut.scala 26:24]
    FullAdder_9.io.cin <= coutBits[8] @[dut.scala 27:26]
    sumBits[9] <= FullAdder_9.io.sum @[dut.scala 28:16]
    coutBits[9] <= FullAdder_9.io.cout @[dut.scala 29:17]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 25:31]
    FullAdder_10.io.a <= _T_20 @[dut.scala 25:24]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 26:31]
    FullAdder_10.io.b <= _T_21 @[dut.scala 26:24]
    FullAdder_10.io.cin <= coutBits[9] @[dut.scala 27:26]
    sumBits[10] <= FullAdder_10.io.sum @[dut.scala 28:16]
    coutBits[10] <= FullAdder_10.io.cout @[dut.scala 29:17]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 25:31]
    FullAdder_11.io.a <= _T_22 @[dut.scala 25:24]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 26:31]
    FullAdder_11.io.b <= _T_23 @[dut.scala 26:24]
    FullAdder_11.io.cin <= coutBits[10] @[dut.scala 27:26]
    sumBits[11] <= FullAdder_11.io.sum @[dut.scala 28:16]
    coutBits[11] <= FullAdder_11.io.cout @[dut.scala 29:17]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 25:31]
    FullAdder_12.io.a <= _T_24 @[dut.scala 25:24]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 26:31]
    FullAdder_12.io.b <= _T_25 @[dut.scala 26:24]
    FullAdder_12.io.cin <= coutBits[11] @[dut.scala 27:26]
    sumBits[12] <= FullAdder_12.io.sum @[dut.scala 28:16]
    coutBits[12] <= FullAdder_12.io.cout @[dut.scala 29:17]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 25:31]
    FullAdder_13.io.a <= _T_26 @[dut.scala 25:24]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 26:31]
    FullAdder_13.io.b <= _T_27 @[dut.scala 26:24]
    FullAdder_13.io.cin <= coutBits[12] @[dut.scala 27:26]
    sumBits[13] <= FullAdder_13.io.sum @[dut.scala 28:16]
    coutBits[13] <= FullAdder_13.io.cout @[dut.scala 29:17]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 25:31]
    FullAdder_14.io.a <= _T_28 @[dut.scala 25:24]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 26:31]
    FullAdder_14.io.b <= _T_29 @[dut.scala 26:24]
    FullAdder_14.io.cin <= coutBits[13] @[dut.scala 27:26]
    sumBits[14] <= FullAdder_14.io.sum @[dut.scala 28:16]
    coutBits[14] <= FullAdder_14.io.cout @[dut.scala 29:17]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 25:31]
    FullAdder_15.io.a <= _T_30 @[dut.scala 25:24]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 26:31]
    FullAdder_15.io.b <= _T_31 @[dut.scala 26:24]
    FullAdder_15.io.cin <= coutBits[14] @[dut.scala 27:26]
    sumBits[15] <= FullAdder_15.io.sum @[dut.scala 28:16]
    coutBits[15] <= FullAdder_15.io.cout @[dut.scala 29:17]
    node io_sum_lo_lo_lo = cat(sumBits[1], sumBits[0]) @[dut.scala 32:27]
    node io_sum_lo_lo_hi = cat(sumBits[3], sumBits[2]) @[dut.scala 32:27]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 32:27]
    node io_sum_lo_hi_lo = cat(sumBits[5], sumBits[4]) @[dut.scala 32:27]
    node io_sum_lo_hi_hi = cat(sumBits[7], sumBits[6]) @[dut.scala 32:27]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 32:27]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_lo_lo = cat(sumBits[9], sumBits[8]) @[dut.scala 32:27]
    node io_sum_hi_lo_hi = cat(sumBits[11], sumBits[10]) @[dut.scala 32:27]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_hi_lo = cat(sumBits[13], sumBits[12]) @[dut.scala 32:27]
    node io_sum_hi_hi_hi = cat(sumBits[15], sumBits[14]) @[dut.scala 32:27]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 32:27]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 32:27]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 32:27]
    io.sum <= _io_sum_T @[dut.scala 32:10]
    io.cout <= coutBits[15] @[dut.scala 33:11]

  module FullAdder_48 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_49 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_50 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_51 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_52 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_53 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_54 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_55 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_56 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_57 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_58 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_59 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_60 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_61 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_62 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module FullAdder_63 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 45:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 45:25]
    io.sum <= _io_sum_T_1 @[dut.scala 45:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 46:20]
    node _io_cout_T_1 = and(io.a, io.cin) @[dut.scala 46:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 46:28]
    node _io_cout_T_3 = and(io.b, io.cin) @[dut.scala 46:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 46:46]
    io.cout <= _io_cout_T_4 @[dut.scala 46:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_48 @[dut.scala 13:41]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    inst FullAdder_1 of FullAdder_49 @[dut.scala 13:41]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    inst FullAdder_2 of FullAdder_50 @[dut.scala 13:41]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    inst FullAdder_3 of FullAdder_51 @[dut.scala 13:41]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    inst FullAdder_4 of FullAdder_52 @[dut.scala 13:41]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    inst FullAdder_5 of FullAdder_53 @[dut.scala 13:41]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    inst FullAdder_6 of FullAdder_54 @[dut.scala 13:41]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    inst FullAdder_7 of FullAdder_55 @[dut.scala 13:41]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    inst FullAdder_8 of FullAdder_56 @[dut.scala 13:41]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    inst FullAdder_9 of FullAdder_57 @[dut.scala 13:41]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    inst FullAdder_10 of FullAdder_58 @[dut.scala 13:41]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    inst FullAdder_11 of FullAdder_59 @[dut.scala 13:41]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    inst FullAdder_12 of FullAdder_60 @[dut.scala 13:41]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    inst FullAdder_13 of FullAdder_61 @[dut.scala 13:41]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    inst FullAdder_14 of FullAdder_62 @[dut.scala 13:41]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    inst FullAdder_15 of FullAdder_63 @[dut.scala 13:41]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    wire sumBits : UInt<1>[16] @[dut.scala 14:21]
    wire coutBits : UInt<1>[16] @[dut.scala 15:22]
    sumBits[0] <= FullAdder.io.sum @[dut.scala 17:14]
    coutBits[0] <= FullAdder.io.cout @[dut.scala 18:15]
    node _T = bits(io.a, 0, 0) @[dut.scala 20:29]
    FullAdder.io.a <= _T @[dut.scala 20:22]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 21:29]
    FullAdder.io.b <= _T_1 @[dut.scala 21:22]
    FullAdder.io.cin <= io.cin @[dut.scala 22:24]
    node _T_2 = bits(io.a, 1, 1) @[dut.scala 25:31]
    FullAdder_1.io.a <= _T_2 @[dut.scala 25:24]
    node _T_3 = bits(io.b, 1, 1) @[dut.scala 26:31]
    FullAdder_1.io.b <= _T_3 @[dut.scala 26:24]
    FullAdder_1.io.cin <= coutBits[0] @[dut.scala 27:26]
    sumBits[1] <= FullAdder_1.io.sum @[dut.scala 28:16]
    coutBits[1] <= FullAdder_1.io.cout @[dut.scala 29:17]
    node _T_4 = bits(io.a, 2, 2) @[dut.scala 25:31]
    FullAdder_2.io.a <= _T_4 @[dut.scala 25:24]
    node _T_5 = bits(io.b, 2, 2) @[dut.scala 26:31]
    FullAdder_2.io.b <= _T_5 @[dut.scala 26:24]
    FullAdder_2.io.cin <= coutBits[1] @[dut.scala 27:26]
    sumBits[2] <= FullAdder_2.io.sum @[dut.scala 28:16]
    coutBits[2] <= FullAdder_2.io.cout @[dut.scala 29:17]
    node _T_6 = bits(io.a, 3, 3) @[dut.scala 25:31]
    FullAdder_3.io.a <= _T_6 @[dut.scala 25:24]
    node _T_7 = bits(io.b, 3, 3) @[dut.scala 26:31]
    FullAdder_3.io.b <= _T_7 @[dut.scala 26:24]
    FullAdder_3.io.cin <= coutBits[2] @[dut.scala 27:26]
    sumBits[3] <= FullAdder_3.io.sum @[dut.scala 28:16]
    coutBits[3] <= FullAdder_3.io.cout @[dut.scala 29:17]
    node _T_8 = bits(io.a, 4, 4) @[dut.scala 25:31]
    FullAdder_4.io.a <= _T_8 @[dut.scala 25:24]
    node _T_9 = bits(io.b, 4, 4) @[dut.scala 26:31]
    FullAdder_4.io.b <= _T_9 @[dut.scala 26:24]
    FullAdder_4.io.cin <= coutBits[3] @[dut.scala 27:26]
    sumBits[4] <= FullAdder_4.io.sum @[dut.scala 28:16]
    coutBits[4] <= FullAdder_4.io.cout @[dut.scala 29:17]
    node _T_10 = bits(io.a, 5, 5) @[dut.scala 25:31]
    FullAdder_5.io.a <= _T_10 @[dut.scala 25:24]
    node _T_11 = bits(io.b, 5, 5) @[dut.scala 26:31]
    FullAdder_5.io.b <= _T_11 @[dut.scala 26:24]
    FullAdder_5.io.cin <= coutBits[4] @[dut.scala 27:26]
    sumBits[5] <= FullAdder_5.io.sum @[dut.scala 28:16]
    coutBits[5] <= FullAdder_5.io.cout @[dut.scala 29:17]
    node _T_12 = bits(io.a, 6, 6) @[dut.scala 25:31]
    FullAdder_6.io.a <= _T_12 @[dut.scala 25:24]
    node _T_13 = bits(io.b, 6, 6) @[dut.scala 26:31]
    FullAdder_6.io.b <= _T_13 @[dut.scala 26:24]
    FullAdder_6.io.cin <= coutBits[5] @[dut.scala 27:26]
    sumBits[6] <= FullAdder_6.io.sum @[dut.scala 28:16]
    coutBits[6] <= FullAdder_6.io.cout @[dut.scala 29:17]
    node _T_14 = bits(io.a, 7, 7) @[dut.scala 25:31]
    FullAdder_7.io.a <= _T_14 @[dut.scala 25:24]
    node _T_15 = bits(io.b, 7, 7) @[dut.scala 26:31]
    FullAdder_7.io.b <= _T_15 @[dut.scala 26:24]
    FullAdder_7.io.cin <= coutBits[6] @[dut.scala 27:26]
    sumBits[7] <= FullAdder_7.io.sum @[dut.scala 28:16]
    coutBits[7] <= FullAdder_7.io.cout @[dut.scala 29:17]
    node _T_16 = bits(io.a, 8, 8) @[dut.scala 25:31]
    FullAdder_8.io.a <= _T_16 @[dut.scala 25:24]
    node _T_17 = bits(io.b, 8, 8) @[dut.scala 26:31]
    FullAdder_8.io.b <= _T_17 @[dut.scala 26:24]
    FullAdder_8.io.cin <= coutBits[7] @[dut.scala 27:26]
    sumBits[8] <= FullAdder_8.io.sum @[dut.scala 28:16]
    coutBits[8] <= FullAdder_8.io.cout @[dut.scala 29:17]
    node _T_18 = bits(io.a, 9, 9) @[dut.scala 25:31]
    FullAdder_9.io.a <= _T_18 @[dut.scala 25:24]
    node _T_19 = bits(io.b, 9, 9) @[dut.scala 26:31]
    FullAdder_9.io.b <= _T_19 @[dut.scala 26:24]
    FullAdder_9.io.cin <= coutBits[8] @[dut.scala 27:26]
    sumBits[9] <= FullAdder_9.io.sum @[dut.scala 28:16]
    coutBits[9] <= FullAdder_9.io.cout @[dut.scala 29:17]
    node _T_20 = bits(io.a, 10, 10) @[dut.scala 25:31]
    FullAdder_10.io.a <= _T_20 @[dut.scala 25:24]
    node _T_21 = bits(io.b, 10, 10) @[dut.scala 26:31]
    FullAdder_10.io.b <= _T_21 @[dut.scala 26:24]
    FullAdder_10.io.cin <= coutBits[9] @[dut.scala 27:26]
    sumBits[10] <= FullAdder_10.io.sum @[dut.scala 28:16]
    coutBits[10] <= FullAdder_10.io.cout @[dut.scala 29:17]
    node _T_22 = bits(io.a, 11, 11) @[dut.scala 25:31]
    FullAdder_11.io.a <= _T_22 @[dut.scala 25:24]
    node _T_23 = bits(io.b, 11, 11) @[dut.scala 26:31]
    FullAdder_11.io.b <= _T_23 @[dut.scala 26:24]
    FullAdder_11.io.cin <= coutBits[10] @[dut.scala 27:26]
    sumBits[11] <= FullAdder_11.io.sum @[dut.scala 28:16]
    coutBits[11] <= FullAdder_11.io.cout @[dut.scala 29:17]
    node _T_24 = bits(io.a, 12, 12) @[dut.scala 25:31]
    FullAdder_12.io.a <= _T_24 @[dut.scala 25:24]
    node _T_25 = bits(io.b, 12, 12) @[dut.scala 26:31]
    FullAdder_12.io.b <= _T_25 @[dut.scala 26:24]
    FullAdder_12.io.cin <= coutBits[11] @[dut.scala 27:26]
    sumBits[12] <= FullAdder_12.io.sum @[dut.scala 28:16]
    coutBits[12] <= FullAdder_12.io.cout @[dut.scala 29:17]
    node _T_26 = bits(io.a, 13, 13) @[dut.scala 25:31]
    FullAdder_13.io.a <= _T_26 @[dut.scala 25:24]
    node _T_27 = bits(io.b, 13, 13) @[dut.scala 26:31]
    FullAdder_13.io.b <= _T_27 @[dut.scala 26:24]
    FullAdder_13.io.cin <= coutBits[12] @[dut.scala 27:26]
    sumBits[13] <= FullAdder_13.io.sum @[dut.scala 28:16]
    coutBits[13] <= FullAdder_13.io.cout @[dut.scala 29:17]
    node _T_28 = bits(io.a, 14, 14) @[dut.scala 25:31]
    FullAdder_14.io.a <= _T_28 @[dut.scala 25:24]
    node _T_29 = bits(io.b, 14, 14) @[dut.scala 26:31]
    FullAdder_14.io.b <= _T_29 @[dut.scala 26:24]
    FullAdder_14.io.cin <= coutBits[13] @[dut.scala 27:26]
    sumBits[14] <= FullAdder_14.io.sum @[dut.scala 28:16]
    coutBits[14] <= FullAdder_14.io.cout @[dut.scala 29:17]
    node _T_30 = bits(io.a, 15, 15) @[dut.scala 25:31]
    FullAdder_15.io.a <= _T_30 @[dut.scala 25:24]
    node _T_31 = bits(io.b, 15, 15) @[dut.scala 26:31]
    FullAdder_15.io.b <= _T_31 @[dut.scala 26:24]
    FullAdder_15.io.cin <= coutBits[14] @[dut.scala 27:26]
    sumBits[15] <= FullAdder_15.io.sum @[dut.scala 28:16]
    coutBits[15] <= FullAdder_15.io.cout @[dut.scala 29:17]
    node io_sum_lo_lo_lo = cat(sumBits[1], sumBits[0]) @[dut.scala 32:27]
    node io_sum_lo_lo_hi = cat(sumBits[3], sumBits[2]) @[dut.scala 32:27]
    node io_sum_lo_lo = cat(io_sum_lo_lo_hi, io_sum_lo_lo_lo) @[dut.scala 32:27]
    node io_sum_lo_hi_lo = cat(sumBits[5], sumBits[4]) @[dut.scala 32:27]
    node io_sum_lo_hi_hi = cat(sumBits[7], sumBits[6]) @[dut.scala 32:27]
    node io_sum_lo_hi = cat(io_sum_lo_hi_hi, io_sum_lo_hi_lo) @[dut.scala 32:27]
    node io_sum_lo = cat(io_sum_lo_hi, io_sum_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_lo_lo = cat(sumBits[9], sumBits[8]) @[dut.scala 32:27]
    node io_sum_hi_lo_hi = cat(sumBits[11], sumBits[10]) @[dut.scala 32:27]
    node io_sum_hi_lo = cat(io_sum_hi_lo_hi, io_sum_hi_lo_lo) @[dut.scala 32:27]
    node io_sum_hi_hi_lo = cat(sumBits[13], sumBits[12]) @[dut.scala 32:27]
    node io_sum_hi_hi_hi = cat(sumBits[15], sumBits[14]) @[dut.scala 32:27]
    node io_sum_hi_hi = cat(io_sum_hi_hi_hi, io_sum_hi_hi_lo) @[dut.scala 32:27]
    node io_sum_hi = cat(io_sum_hi_hi, io_sum_hi_lo) @[dut.scala 32:27]
    node _io_sum_T = cat(io_sum_hi, io_sum_lo) @[dut.scala 32:27]
    io.sum <= _io_sum_T @[dut.scala 32:10]
    io.cout <= coutBits[15] @[dut.scala 33:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      adda_reg <= io.adda @[Reg.scala 36:22]
    reg addb_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addb_reg <= io.addb @[Reg.scala 36:22]
    wire _en_pipeline_WIRE : UInt<1>[4] @[dut.scala 62:36]
    _en_pipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 62:36]
    _en_pipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 62:36]
    _en_pipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 62:36]
    _en_pipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 62:36]
    reg en_pipeline : UInt<1>[4], clock with :
      reset => (reset, _en_pipeline_WIRE) @[dut.scala 62:28]
    en_pipeline[0] <= io.i_en @[dut.scala 63:18]
    en_pipeline[1] <= en_pipeline[0] @[dut.scala 65:20]
    en_pipeline[2] <= en_pipeline[1] @[dut.scala 65:20]
    en_pipeline[3] <= en_pipeline[2] @[dut.scala 65:20]
    inst stage1 of RCA16 @[dut.scala 69:22]
    stage1.clock <= clock
    stage1.reset <= reset
    node _stage1_io_a_T = bits(adda_reg, 15, 0) @[dut.scala 70:26]
    stage1.io.a <= _stage1_io_a_T @[dut.scala 70:15]
    node _stage1_io_b_T = bits(addb_reg, 15, 0) @[dut.scala 71:26]
    stage1.io.b <= _stage1_io_b_T @[dut.scala 71:15]
    stage1.io.cin <= UInt<1>("h0") @[dut.scala 72:17]
    reg stage1_sum : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[0] : @[Reg.scala 36:18]
      stage1_sum <= stage1.io.sum @[Reg.scala 36:22]
    reg stage1_cout : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[0] : @[Reg.scala 36:18]
      stage1_cout <= stage1.io.cout @[Reg.scala 36:22]
    inst stage2 of RCA16_1 @[dut.scala 76:22]
    stage2.clock <= clock
    stage2.reset <= reset
    node _stage2_io_a_T = bits(adda_reg, 31, 16) @[dut.scala 77:26]
    stage2.io.a <= _stage2_io_a_T @[dut.scala 77:15]
    node _stage2_io_b_T = bits(addb_reg, 31, 16) @[dut.scala 78:26]
    stage2.io.b <= _stage2_io_b_T @[dut.scala 78:15]
    stage2.io.cin <= stage1_cout @[dut.scala 79:17]
    reg stage2_sum : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[1] : @[Reg.scala 36:18]
      stage2_sum <= stage2.io.sum @[Reg.scala 36:22]
    reg stage2_cout : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[1] : @[Reg.scala 36:18]
      stage2_cout <= stage2.io.cout @[Reg.scala 36:22]
    inst stage3 of RCA16_2 @[dut.scala 83:22]
    stage3.clock <= clock
    stage3.reset <= reset
    node _stage3_io_a_T = bits(adda_reg, 47, 32) @[dut.scala 84:26]
    stage3.io.a <= _stage3_io_a_T @[dut.scala 84:15]
    node _stage3_io_b_T = bits(addb_reg, 47, 32) @[dut.scala 85:26]
    stage3.io.b <= _stage3_io_b_T @[dut.scala 85:15]
    stage3.io.cin <= stage2_cout @[dut.scala 86:17]
    reg stage3_sum : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[2] : @[Reg.scala 36:18]
      stage3_sum <= stage3.io.sum @[Reg.scala 36:22]
    reg stage3_cout : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[2] : @[Reg.scala 36:18]
      stage3_cout <= stage3.io.cout @[Reg.scala 36:22]
    inst stage4 of RCA16_3 @[dut.scala 90:22]
    stage4.clock <= clock
    stage4.reset <= reset
    node _stage4_io_a_T = bits(adda_reg, 63, 48) @[dut.scala 91:26]
    stage4.io.a <= _stage4_io_a_T @[dut.scala 91:15]
    node _stage4_io_b_T = bits(addb_reg, 63, 48) @[dut.scala 92:26]
    stage4.io.b <= _stage4_io_b_T @[dut.scala 92:15]
    stage4.io.cin <= stage3_cout @[dut.scala 93:17]
    reg stage4_sum : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[3] : @[Reg.scala 36:18]
      stage4_sum <= stage4.io.sum @[Reg.scala 36:22]
    reg final_carry : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when en_pipeline[3] : @[Reg.scala 36:18]
      final_carry <= stage4.io.cout @[Reg.scala 36:22]
    reg result_reg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 98:27]
    node result_reg_lo = cat(stage2_sum, stage1_sum) @[Cat.scala 33:92]
    node result_reg_hi_hi = cat(final_carry, stage4_sum) @[Cat.scala 33:92]
    node result_reg_hi = cat(result_reg_hi_hi, stage3_sum) @[Cat.scala 33:92]
    node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
    result_reg <= _result_reg_T @[dut.scala 99:14]
    io.result <= result_reg @[dut.scala 100:13]
    io.o_en <= en_pipeline[3] @[dut.scala 103:11]

