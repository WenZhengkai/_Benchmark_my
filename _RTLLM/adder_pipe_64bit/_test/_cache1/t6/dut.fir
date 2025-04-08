circuit dut :
  module FullAdder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder @[dut.scala 14:27]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 15:27]
    FullAdder.io.a <= _T @[dut.scala 15:20]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 16:27]
    FullAdder.io.b <= _T_1 @[dut.scala 16:20]
    FullAdder.io.cin <= io.cin @[dut.scala 17:22]
    node _T_2 = shl(FullAdder.io.sum, 0) @[dut.scala 18:28]
    node _T_3 = or(UInt<16>("h0"), _T_2) @[dut.scala 18:8]
    inst FullAdder_1 of FullAdder_1 @[dut.scala 14:27]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_4 = bits(io.a, 1, 1) @[dut.scala 15:27]
    FullAdder_1.io.a <= _T_4 @[dut.scala 15:20]
    node _T_5 = bits(io.b, 1, 1) @[dut.scala 16:27]
    FullAdder_1.io.b <= _T_5 @[dut.scala 16:20]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 17:22]
    node _T_6 = shl(FullAdder_1.io.sum, 1) @[dut.scala 18:28]
    node _T_7 = or(_T_3, _T_6) @[dut.scala 18:8]
    inst FullAdder_2 of FullAdder_2 @[dut.scala 14:27]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_8 = bits(io.a, 2, 2) @[dut.scala 15:27]
    FullAdder_2.io.a <= _T_8 @[dut.scala 15:20]
    node _T_9 = bits(io.b, 2, 2) @[dut.scala 16:27]
    FullAdder_2.io.b <= _T_9 @[dut.scala 16:20]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 17:22]
    node _T_10 = shl(FullAdder_2.io.sum, 2) @[dut.scala 18:28]
    node _T_11 = or(_T_7, _T_10) @[dut.scala 18:8]
    inst FullAdder_3 of FullAdder_3 @[dut.scala 14:27]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_12 = bits(io.a, 3, 3) @[dut.scala 15:27]
    FullAdder_3.io.a <= _T_12 @[dut.scala 15:20]
    node _T_13 = bits(io.b, 3, 3) @[dut.scala 16:27]
    FullAdder_3.io.b <= _T_13 @[dut.scala 16:20]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 17:22]
    node _T_14 = shl(FullAdder_3.io.sum, 3) @[dut.scala 18:28]
    node _T_15 = or(_T_11, _T_14) @[dut.scala 18:8]
    inst FullAdder_4 of FullAdder_4 @[dut.scala 14:27]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_16 = bits(io.a, 4, 4) @[dut.scala 15:27]
    FullAdder_4.io.a <= _T_16 @[dut.scala 15:20]
    node _T_17 = bits(io.b, 4, 4) @[dut.scala 16:27]
    FullAdder_4.io.b <= _T_17 @[dut.scala 16:20]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 17:22]
    node _T_18 = shl(FullAdder_4.io.sum, 4) @[dut.scala 18:28]
    node _T_19 = or(_T_15, _T_18) @[dut.scala 18:8]
    inst FullAdder_5 of FullAdder_5 @[dut.scala 14:27]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_20 = bits(io.a, 5, 5) @[dut.scala 15:27]
    FullAdder_5.io.a <= _T_20 @[dut.scala 15:20]
    node _T_21 = bits(io.b, 5, 5) @[dut.scala 16:27]
    FullAdder_5.io.b <= _T_21 @[dut.scala 16:20]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 17:22]
    node _T_22 = shl(FullAdder_5.io.sum, 5) @[dut.scala 18:28]
    node _T_23 = or(_T_19, _T_22) @[dut.scala 18:8]
    inst FullAdder_6 of FullAdder_6 @[dut.scala 14:27]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_24 = bits(io.a, 6, 6) @[dut.scala 15:27]
    FullAdder_6.io.a <= _T_24 @[dut.scala 15:20]
    node _T_25 = bits(io.b, 6, 6) @[dut.scala 16:27]
    FullAdder_6.io.b <= _T_25 @[dut.scala 16:20]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 17:22]
    node _T_26 = shl(FullAdder_6.io.sum, 6) @[dut.scala 18:28]
    node _T_27 = or(_T_23, _T_26) @[dut.scala 18:8]
    inst FullAdder_7 of FullAdder_7 @[dut.scala 14:27]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_28 = bits(io.a, 7, 7) @[dut.scala 15:27]
    FullAdder_7.io.a <= _T_28 @[dut.scala 15:20]
    node _T_29 = bits(io.b, 7, 7) @[dut.scala 16:27]
    FullAdder_7.io.b <= _T_29 @[dut.scala 16:20]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 17:22]
    node _T_30 = shl(FullAdder_7.io.sum, 7) @[dut.scala 18:28]
    node _T_31 = or(_T_27, _T_30) @[dut.scala 18:8]
    inst FullAdder_8 of FullAdder_8 @[dut.scala 14:27]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_32 = bits(io.a, 8, 8) @[dut.scala 15:27]
    FullAdder_8.io.a <= _T_32 @[dut.scala 15:20]
    node _T_33 = bits(io.b, 8, 8) @[dut.scala 16:27]
    FullAdder_8.io.b <= _T_33 @[dut.scala 16:20]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 17:22]
    node _T_34 = shl(FullAdder_8.io.sum, 8) @[dut.scala 18:28]
    node _T_35 = or(_T_31, _T_34) @[dut.scala 18:8]
    inst FullAdder_9 of FullAdder_9 @[dut.scala 14:27]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_36 = bits(io.a, 9, 9) @[dut.scala 15:27]
    FullAdder_9.io.a <= _T_36 @[dut.scala 15:20]
    node _T_37 = bits(io.b, 9, 9) @[dut.scala 16:27]
    FullAdder_9.io.b <= _T_37 @[dut.scala 16:20]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 17:22]
    node _T_38 = shl(FullAdder_9.io.sum, 9) @[dut.scala 18:28]
    node _T_39 = or(_T_35, _T_38) @[dut.scala 18:8]
    inst FullAdder_10 of FullAdder_10 @[dut.scala 14:27]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_40 = bits(io.a, 10, 10) @[dut.scala 15:27]
    FullAdder_10.io.a <= _T_40 @[dut.scala 15:20]
    node _T_41 = bits(io.b, 10, 10) @[dut.scala 16:27]
    FullAdder_10.io.b <= _T_41 @[dut.scala 16:20]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 17:22]
    node _T_42 = shl(FullAdder_10.io.sum, 10) @[dut.scala 18:28]
    node _T_43 = or(_T_39, _T_42) @[dut.scala 18:8]
    inst FullAdder_11 of FullAdder_11 @[dut.scala 14:27]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_44 = bits(io.a, 11, 11) @[dut.scala 15:27]
    FullAdder_11.io.a <= _T_44 @[dut.scala 15:20]
    node _T_45 = bits(io.b, 11, 11) @[dut.scala 16:27]
    FullAdder_11.io.b <= _T_45 @[dut.scala 16:20]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 17:22]
    node _T_46 = shl(FullAdder_11.io.sum, 11) @[dut.scala 18:28]
    node _T_47 = or(_T_43, _T_46) @[dut.scala 18:8]
    inst FullAdder_12 of FullAdder_12 @[dut.scala 14:27]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_48 = bits(io.a, 12, 12) @[dut.scala 15:27]
    FullAdder_12.io.a <= _T_48 @[dut.scala 15:20]
    node _T_49 = bits(io.b, 12, 12) @[dut.scala 16:27]
    FullAdder_12.io.b <= _T_49 @[dut.scala 16:20]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 17:22]
    node _T_50 = shl(FullAdder_12.io.sum, 12) @[dut.scala 18:28]
    node _T_51 = or(_T_47, _T_50) @[dut.scala 18:8]
    inst FullAdder_13 of FullAdder_13 @[dut.scala 14:27]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_52 = bits(io.a, 13, 13) @[dut.scala 15:27]
    FullAdder_13.io.a <= _T_52 @[dut.scala 15:20]
    node _T_53 = bits(io.b, 13, 13) @[dut.scala 16:27]
    FullAdder_13.io.b <= _T_53 @[dut.scala 16:20]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 17:22]
    node _T_54 = shl(FullAdder_13.io.sum, 13) @[dut.scala 18:28]
    node _T_55 = or(_T_51, _T_54) @[dut.scala 18:8]
    inst FullAdder_14 of FullAdder_14 @[dut.scala 14:27]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_56 = bits(io.a, 14, 14) @[dut.scala 15:27]
    FullAdder_14.io.a <= _T_56 @[dut.scala 15:20]
    node _T_57 = bits(io.b, 14, 14) @[dut.scala 16:27]
    FullAdder_14.io.b <= _T_57 @[dut.scala 16:20]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 17:22]
    node _T_58 = shl(FullAdder_14.io.sum, 14) @[dut.scala 18:28]
    node _T_59 = or(_T_55, _T_58) @[dut.scala 18:8]
    inst FullAdder_15 of FullAdder_15 @[dut.scala 14:27]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_60 = bits(io.a, 15, 15) @[dut.scala 15:27]
    FullAdder_15.io.a <= _T_60 @[dut.scala 15:20]
    node _T_61 = bits(io.b, 15, 15) @[dut.scala 16:27]
    FullAdder_15.io.b <= _T_61 @[dut.scala 16:20]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 17:22]
    node _T_62 = shl(FullAdder_15.io.sum, 15) @[dut.scala 18:28]
    node sum = or(_T_59, _T_62) @[dut.scala 18:8]
    io.sum <= sum @[dut.scala 21:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 22:11]

  module FullAdder_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_20 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_21 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_22 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_23 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_24 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_25 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_26 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_27 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_28 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_29 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_30 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_31 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_16 @[dut.scala 14:27]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 15:27]
    FullAdder.io.a <= _T @[dut.scala 15:20]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 16:27]
    FullAdder.io.b <= _T_1 @[dut.scala 16:20]
    FullAdder.io.cin <= io.cin @[dut.scala 17:22]
    node _T_2 = shl(FullAdder.io.sum, 0) @[dut.scala 18:28]
    node _T_3 = or(UInt<16>("h0"), _T_2) @[dut.scala 18:8]
    inst FullAdder_1 of FullAdder_17 @[dut.scala 14:27]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_4 = bits(io.a, 1, 1) @[dut.scala 15:27]
    FullAdder_1.io.a <= _T_4 @[dut.scala 15:20]
    node _T_5 = bits(io.b, 1, 1) @[dut.scala 16:27]
    FullAdder_1.io.b <= _T_5 @[dut.scala 16:20]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 17:22]
    node _T_6 = shl(FullAdder_1.io.sum, 1) @[dut.scala 18:28]
    node _T_7 = or(_T_3, _T_6) @[dut.scala 18:8]
    inst FullAdder_2 of FullAdder_18 @[dut.scala 14:27]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_8 = bits(io.a, 2, 2) @[dut.scala 15:27]
    FullAdder_2.io.a <= _T_8 @[dut.scala 15:20]
    node _T_9 = bits(io.b, 2, 2) @[dut.scala 16:27]
    FullAdder_2.io.b <= _T_9 @[dut.scala 16:20]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 17:22]
    node _T_10 = shl(FullAdder_2.io.sum, 2) @[dut.scala 18:28]
    node _T_11 = or(_T_7, _T_10) @[dut.scala 18:8]
    inst FullAdder_3 of FullAdder_19 @[dut.scala 14:27]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_12 = bits(io.a, 3, 3) @[dut.scala 15:27]
    FullAdder_3.io.a <= _T_12 @[dut.scala 15:20]
    node _T_13 = bits(io.b, 3, 3) @[dut.scala 16:27]
    FullAdder_3.io.b <= _T_13 @[dut.scala 16:20]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 17:22]
    node _T_14 = shl(FullAdder_3.io.sum, 3) @[dut.scala 18:28]
    node _T_15 = or(_T_11, _T_14) @[dut.scala 18:8]
    inst FullAdder_4 of FullAdder_20 @[dut.scala 14:27]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_16 = bits(io.a, 4, 4) @[dut.scala 15:27]
    FullAdder_4.io.a <= _T_16 @[dut.scala 15:20]
    node _T_17 = bits(io.b, 4, 4) @[dut.scala 16:27]
    FullAdder_4.io.b <= _T_17 @[dut.scala 16:20]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 17:22]
    node _T_18 = shl(FullAdder_4.io.sum, 4) @[dut.scala 18:28]
    node _T_19 = or(_T_15, _T_18) @[dut.scala 18:8]
    inst FullAdder_5 of FullAdder_21 @[dut.scala 14:27]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_20 = bits(io.a, 5, 5) @[dut.scala 15:27]
    FullAdder_5.io.a <= _T_20 @[dut.scala 15:20]
    node _T_21 = bits(io.b, 5, 5) @[dut.scala 16:27]
    FullAdder_5.io.b <= _T_21 @[dut.scala 16:20]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 17:22]
    node _T_22 = shl(FullAdder_5.io.sum, 5) @[dut.scala 18:28]
    node _T_23 = or(_T_19, _T_22) @[dut.scala 18:8]
    inst FullAdder_6 of FullAdder_22 @[dut.scala 14:27]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_24 = bits(io.a, 6, 6) @[dut.scala 15:27]
    FullAdder_6.io.a <= _T_24 @[dut.scala 15:20]
    node _T_25 = bits(io.b, 6, 6) @[dut.scala 16:27]
    FullAdder_6.io.b <= _T_25 @[dut.scala 16:20]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 17:22]
    node _T_26 = shl(FullAdder_6.io.sum, 6) @[dut.scala 18:28]
    node _T_27 = or(_T_23, _T_26) @[dut.scala 18:8]
    inst FullAdder_7 of FullAdder_23 @[dut.scala 14:27]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_28 = bits(io.a, 7, 7) @[dut.scala 15:27]
    FullAdder_7.io.a <= _T_28 @[dut.scala 15:20]
    node _T_29 = bits(io.b, 7, 7) @[dut.scala 16:27]
    FullAdder_7.io.b <= _T_29 @[dut.scala 16:20]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 17:22]
    node _T_30 = shl(FullAdder_7.io.sum, 7) @[dut.scala 18:28]
    node _T_31 = or(_T_27, _T_30) @[dut.scala 18:8]
    inst FullAdder_8 of FullAdder_24 @[dut.scala 14:27]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_32 = bits(io.a, 8, 8) @[dut.scala 15:27]
    FullAdder_8.io.a <= _T_32 @[dut.scala 15:20]
    node _T_33 = bits(io.b, 8, 8) @[dut.scala 16:27]
    FullAdder_8.io.b <= _T_33 @[dut.scala 16:20]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 17:22]
    node _T_34 = shl(FullAdder_8.io.sum, 8) @[dut.scala 18:28]
    node _T_35 = or(_T_31, _T_34) @[dut.scala 18:8]
    inst FullAdder_9 of FullAdder_25 @[dut.scala 14:27]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_36 = bits(io.a, 9, 9) @[dut.scala 15:27]
    FullAdder_9.io.a <= _T_36 @[dut.scala 15:20]
    node _T_37 = bits(io.b, 9, 9) @[dut.scala 16:27]
    FullAdder_9.io.b <= _T_37 @[dut.scala 16:20]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 17:22]
    node _T_38 = shl(FullAdder_9.io.sum, 9) @[dut.scala 18:28]
    node _T_39 = or(_T_35, _T_38) @[dut.scala 18:8]
    inst FullAdder_10 of FullAdder_26 @[dut.scala 14:27]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_40 = bits(io.a, 10, 10) @[dut.scala 15:27]
    FullAdder_10.io.a <= _T_40 @[dut.scala 15:20]
    node _T_41 = bits(io.b, 10, 10) @[dut.scala 16:27]
    FullAdder_10.io.b <= _T_41 @[dut.scala 16:20]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 17:22]
    node _T_42 = shl(FullAdder_10.io.sum, 10) @[dut.scala 18:28]
    node _T_43 = or(_T_39, _T_42) @[dut.scala 18:8]
    inst FullAdder_11 of FullAdder_27 @[dut.scala 14:27]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_44 = bits(io.a, 11, 11) @[dut.scala 15:27]
    FullAdder_11.io.a <= _T_44 @[dut.scala 15:20]
    node _T_45 = bits(io.b, 11, 11) @[dut.scala 16:27]
    FullAdder_11.io.b <= _T_45 @[dut.scala 16:20]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 17:22]
    node _T_46 = shl(FullAdder_11.io.sum, 11) @[dut.scala 18:28]
    node _T_47 = or(_T_43, _T_46) @[dut.scala 18:8]
    inst FullAdder_12 of FullAdder_28 @[dut.scala 14:27]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_48 = bits(io.a, 12, 12) @[dut.scala 15:27]
    FullAdder_12.io.a <= _T_48 @[dut.scala 15:20]
    node _T_49 = bits(io.b, 12, 12) @[dut.scala 16:27]
    FullAdder_12.io.b <= _T_49 @[dut.scala 16:20]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 17:22]
    node _T_50 = shl(FullAdder_12.io.sum, 12) @[dut.scala 18:28]
    node _T_51 = or(_T_47, _T_50) @[dut.scala 18:8]
    inst FullAdder_13 of FullAdder_29 @[dut.scala 14:27]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_52 = bits(io.a, 13, 13) @[dut.scala 15:27]
    FullAdder_13.io.a <= _T_52 @[dut.scala 15:20]
    node _T_53 = bits(io.b, 13, 13) @[dut.scala 16:27]
    FullAdder_13.io.b <= _T_53 @[dut.scala 16:20]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 17:22]
    node _T_54 = shl(FullAdder_13.io.sum, 13) @[dut.scala 18:28]
    node _T_55 = or(_T_51, _T_54) @[dut.scala 18:8]
    inst FullAdder_14 of FullAdder_30 @[dut.scala 14:27]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_56 = bits(io.a, 14, 14) @[dut.scala 15:27]
    FullAdder_14.io.a <= _T_56 @[dut.scala 15:20]
    node _T_57 = bits(io.b, 14, 14) @[dut.scala 16:27]
    FullAdder_14.io.b <= _T_57 @[dut.scala 16:20]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 17:22]
    node _T_58 = shl(FullAdder_14.io.sum, 14) @[dut.scala 18:28]
    node _T_59 = or(_T_55, _T_58) @[dut.scala 18:8]
    inst FullAdder_15 of FullAdder_31 @[dut.scala 14:27]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_60 = bits(io.a, 15, 15) @[dut.scala 15:27]
    FullAdder_15.io.a <= _T_60 @[dut.scala 15:20]
    node _T_61 = bits(io.b, 15, 15) @[dut.scala 16:27]
    FullAdder_15.io.b <= _T_61 @[dut.scala 16:20]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 17:22]
    node _T_62 = shl(FullAdder_15.io.sum, 15) @[dut.scala 18:28]
    node sum = or(_T_59, _T_62) @[dut.scala 18:8]
    io.sum <= sum @[dut.scala 21:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 22:11]

  module FullAdder_32 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_33 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_34 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_35 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_36 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_37 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_38 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_39 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_40 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_41 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_42 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_43 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_44 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_45 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_46 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_47 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_32 @[dut.scala 14:27]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 15:27]
    FullAdder.io.a <= _T @[dut.scala 15:20]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 16:27]
    FullAdder.io.b <= _T_1 @[dut.scala 16:20]
    FullAdder.io.cin <= io.cin @[dut.scala 17:22]
    node _T_2 = shl(FullAdder.io.sum, 0) @[dut.scala 18:28]
    node _T_3 = or(UInt<16>("h0"), _T_2) @[dut.scala 18:8]
    inst FullAdder_1 of FullAdder_33 @[dut.scala 14:27]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_4 = bits(io.a, 1, 1) @[dut.scala 15:27]
    FullAdder_1.io.a <= _T_4 @[dut.scala 15:20]
    node _T_5 = bits(io.b, 1, 1) @[dut.scala 16:27]
    FullAdder_1.io.b <= _T_5 @[dut.scala 16:20]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 17:22]
    node _T_6 = shl(FullAdder_1.io.sum, 1) @[dut.scala 18:28]
    node _T_7 = or(_T_3, _T_6) @[dut.scala 18:8]
    inst FullAdder_2 of FullAdder_34 @[dut.scala 14:27]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_8 = bits(io.a, 2, 2) @[dut.scala 15:27]
    FullAdder_2.io.a <= _T_8 @[dut.scala 15:20]
    node _T_9 = bits(io.b, 2, 2) @[dut.scala 16:27]
    FullAdder_2.io.b <= _T_9 @[dut.scala 16:20]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 17:22]
    node _T_10 = shl(FullAdder_2.io.sum, 2) @[dut.scala 18:28]
    node _T_11 = or(_T_7, _T_10) @[dut.scala 18:8]
    inst FullAdder_3 of FullAdder_35 @[dut.scala 14:27]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_12 = bits(io.a, 3, 3) @[dut.scala 15:27]
    FullAdder_3.io.a <= _T_12 @[dut.scala 15:20]
    node _T_13 = bits(io.b, 3, 3) @[dut.scala 16:27]
    FullAdder_3.io.b <= _T_13 @[dut.scala 16:20]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 17:22]
    node _T_14 = shl(FullAdder_3.io.sum, 3) @[dut.scala 18:28]
    node _T_15 = or(_T_11, _T_14) @[dut.scala 18:8]
    inst FullAdder_4 of FullAdder_36 @[dut.scala 14:27]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_16 = bits(io.a, 4, 4) @[dut.scala 15:27]
    FullAdder_4.io.a <= _T_16 @[dut.scala 15:20]
    node _T_17 = bits(io.b, 4, 4) @[dut.scala 16:27]
    FullAdder_4.io.b <= _T_17 @[dut.scala 16:20]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 17:22]
    node _T_18 = shl(FullAdder_4.io.sum, 4) @[dut.scala 18:28]
    node _T_19 = or(_T_15, _T_18) @[dut.scala 18:8]
    inst FullAdder_5 of FullAdder_37 @[dut.scala 14:27]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_20 = bits(io.a, 5, 5) @[dut.scala 15:27]
    FullAdder_5.io.a <= _T_20 @[dut.scala 15:20]
    node _T_21 = bits(io.b, 5, 5) @[dut.scala 16:27]
    FullAdder_5.io.b <= _T_21 @[dut.scala 16:20]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 17:22]
    node _T_22 = shl(FullAdder_5.io.sum, 5) @[dut.scala 18:28]
    node _T_23 = or(_T_19, _T_22) @[dut.scala 18:8]
    inst FullAdder_6 of FullAdder_38 @[dut.scala 14:27]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_24 = bits(io.a, 6, 6) @[dut.scala 15:27]
    FullAdder_6.io.a <= _T_24 @[dut.scala 15:20]
    node _T_25 = bits(io.b, 6, 6) @[dut.scala 16:27]
    FullAdder_6.io.b <= _T_25 @[dut.scala 16:20]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 17:22]
    node _T_26 = shl(FullAdder_6.io.sum, 6) @[dut.scala 18:28]
    node _T_27 = or(_T_23, _T_26) @[dut.scala 18:8]
    inst FullAdder_7 of FullAdder_39 @[dut.scala 14:27]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_28 = bits(io.a, 7, 7) @[dut.scala 15:27]
    FullAdder_7.io.a <= _T_28 @[dut.scala 15:20]
    node _T_29 = bits(io.b, 7, 7) @[dut.scala 16:27]
    FullAdder_7.io.b <= _T_29 @[dut.scala 16:20]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 17:22]
    node _T_30 = shl(FullAdder_7.io.sum, 7) @[dut.scala 18:28]
    node _T_31 = or(_T_27, _T_30) @[dut.scala 18:8]
    inst FullAdder_8 of FullAdder_40 @[dut.scala 14:27]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_32 = bits(io.a, 8, 8) @[dut.scala 15:27]
    FullAdder_8.io.a <= _T_32 @[dut.scala 15:20]
    node _T_33 = bits(io.b, 8, 8) @[dut.scala 16:27]
    FullAdder_8.io.b <= _T_33 @[dut.scala 16:20]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 17:22]
    node _T_34 = shl(FullAdder_8.io.sum, 8) @[dut.scala 18:28]
    node _T_35 = or(_T_31, _T_34) @[dut.scala 18:8]
    inst FullAdder_9 of FullAdder_41 @[dut.scala 14:27]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_36 = bits(io.a, 9, 9) @[dut.scala 15:27]
    FullAdder_9.io.a <= _T_36 @[dut.scala 15:20]
    node _T_37 = bits(io.b, 9, 9) @[dut.scala 16:27]
    FullAdder_9.io.b <= _T_37 @[dut.scala 16:20]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 17:22]
    node _T_38 = shl(FullAdder_9.io.sum, 9) @[dut.scala 18:28]
    node _T_39 = or(_T_35, _T_38) @[dut.scala 18:8]
    inst FullAdder_10 of FullAdder_42 @[dut.scala 14:27]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_40 = bits(io.a, 10, 10) @[dut.scala 15:27]
    FullAdder_10.io.a <= _T_40 @[dut.scala 15:20]
    node _T_41 = bits(io.b, 10, 10) @[dut.scala 16:27]
    FullAdder_10.io.b <= _T_41 @[dut.scala 16:20]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 17:22]
    node _T_42 = shl(FullAdder_10.io.sum, 10) @[dut.scala 18:28]
    node _T_43 = or(_T_39, _T_42) @[dut.scala 18:8]
    inst FullAdder_11 of FullAdder_43 @[dut.scala 14:27]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_44 = bits(io.a, 11, 11) @[dut.scala 15:27]
    FullAdder_11.io.a <= _T_44 @[dut.scala 15:20]
    node _T_45 = bits(io.b, 11, 11) @[dut.scala 16:27]
    FullAdder_11.io.b <= _T_45 @[dut.scala 16:20]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 17:22]
    node _T_46 = shl(FullAdder_11.io.sum, 11) @[dut.scala 18:28]
    node _T_47 = or(_T_43, _T_46) @[dut.scala 18:8]
    inst FullAdder_12 of FullAdder_44 @[dut.scala 14:27]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_48 = bits(io.a, 12, 12) @[dut.scala 15:27]
    FullAdder_12.io.a <= _T_48 @[dut.scala 15:20]
    node _T_49 = bits(io.b, 12, 12) @[dut.scala 16:27]
    FullAdder_12.io.b <= _T_49 @[dut.scala 16:20]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 17:22]
    node _T_50 = shl(FullAdder_12.io.sum, 12) @[dut.scala 18:28]
    node _T_51 = or(_T_47, _T_50) @[dut.scala 18:8]
    inst FullAdder_13 of FullAdder_45 @[dut.scala 14:27]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_52 = bits(io.a, 13, 13) @[dut.scala 15:27]
    FullAdder_13.io.a <= _T_52 @[dut.scala 15:20]
    node _T_53 = bits(io.b, 13, 13) @[dut.scala 16:27]
    FullAdder_13.io.b <= _T_53 @[dut.scala 16:20]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 17:22]
    node _T_54 = shl(FullAdder_13.io.sum, 13) @[dut.scala 18:28]
    node _T_55 = or(_T_51, _T_54) @[dut.scala 18:8]
    inst FullAdder_14 of FullAdder_46 @[dut.scala 14:27]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_56 = bits(io.a, 14, 14) @[dut.scala 15:27]
    FullAdder_14.io.a <= _T_56 @[dut.scala 15:20]
    node _T_57 = bits(io.b, 14, 14) @[dut.scala 16:27]
    FullAdder_14.io.b <= _T_57 @[dut.scala 16:20]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 17:22]
    node _T_58 = shl(FullAdder_14.io.sum, 14) @[dut.scala 18:28]
    node _T_59 = or(_T_55, _T_58) @[dut.scala 18:8]
    inst FullAdder_15 of FullAdder_47 @[dut.scala 14:27]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_60 = bits(io.a, 15, 15) @[dut.scala 15:27]
    FullAdder_15.io.a <= _T_60 @[dut.scala 15:20]
    node _T_61 = bits(io.b, 15, 15) @[dut.scala 16:27]
    FullAdder_15.io.b <= _T_61 @[dut.scala 16:20]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 17:22]
    node _T_62 = shl(FullAdder_15.io.sum, 15) @[dut.scala 18:28]
    node sum = or(_T_59, _T_62) @[dut.scala 18:8]
    io.sum <= sum @[dut.scala 21:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 22:11]

  module FullAdder_48 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_49 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_50 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_51 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_52 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_53 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_54 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_55 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_56 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_57 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_58 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_59 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_60 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_61 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_62 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module FullAdder_63 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<1>, flip b : UInt<1>, flip cin : UInt<1>, sum : UInt<1>, cout : UInt<1>}

    node _io_sum_T = xor(io.a, io.b) @[dut.scala 34:18]
    node _io_sum_T_1 = xor(_io_sum_T, io.cin) @[dut.scala 34:25]
    io.sum <= _io_sum_T_1 @[dut.scala 34:10]
    node _io_cout_T = and(io.a, io.b) @[dut.scala 35:20]
    node _io_cout_T_1 = and(io.b, io.cin) @[dut.scala 35:36]
    node _io_cout_T_2 = or(_io_cout_T, _io_cout_T_1) @[dut.scala 35:28]
    node _io_cout_T_3 = and(io.a, io.cin) @[dut.scala 35:54]
    node _io_cout_T_4 = or(_io_cout_T_2, _io_cout_T_3) @[dut.scala 35:46]
    io.cout <= _io_cout_T_4 @[dut.scala 35:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    inst FullAdder of FullAdder_48 @[dut.scala 14:27]
    FullAdder.clock <= clock
    FullAdder.reset <= reset
    node _T = bits(io.a, 0, 0) @[dut.scala 15:27]
    FullAdder.io.a <= _T @[dut.scala 15:20]
    node _T_1 = bits(io.b, 0, 0) @[dut.scala 16:27]
    FullAdder.io.b <= _T_1 @[dut.scala 16:20]
    FullAdder.io.cin <= io.cin @[dut.scala 17:22]
    node _T_2 = shl(FullAdder.io.sum, 0) @[dut.scala 18:28]
    node _T_3 = or(UInt<16>("h0"), _T_2) @[dut.scala 18:8]
    inst FullAdder_1 of FullAdder_49 @[dut.scala 14:27]
    FullAdder_1.clock <= clock
    FullAdder_1.reset <= reset
    node _T_4 = bits(io.a, 1, 1) @[dut.scala 15:27]
    FullAdder_1.io.a <= _T_4 @[dut.scala 15:20]
    node _T_5 = bits(io.b, 1, 1) @[dut.scala 16:27]
    FullAdder_1.io.b <= _T_5 @[dut.scala 16:20]
    FullAdder_1.io.cin <= FullAdder.io.cout @[dut.scala 17:22]
    node _T_6 = shl(FullAdder_1.io.sum, 1) @[dut.scala 18:28]
    node _T_7 = or(_T_3, _T_6) @[dut.scala 18:8]
    inst FullAdder_2 of FullAdder_50 @[dut.scala 14:27]
    FullAdder_2.clock <= clock
    FullAdder_2.reset <= reset
    node _T_8 = bits(io.a, 2, 2) @[dut.scala 15:27]
    FullAdder_2.io.a <= _T_8 @[dut.scala 15:20]
    node _T_9 = bits(io.b, 2, 2) @[dut.scala 16:27]
    FullAdder_2.io.b <= _T_9 @[dut.scala 16:20]
    FullAdder_2.io.cin <= FullAdder_1.io.cout @[dut.scala 17:22]
    node _T_10 = shl(FullAdder_2.io.sum, 2) @[dut.scala 18:28]
    node _T_11 = or(_T_7, _T_10) @[dut.scala 18:8]
    inst FullAdder_3 of FullAdder_51 @[dut.scala 14:27]
    FullAdder_3.clock <= clock
    FullAdder_3.reset <= reset
    node _T_12 = bits(io.a, 3, 3) @[dut.scala 15:27]
    FullAdder_3.io.a <= _T_12 @[dut.scala 15:20]
    node _T_13 = bits(io.b, 3, 3) @[dut.scala 16:27]
    FullAdder_3.io.b <= _T_13 @[dut.scala 16:20]
    FullAdder_3.io.cin <= FullAdder_2.io.cout @[dut.scala 17:22]
    node _T_14 = shl(FullAdder_3.io.sum, 3) @[dut.scala 18:28]
    node _T_15 = or(_T_11, _T_14) @[dut.scala 18:8]
    inst FullAdder_4 of FullAdder_52 @[dut.scala 14:27]
    FullAdder_4.clock <= clock
    FullAdder_4.reset <= reset
    node _T_16 = bits(io.a, 4, 4) @[dut.scala 15:27]
    FullAdder_4.io.a <= _T_16 @[dut.scala 15:20]
    node _T_17 = bits(io.b, 4, 4) @[dut.scala 16:27]
    FullAdder_4.io.b <= _T_17 @[dut.scala 16:20]
    FullAdder_4.io.cin <= FullAdder_3.io.cout @[dut.scala 17:22]
    node _T_18 = shl(FullAdder_4.io.sum, 4) @[dut.scala 18:28]
    node _T_19 = or(_T_15, _T_18) @[dut.scala 18:8]
    inst FullAdder_5 of FullAdder_53 @[dut.scala 14:27]
    FullAdder_5.clock <= clock
    FullAdder_5.reset <= reset
    node _T_20 = bits(io.a, 5, 5) @[dut.scala 15:27]
    FullAdder_5.io.a <= _T_20 @[dut.scala 15:20]
    node _T_21 = bits(io.b, 5, 5) @[dut.scala 16:27]
    FullAdder_5.io.b <= _T_21 @[dut.scala 16:20]
    FullAdder_5.io.cin <= FullAdder_4.io.cout @[dut.scala 17:22]
    node _T_22 = shl(FullAdder_5.io.sum, 5) @[dut.scala 18:28]
    node _T_23 = or(_T_19, _T_22) @[dut.scala 18:8]
    inst FullAdder_6 of FullAdder_54 @[dut.scala 14:27]
    FullAdder_6.clock <= clock
    FullAdder_6.reset <= reset
    node _T_24 = bits(io.a, 6, 6) @[dut.scala 15:27]
    FullAdder_6.io.a <= _T_24 @[dut.scala 15:20]
    node _T_25 = bits(io.b, 6, 6) @[dut.scala 16:27]
    FullAdder_6.io.b <= _T_25 @[dut.scala 16:20]
    FullAdder_6.io.cin <= FullAdder_5.io.cout @[dut.scala 17:22]
    node _T_26 = shl(FullAdder_6.io.sum, 6) @[dut.scala 18:28]
    node _T_27 = or(_T_23, _T_26) @[dut.scala 18:8]
    inst FullAdder_7 of FullAdder_55 @[dut.scala 14:27]
    FullAdder_7.clock <= clock
    FullAdder_7.reset <= reset
    node _T_28 = bits(io.a, 7, 7) @[dut.scala 15:27]
    FullAdder_7.io.a <= _T_28 @[dut.scala 15:20]
    node _T_29 = bits(io.b, 7, 7) @[dut.scala 16:27]
    FullAdder_7.io.b <= _T_29 @[dut.scala 16:20]
    FullAdder_7.io.cin <= FullAdder_6.io.cout @[dut.scala 17:22]
    node _T_30 = shl(FullAdder_7.io.sum, 7) @[dut.scala 18:28]
    node _T_31 = or(_T_27, _T_30) @[dut.scala 18:8]
    inst FullAdder_8 of FullAdder_56 @[dut.scala 14:27]
    FullAdder_8.clock <= clock
    FullAdder_8.reset <= reset
    node _T_32 = bits(io.a, 8, 8) @[dut.scala 15:27]
    FullAdder_8.io.a <= _T_32 @[dut.scala 15:20]
    node _T_33 = bits(io.b, 8, 8) @[dut.scala 16:27]
    FullAdder_8.io.b <= _T_33 @[dut.scala 16:20]
    FullAdder_8.io.cin <= FullAdder_7.io.cout @[dut.scala 17:22]
    node _T_34 = shl(FullAdder_8.io.sum, 8) @[dut.scala 18:28]
    node _T_35 = or(_T_31, _T_34) @[dut.scala 18:8]
    inst FullAdder_9 of FullAdder_57 @[dut.scala 14:27]
    FullAdder_9.clock <= clock
    FullAdder_9.reset <= reset
    node _T_36 = bits(io.a, 9, 9) @[dut.scala 15:27]
    FullAdder_9.io.a <= _T_36 @[dut.scala 15:20]
    node _T_37 = bits(io.b, 9, 9) @[dut.scala 16:27]
    FullAdder_9.io.b <= _T_37 @[dut.scala 16:20]
    FullAdder_9.io.cin <= FullAdder_8.io.cout @[dut.scala 17:22]
    node _T_38 = shl(FullAdder_9.io.sum, 9) @[dut.scala 18:28]
    node _T_39 = or(_T_35, _T_38) @[dut.scala 18:8]
    inst FullAdder_10 of FullAdder_58 @[dut.scala 14:27]
    FullAdder_10.clock <= clock
    FullAdder_10.reset <= reset
    node _T_40 = bits(io.a, 10, 10) @[dut.scala 15:27]
    FullAdder_10.io.a <= _T_40 @[dut.scala 15:20]
    node _T_41 = bits(io.b, 10, 10) @[dut.scala 16:27]
    FullAdder_10.io.b <= _T_41 @[dut.scala 16:20]
    FullAdder_10.io.cin <= FullAdder_9.io.cout @[dut.scala 17:22]
    node _T_42 = shl(FullAdder_10.io.sum, 10) @[dut.scala 18:28]
    node _T_43 = or(_T_39, _T_42) @[dut.scala 18:8]
    inst FullAdder_11 of FullAdder_59 @[dut.scala 14:27]
    FullAdder_11.clock <= clock
    FullAdder_11.reset <= reset
    node _T_44 = bits(io.a, 11, 11) @[dut.scala 15:27]
    FullAdder_11.io.a <= _T_44 @[dut.scala 15:20]
    node _T_45 = bits(io.b, 11, 11) @[dut.scala 16:27]
    FullAdder_11.io.b <= _T_45 @[dut.scala 16:20]
    FullAdder_11.io.cin <= FullAdder_10.io.cout @[dut.scala 17:22]
    node _T_46 = shl(FullAdder_11.io.sum, 11) @[dut.scala 18:28]
    node _T_47 = or(_T_43, _T_46) @[dut.scala 18:8]
    inst FullAdder_12 of FullAdder_60 @[dut.scala 14:27]
    FullAdder_12.clock <= clock
    FullAdder_12.reset <= reset
    node _T_48 = bits(io.a, 12, 12) @[dut.scala 15:27]
    FullAdder_12.io.a <= _T_48 @[dut.scala 15:20]
    node _T_49 = bits(io.b, 12, 12) @[dut.scala 16:27]
    FullAdder_12.io.b <= _T_49 @[dut.scala 16:20]
    FullAdder_12.io.cin <= FullAdder_11.io.cout @[dut.scala 17:22]
    node _T_50 = shl(FullAdder_12.io.sum, 12) @[dut.scala 18:28]
    node _T_51 = or(_T_47, _T_50) @[dut.scala 18:8]
    inst FullAdder_13 of FullAdder_61 @[dut.scala 14:27]
    FullAdder_13.clock <= clock
    FullAdder_13.reset <= reset
    node _T_52 = bits(io.a, 13, 13) @[dut.scala 15:27]
    FullAdder_13.io.a <= _T_52 @[dut.scala 15:20]
    node _T_53 = bits(io.b, 13, 13) @[dut.scala 16:27]
    FullAdder_13.io.b <= _T_53 @[dut.scala 16:20]
    FullAdder_13.io.cin <= FullAdder_12.io.cout @[dut.scala 17:22]
    node _T_54 = shl(FullAdder_13.io.sum, 13) @[dut.scala 18:28]
    node _T_55 = or(_T_51, _T_54) @[dut.scala 18:8]
    inst FullAdder_14 of FullAdder_62 @[dut.scala 14:27]
    FullAdder_14.clock <= clock
    FullAdder_14.reset <= reset
    node _T_56 = bits(io.a, 14, 14) @[dut.scala 15:27]
    FullAdder_14.io.a <= _T_56 @[dut.scala 15:20]
    node _T_57 = bits(io.b, 14, 14) @[dut.scala 16:27]
    FullAdder_14.io.b <= _T_57 @[dut.scala 16:20]
    FullAdder_14.io.cin <= FullAdder_13.io.cout @[dut.scala 17:22]
    node _T_58 = shl(FullAdder_14.io.sum, 14) @[dut.scala 18:28]
    node _T_59 = or(_T_55, _T_58) @[dut.scala 18:8]
    inst FullAdder_15 of FullAdder_63 @[dut.scala 14:27]
    FullAdder_15.clock <= clock
    FullAdder_15.reset <= reset
    node _T_60 = bits(io.a, 15, 15) @[dut.scala 15:27]
    FullAdder_15.io.a <= _T_60 @[dut.scala 15:20]
    node _T_61 = bits(io.b, 15, 15) @[dut.scala 16:27]
    FullAdder_15.io.b <= _T_61 @[dut.scala 16:20]
    FullAdder_15.io.cin <= FullAdder_14.io.cout @[dut.scala 17:22]
    node _T_62 = shl(FullAdder_15.io.sum, 15) @[dut.scala 18:28]
    node sum = or(_T_59, _T_62) @[dut.scala 18:8]
    io.sum <= sum @[dut.scala 21:10]
    io.cout <= FullAdder_15.io.cout @[dut.scala 22:11]

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
    wire _en_pipeline_WIRE : UInt<1>[4] @[dut.scala 50:36]
    _en_pipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 50:36]
    _en_pipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 50:36]
    _en_pipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 50:36]
    _en_pipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 50:36]
    reg en_pipeline : UInt<1>[4], clock with :
      reset => (reset, _en_pipeline_WIRE) @[dut.scala 50:28]
    when io.i_en : @[dut.scala 51:17]
      en_pipeline[0] <= UInt<1>("h1") @[dut.scala 52:20]
    else :
      en_pipeline[0] <= UInt<1>("h0") @[dut.scala 54:20]
    en_pipeline[1] <= en_pipeline[0] @[dut.scala 57:20]
    en_pipeline[2] <= en_pipeline[1] @[dut.scala 57:20]
    en_pipeline[3] <= en_pipeline[2] @[dut.scala 57:20]
    node _T = bits(adda_reg, 15, 0) @[dut.scala 70:53]
    node _T_1 = bits(addb_reg, 15, 0) @[dut.scala 70:70]
    inst rca of RCA16 @[dut.scala 62:21]
    rca.clock <= clock
    rca.reset <= reset
    rca.io.a <= _T @[dut.scala 63:14]
    rca.io.b <= _T_1 @[dut.scala 64:14]
    rca.io.cin <= UInt<1>("h0") @[dut.scala 65:16]
    node _T_2 = bits(adda_reg, 31, 16) @[dut.scala 71:63]
    reg r : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r) @[Reg.scala 19:16]
    when en_pipeline[0] : @[Reg.scala 20:18]
      r <= _T_2 @[Reg.scala 20:22]
    node _T_3 = bits(addb_reg, 31, 16) @[dut.scala 71:108]
    reg r_1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_1) @[Reg.scala 19:16]
    when en_pipeline[0] : @[Reg.scala 20:18]
      r_1 <= _T_3 @[Reg.scala 20:22]
    reg r_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), r_2) @[Reg.scala 19:16]
    when en_pipeline[0] : @[Reg.scala 20:18]
      r_2 <= rca.io.cout @[Reg.scala 20:22]
    inst rca_1 of RCA16_1 @[dut.scala 62:21]
    rca_1.clock <= clock
    rca_1.reset <= reset
    rca_1.io.a <= r @[dut.scala 63:14]
    rca_1.io.b <= r_1 @[dut.scala 64:14]
    rca_1.io.cin <= r_2 @[dut.scala 65:16]
    node _T_4 = bits(adda_reg, 47, 32) @[dut.scala 72:63]
    reg r_3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_3) @[Reg.scala 19:16]
    when en_pipeline[1] : @[Reg.scala 20:18]
      r_3 <= _T_4 @[Reg.scala 20:22]
    node _T_5 = bits(addb_reg, 47, 32) @[dut.scala 72:108]
    reg r_4 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_4) @[Reg.scala 19:16]
    when en_pipeline[1] : @[Reg.scala 20:18]
      r_4 <= _T_5 @[Reg.scala 20:22]
    reg r_5 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), r_5) @[Reg.scala 19:16]
    when en_pipeline[1] : @[Reg.scala 20:18]
      r_5 <= rca_1.io.cout @[Reg.scala 20:22]
    inst rca_2 of RCA16_2 @[dut.scala 62:21]
    rca_2.clock <= clock
    rca_2.reset <= reset
    rca_2.io.a <= r_3 @[dut.scala 63:14]
    rca_2.io.b <= r_4 @[dut.scala 64:14]
    rca_2.io.cin <= r_5 @[dut.scala 65:16]
    node _T_6 = bits(adda_reg, 63, 48) @[dut.scala 73:63]
    reg r_6 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_6) @[Reg.scala 19:16]
    when en_pipeline[2] : @[Reg.scala 20:18]
      r_6 <= _T_6 @[Reg.scala 20:22]
    node _T_7 = bits(addb_reg, 63, 48) @[dut.scala 73:108]
    reg r_7 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_7) @[Reg.scala 19:16]
    when en_pipeline[2] : @[Reg.scala 20:18]
      r_7 <= _T_7 @[Reg.scala 20:22]
    reg r_8 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), r_8) @[Reg.scala 19:16]
    when en_pipeline[2] : @[Reg.scala 20:18]
      r_8 <= rca_2.io.cout @[Reg.scala 20:22]
    inst rca_3 of RCA16_3 @[dut.scala 62:21]
    rca_3.clock <= clock
    rca_3.reset <= reset
    rca_3.io.a <= r_6 @[dut.scala 63:14]
    rca_3.io.b <= r_7 @[dut.scala 64:14]
    rca_3.io.cin <= r_8 @[dut.scala 65:16]
    node result_reg_lo = cat(rca_1.io.sum, rca.io.sum) @[Cat.scala 33:92]
    node result_reg_hi_hi = cat(rca_3.io.cout, rca_3.io.sum) @[Cat.scala 33:92]
    node result_reg_hi = cat(result_reg_hi_hi, rca_2.io.sum) @[Cat.scala 33:92]
    node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
    reg result_reg : UInt<65>, clock with :
      reset => (UInt<1>("h0"), result_reg) @[Reg.scala 19:16]
    when en_pipeline[3] : @[Reg.scala 20:18]
      result_reg <= _result_reg_T @[Reg.scala 20:22]
    io.result <= result_reg @[dut.scala 77:13]
    io.o_en <= en_pipeline[3] @[dut.scala 80:11]

