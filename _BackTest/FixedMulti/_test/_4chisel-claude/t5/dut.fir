circuit dut :
  module FloatMultiplier :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<32>, flip b : UInt<32>, z : UInt<32>}

    reg counter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 11:24]
    reg a_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), a_mantissa) @[dut.scala 12:23]
    reg b_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), b_mantissa) @[dut.scala 13:23]
    reg z_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), z_mantissa) @[dut.scala 14:23]
    reg a_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), a_exponent) @[dut.scala 15:23]
    reg b_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), b_exponent) @[dut.scala 16:23]
    reg z_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), z_exponent) @[dut.scala 17:23]
    reg a_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), a_sign) @[dut.scala 18:19]
    reg b_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), b_sign) @[dut.scala 19:19]
    reg z_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), z_sign) @[dut.scala 20:19]
    reg product : UInt<50>, clock with :
      reset => (UInt<1>("h0"), product) @[dut.scala 21:20]
    reg guard_bit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), guard_bit) @[dut.scala 22:22]
    reg round_bit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), round_bit) @[dut.scala 23:22]
    reg sticky : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sticky) @[dut.scala 24:19]
    io.z <= UInt<1>("h0") @[dut.scala 27:8]
    node _T = eq(UInt<1>("h0"), counter) @[dut.scala 29:19]
    when _T : @[dut.scala 29:19]
      node _a_mantissa_T = bits(io.a, 22, 0) @[dut.scala 32:39]
      node _a_mantissa_T_1 = cat(UInt<1>("h1"), _a_mantissa_T) @[Cat.scala 33:92]
      a_mantissa <= _a_mantissa_T_1 @[dut.scala 32:18]
      node _b_mantissa_T = bits(io.b, 22, 0) @[dut.scala 33:39]
      node _b_mantissa_T_1 = cat(UInt<1>("h1"), _b_mantissa_T) @[Cat.scala 33:92]
      b_mantissa <= _b_mantissa_T_1 @[dut.scala 33:18]
      node _a_exponent_T = bits(io.a, 30, 23) @[dut.scala 34:25]
      a_exponent <= _a_exponent_T @[dut.scala 34:18]
      node _b_exponent_T = bits(io.b, 30, 23) @[dut.scala 35:25]
      b_exponent <= _b_exponent_T @[dut.scala 35:18]
      node _a_sign_T = bits(io.a, 31, 31) @[dut.scala 36:21]
      a_sign <= _a_sign_T @[dut.scala 36:14]
      node _b_sign_T = bits(io.b, 31, 31) @[dut.scala 37:21]
      b_sign <= _b_sign_T @[dut.scala 37:14]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 38:26]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 38:26]
      counter <= _counter_T_1 @[dut.scala 38:15]
    else :
      node _T_1 = eq(UInt<1>("h1"), counter) @[dut.scala 29:19]
      when _T_1 : @[dut.scala 29:19]
        node _T_2 = eq(a_exponent, UInt<1>("h0")) @[dut.scala 43:23]
        node _T_3 = eq(b_exponent, UInt<1>("h0")) @[dut.scala 43:45]
        node _T_4 = or(_T_2, _T_3) @[dut.scala 43:31]
        when _T_4 : @[dut.scala 43:54]
          io.z <= UInt<1>("h0") @[dut.scala 45:14]
        else :
          node _T_5 = eq(a_exponent, UInt<8>("hff")) @[dut.scala 46:29]
          node _T_6 = eq(b_exponent, UInt<8>("hff")) @[dut.scala 46:53]
          node _T_7 = or(_T_5, _T_6) @[dut.scala 46:39]
          when _T_7 : @[dut.scala 46:64]
            node io_z_hi = cat(z_sign, UInt<8>("hff")) @[Cat.scala 33:92]
            node _io_z_T = cat(io_z_hi, UInt<23>("h0")) @[Cat.scala 33:92]
            io.z <= _io_z_T @[dut.scala 48:14]
          else :
            node _z_sign_T = xor(a_sign, b_sign) @[dut.scala 51:26]
            z_sign <= _z_sign_T @[dut.scala 51:16]
            node _z_exponent_T = add(a_exponent, b_exponent) @[dut.scala 52:34]
            node _z_exponent_T_1 = sub(_z_exponent_T, UInt<7>("h7f")) @[dut.scala 52:48]
            node _z_exponent_T_2 = asUInt(_z_exponent_T_1) @[dut.scala 52:48]
            z_exponent <= _z_exponent_T_2 @[dut.scala 52:20]
            node _product_T = mul(a_mantissa, b_mantissa) @[dut.scala 53:31]
            product <= _product_T @[dut.scala 53:17]
            node _counter_T_2 = add(counter, UInt<1>("h1")) @[dut.scala 54:28]
            node _counter_T_3 = tail(_counter_T_2, 1) @[dut.scala 54:28]
            counter <= _counter_T_3 @[dut.scala 54:17]
      else :
        node _T_8 = eq(UInt<2>("h2"), counter) @[dut.scala 29:19]
        when _T_8 : @[dut.scala 29:19]
          node _T_9 = bits(product, 49, 49) @[dut.scala 60:19]
          when _T_9 : @[dut.scala 60:25]
            node _z_mantissa_T = bits(product, 49, 26) @[dut.scala 61:30]
            z_mantissa <= _z_mantissa_T @[dut.scala 61:20]
            node _guard_bit_T = bits(product, 25, 25) @[dut.scala 62:29]
            guard_bit <= _guard_bit_T @[dut.scala 62:19]
            node _round_bit_T = bits(product, 24, 24) @[dut.scala 63:29]
            round_bit <= _round_bit_T @[dut.scala 63:19]
            node _sticky_T = bits(product, 23, 0) @[dut.scala 64:26]
            node _sticky_T_1 = orr(_sticky_T) @[dut.scala 64:34]
            sticky <= _sticky_T_1 @[dut.scala 64:16]
            node _z_exponent_T_3 = add(z_exponent, UInt<1>("h1")) @[dut.scala 65:34]
            node _z_exponent_T_4 = tail(_z_exponent_T_3, 1) @[dut.scala 65:34]
            z_exponent <= _z_exponent_T_4 @[dut.scala 65:20]
          else :
            node _z_mantissa_T_1 = bits(product, 48, 25) @[dut.scala 67:30]
            z_mantissa <= _z_mantissa_T_1 @[dut.scala 67:20]
            node _guard_bit_T_1 = bits(product, 24, 24) @[dut.scala 68:29]
            guard_bit <= _guard_bit_T_1 @[dut.scala 68:19]
            node _round_bit_T_1 = bits(product, 23, 23) @[dut.scala 69:29]
            round_bit <= _round_bit_T_1 @[dut.scala 69:19]
            node _sticky_T_2 = bits(product, 22, 0) @[dut.scala 70:26]
            node _sticky_T_3 = orr(_sticky_T_2) @[dut.scala 70:34]
            sticky <= _sticky_T_3 @[dut.scala 70:16]
          node _counter_T_4 = add(counter, UInt<1>("h1")) @[dut.scala 72:26]
          node _counter_T_5 = tail(_counter_T_4, 1) @[dut.scala 72:26]
          counter <= _counter_T_5 @[dut.scala 72:15]
        else :
          node _T_10 = eq(UInt<2>("h3"), counter) @[dut.scala 29:19]
          when _T_10 : @[dut.scala 29:19]
            node _T_11 = or(round_bit, sticky) @[dut.scala 77:36]
            node _T_12 = bits(z_mantissa, 0, 0) @[dut.scala 77:59]
            node _T_13 = or(_T_11, _T_12) @[dut.scala 77:46]
            node _T_14 = and(guard_bit, _T_13) @[dut.scala 77:22]
            when _T_14 : @[dut.scala 77:65]
              node _z_mantissa_T_2 = add(z_mantissa, UInt<1>("h1")) @[dut.scala 78:34]
              node _z_mantissa_T_3 = tail(_z_mantissa_T_2, 1) @[dut.scala 78:34]
              z_mantissa <= _z_mantissa_T_3 @[dut.scala 78:20]
              node _T_15 = andr(z_mantissa) @[dut.scala 79:25]
              when _T_15 : @[dut.scala 79:31]
                node _z_exponent_T_5 = add(z_exponent, UInt<1>("h1")) @[dut.scala 80:36]
                node _z_exponent_T_6 = tail(_z_exponent_T_5, 1) @[dut.scala 80:36]
                z_exponent <= _z_exponent_T_6 @[dut.scala 80:22]
            node _counter_T_6 = add(counter, UInt<1>("h1")) @[dut.scala 83:26]
            node _counter_T_7 = tail(_counter_T_6, 1) @[dut.scala 83:26]
            counter <= _counter_T_7 @[dut.scala 83:15]
          else :
            node _T_16 = eq(UInt<3>("h4"), counter) @[dut.scala 29:19]
            when _T_16 : @[dut.scala 29:19]
              node _T_17 = geq(z_exponent, UInt<8>("hff")) @[dut.scala 88:23]
              when _T_17 : @[dut.scala 88:33]
                node io_z_hi_1 = cat(z_sign, UInt<8>("hff")) @[Cat.scala 33:92]
                node _io_z_T_1 = cat(io_z_hi_1, UInt<23>("h0")) @[Cat.scala 33:92]
                io.z <= _io_z_T_1 @[dut.scala 90:14]
              else :
                node _T_18 = leq(z_exponent, UInt<1>("h0")) @[dut.scala 91:29]
                when _T_18 : @[dut.scala 91:37]
                  node _io_z_T_2 = cat(z_sign, UInt<31>("h0")) @[Cat.scala 33:92]
                  io.z <= _io_z_T_2 @[dut.scala 93:14]
                else :
                  node _io_z_T_3 = bits(z_exponent, 7, 0) @[dut.scala 95:39]
                  node _io_z_T_4 = bits(z_mantissa, 22, 0) @[dut.scala 95:57]
                  node io_z_hi_2 = cat(z_sign, _io_z_T_3) @[Cat.scala 33:92]
                  node _io_z_T_5 = cat(io_z_hi_2, _io_z_T_4) @[Cat.scala 33:92]
                  io.z <= _io_z_T_5 @[dut.scala 95:14]
              counter <= UInt<1>("h0") @[dut.scala 97:15]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<32>, flip b : UInt<32>, z : UInt<32>}

    inst multiplier of FloatMultiplier @[dut.scala 110:26]
    multiplier.clock <= clock
    multiplier.reset <= reset
    multiplier.io.a <= io.a @[dut.scala 111:19]
    multiplier.io.b <= io.b @[dut.scala 112:19]
    io.z <= multiplier.io.z @[dut.scala 113:8]

