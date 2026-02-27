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
        node _T_2 = eq(a_exponent, UInt<8>("hff")) @[dut.scala 43:23]
        node _T_3 = eq(b_exponent, UInt<8>("hff")) @[dut.scala 43:47]
        node _T_4 = or(_T_2, _T_3) @[dut.scala 43:33]
        when _T_4 : @[dut.scala 43:58]
          node _T_5 = eq(a_exponent, UInt<8>("hff")) @[dut.scala 44:25]
          node _T_6 = neq(a_mantissa, UInt<1>("h0")) @[dut.scala 44:49]
          node _T_7 = and(_T_5, _T_6) @[dut.scala 44:35]
          when _T_7 : @[dut.scala 44:58]
            z_mantissa <= a_mantissa @[dut.scala 46:22]
            z_exponent <= UInt<8>("hff") @[dut.scala 47:22]
            z_sign <= a_sign @[dut.scala 48:18]
          else :
            node _T_8 = eq(b_exponent, UInt<8>("hff")) @[dut.scala 49:31]
            node _T_9 = neq(b_mantissa, UInt<1>("h0")) @[dut.scala 49:55]
            node _T_10 = and(_T_8, _T_9) @[dut.scala 49:41]
            when _T_10 : @[dut.scala 49:64]
              z_mantissa <= b_mantissa @[dut.scala 51:22]
              z_exponent <= UInt<8>("hff") @[dut.scala 52:22]
              z_sign <= b_sign @[dut.scala 53:18]
            else :
              z_mantissa <= UInt<1>("h0") @[dut.scala 56:22]
              z_exponent <= UInt<8>("hff") @[dut.scala 57:22]
              node _z_sign_T = xor(a_sign, b_sign) @[dut.scala 58:28]
              z_sign <= _z_sign_T @[dut.scala 58:18]
        else :
          node _product_T = mul(a_mantissa, b_mantissa) @[dut.scala 62:31]
          product <= _product_T @[dut.scala 62:17]
          node _z_exponent_T = add(a_exponent, b_exponent) @[dut.scala 63:34]
          node _z_exponent_T_1 = sub(_z_exponent_T, UInt<7>("h7f")) @[dut.scala 63:48]
          node _z_exponent_T_2 = asUInt(_z_exponent_T_1) @[dut.scala 63:48]
          z_exponent <= _z_exponent_T_2 @[dut.scala 63:20]
          node _z_sign_T_1 = xor(a_sign, b_sign) @[dut.scala 64:26]
          z_sign <= _z_sign_T_1 @[dut.scala 64:16]
        node _counter_T_2 = add(counter, UInt<1>("h1")) @[dut.scala 66:26]
        node _counter_T_3 = tail(_counter_T_2, 1) @[dut.scala 66:26]
        counter <= _counter_T_3 @[dut.scala 66:15]
      else :
        node _T_11 = eq(UInt<2>("h2"), counter) @[dut.scala 29:19]
        when _T_11 : @[dut.scala 29:19]
          node _T_12 = bits(product, 49, 49) @[dut.scala 71:19]
          when _T_12 : @[dut.scala 71:25]
            node _z_mantissa_T = bits(product, 49, 26) @[dut.scala 72:30]
            z_mantissa <= _z_mantissa_T @[dut.scala 72:20]
            node _guard_bit_T = bits(product, 25, 25) @[dut.scala 73:29]
            guard_bit <= _guard_bit_T @[dut.scala 73:19]
            node _round_bit_T = bits(product, 24, 24) @[dut.scala 74:29]
            round_bit <= _round_bit_T @[dut.scala 74:19]
            node _sticky_T = bits(product, 23, 0) @[dut.scala 75:26]
            node _sticky_T_1 = orr(_sticky_T) @[dut.scala 75:34]
            sticky <= _sticky_T_1 @[dut.scala 75:16]
            node _z_exponent_T_3 = add(z_exponent, UInt<1>("h1")) @[dut.scala 76:34]
            node _z_exponent_T_4 = tail(_z_exponent_T_3, 1) @[dut.scala 76:34]
            z_exponent <= _z_exponent_T_4 @[dut.scala 76:20]
          else :
            node _z_mantissa_T_1 = bits(product, 48, 25) @[dut.scala 78:30]
            z_mantissa <= _z_mantissa_T_1 @[dut.scala 78:20]
            node _guard_bit_T_1 = bits(product, 24, 24) @[dut.scala 79:29]
            guard_bit <= _guard_bit_T_1 @[dut.scala 79:19]
            node _round_bit_T_1 = bits(product, 23, 23) @[dut.scala 80:29]
            round_bit <= _round_bit_T_1 @[dut.scala 80:19]
            node _sticky_T_2 = bits(product, 22, 0) @[dut.scala 81:26]
            node _sticky_T_3 = orr(_sticky_T_2) @[dut.scala 81:34]
            sticky <= _sticky_T_3 @[dut.scala 81:16]
          node _counter_T_4 = add(counter, UInt<1>("h1")) @[dut.scala 83:26]
          node _counter_T_5 = tail(_counter_T_4, 1) @[dut.scala 83:26]
          counter <= _counter_T_5 @[dut.scala 83:15]
        else :
          node _T_13 = eq(UInt<2>("h3"), counter) @[dut.scala 29:19]
          when _T_13 : @[dut.scala 29:19]
            node _T_14 = or(round_bit, sticky) @[dut.scala 88:36]
            node _T_15 = bits(z_mantissa, 0, 0) @[dut.scala 88:59]
            node _T_16 = or(_T_14, _T_15) @[dut.scala 88:46]
            node _T_17 = and(guard_bit, _T_16) @[dut.scala 88:22]
            when _T_17 : @[dut.scala 88:65]
              node _z_mantissa_T_2 = add(z_mantissa, UInt<1>("h1")) @[dut.scala 89:34]
              node _z_mantissa_T_3 = tail(_z_mantissa_T_2, 1) @[dut.scala 89:34]
              z_mantissa <= _z_mantissa_T_3 @[dut.scala 89:20]
              node _T_18 = eq(z_mantissa, UInt<24>("hffffff")) @[dut.scala 90:25]
              when _T_18 : @[dut.scala 90:42]
                node _z_exponent_T_5 = add(z_exponent, UInt<1>("h1")) @[dut.scala 91:36]
                node _z_exponent_T_6 = tail(_z_exponent_T_5, 1) @[dut.scala 91:36]
                z_exponent <= _z_exponent_T_6 @[dut.scala 91:22]
            node _counter_T_6 = add(counter, UInt<1>("h1")) @[dut.scala 94:26]
            node _counter_T_7 = tail(_counter_T_6, 1) @[dut.scala 94:26]
            counter <= _counter_T_7 @[dut.scala 94:15]
          else :
            node _T_19 = eq(UInt<3>("h4"), counter) @[dut.scala 29:19]
            when _T_19 : @[dut.scala 29:19]
              node _T_20 = geq(z_exponent, UInt<8>("hff")) @[dut.scala 99:23]
              when _T_20 : @[dut.scala 99:33]
                node io_z_hi = cat(z_sign, UInt<8>("hff")) @[Cat.scala 33:92]
                node _io_z_T = cat(io_z_hi, UInt<23>("h0")) @[Cat.scala 33:92]
                io.z <= _io_z_T @[dut.scala 101:14]
              else :
                node _T_21 = eq(z_exponent, UInt<1>("h0")) @[dut.scala 102:29]
                node _T_22 = eq(z_mantissa, UInt<1>("h0")) @[dut.scala 102:51]
                node _T_23 = or(_T_21, _T_22) @[dut.scala 102:37]
                when _T_23 : @[dut.scala 102:60]
                  node _io_z_T_1 = cat(z_sign, UInt<31>("h0")) @[Cat.scala 33:92]
                  io.z <= _io_z_T_1 @[dut.scala 104:14]
                else :
                  node _io_z_T_2 = bits(z_exponent, 7, 0) @[dut.scala 106:39]
                  node _io_z_T_3 = bits(z_mantissa, 22, 0) @[dut.scala 106:57]
                  node io_z_hi_1 = cat(z_sign, _io_z_T_2) @[Cat.scala 33:92]
                  node _io_z_T_4 = cat(io_z_hi_1, _io_z_T_3) @[Cat.scala 33:92]
                  io.z <= _io_z_T_4 @[dut.scala 106:14]
              counter <= UInt<1>("h0") @[dut.scala 108:15]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<32>, flip b : UInt<32>, z : UInt<32>}

    inst multiplier of FloatMultiplier @[dut.scala 121:26]
    multiplier.clock <= clock
    multiplier.reset <= reset
    multiplier.io.a <= io.a @[dut.scala 122:19]
    multiplier.io.b <= io.b @[dut.scala 123:19]
    io.z <= multiplier.io.z @[dut.scala 124:8]

