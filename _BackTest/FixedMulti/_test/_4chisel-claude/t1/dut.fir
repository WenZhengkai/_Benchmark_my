circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<32>, flip b : UInt<32>, z : UInt<32>}

    reg counter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 12:24]
    reg a_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), a_mantissa) @[dut.scala 13:23]
    reg b_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), b_mantissa) @[dut.scala 14:23]
    reg z_mantissa : UInt<24>, clock with :
      reset => (UInt<1>("h0"), z_mantissa) @[dut.scala 15:23]
    reg a_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), a_exponent) @[dut.scala 16:23]
    reg b_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), b_exponent) @[dut.scala 17:23]
    reg z_exponent : UInt<10>, clock with :
      reset => (UInt<1>("h0"), z_exponent) @[dut.scala 18:23]
    reg a_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), a_sign) @[dut.scala 19:19]
    reg b_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), b_sign) @[dut.scala 20:19]
    reg z_sign : UInt<1>, clock with :
      reset => (UInt<1>("h0"), z_sign) @[dut.scala 21:19]
    reg product : UInt<50>, clock with :
      reset => (UInt<1>("h0"), product) @[dut.scala 22:20]
    reg guard_bit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), guard_bit) @[dut.scala 23:22]
    reg round_bit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), round_bit) @[dut.scala 24:22]
    reg sticky : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sticky) @[dut.scala 25:19]
    io.z <= UInt<1>("h0") @[dut.scala 28:8]
    node _T = eq(UInt<1>("h0"), counter) @[dut.scala 31:19]
    when _T : @[dut.scala 31:19]
      node _a_mantissa_T = bits(io.a, 22, 0) @[dut.scala 34:39]
      node _a_mantissa_T_1 = cat(UInt<1>("h1"), _a_mantissa_T) @[Cat.scala 33:92]
      a_mantissa <= _a_mantissa_T_1 @[dut.scala 34:18]
      node _b_mantissa_T = bits(io.b, 22, 0) @[dut.scala 35:39]
      node _b_mantissa_T_1 = cat(UInt<1>("h1"), _b_mantissa_T) @[Cat.scala 33:92]
      b_mantissa <= _b_mantissa_T_1 @[dut.scala 35:18]
      node _a_exponent_T = bits(io.a, 30, 23) @[dut.scala 36:25]
      a_exponent <= _a_exponent_T @[dut.scala 36:18]
      node _b_exponent_T = bits(io.b, 30, 23) @[dut.scala 37:25]
      b_exponent <= _b_exponent_T @[dut.scala 37:18]
      node _a_sign_T = bits(io.a, 31, 31) @[dut.scala 38:21]
      a_sign <= _a_sign_T @[dut.scala 38:14]
      node _b_sign_T = bits(io.b, 31, 31) @[dut.scala 39:21]
      b_sign <= _b_sign_T @[dut.scala 39:14]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 40:26]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 40:26]
      counter <= _counter_T_1 @[dut.scala 40:15]
    else :
      node _T_1 = eq(UInt<1>("h1"), counter) @[dut.scala 31:19]
      when _T_1 : @[dut.scala 31:19]
        node _T_2 = eq(a_exponent, UInt<8>("hff")) @[dut.scala 45:23]
        node _T_3 = eq(b_exponent, UInt<8>("hff")) @[dut.scala 45:47]
        node _T_4 = or(_T_2, _T_3) @[dut.scala 45:33]
        when _T_4 : @[dut.scala 45:58]
          z_exponent <= UInt<8>("hff") @[dut.scala 47:20]
          node _z_mantissa_T = eq(a_exponent, UInt<8>("hff")) @[dut.scala 48:38]
          node _z_mantissa_T_1 = bits(a_mantissa, 22, 0) @[dut.scala 48:59]
          node _z_mantissa_T_2 = bits(b_mantissa, 22, 0) @[dut.scala 48:78]
          node _z_mantissa_T_3 = mux(_z_mantissa_T, _z_mantissa_T_1, _z_mantissa_T_2) @[dut.scala 48:26]
          z_mantissa <= _z_mantissa_T_3 @[dut.scala 48:20]
          node _z_sign_T = xor(a_sign, b_sign) @[dut.scala 49:26]
          z_sign <= _z_sign_T @[dut.scala 49:16]
        else :
          node _product_T = mul(a_mantissa, b_mantissa) @[dut.scala 52:31]
          product <= _product_T @[dut.scala 52:17]
          node _z_exponent_T = add(a_exponent, b_exponent) @[dut.scala 53:34]
          node _z_exponent_T_1 = sub(_z_exponent_T, UInt<7>("h7f")) @[dut.scala 53:48]
          node _z_exponent_T_2 = asUInt(_z_exponent_T_1) @[dut.scala 53:48]
          z_exponent <= _z_exponent_T_2 @[dut.scala 53:20]
          node _z_sign_T_1 = xor(a_sign, b_sign) @[dut.scala 54:26]
          z_sign <= _z_sign_T_1 @[dut.scala 54:16]
        node _counter_T_2 = add(counter, UInt<1>("h1")) @[dut.scala 56:26]
        node _counter_T_3 = tail(_counter_T_2, 1) @[dut.scala 56:26]
        counter <= _counter_T_3 @[dut.scala 56:15]
      else :
        node _T_5 = eq(UInt<2>("h2"), counter) @[dut.scala 31:19]
        when _T_5 : @[dut.scala 31:19]
          node _T_6 = bits(product, 49, 49) @[dut.scala 61:19]
          when _T_6 : @[dut.scala 61:25]
            node _z_mantissa_T_4 = bits(product, 49, 26) @[dut.scala 62:30]
            z_mantissa <= _z_mantissa_T_4 @[dut.scala 62:20]
            node _guard_bit_T = bits(product, 25, 25) @[dut.scala 63:29]
            guard_bit <= _guard_bit_T @[dut.scala 63:19]
            node _round_bit_T = bits(product, 24, 24) @[dut.scala 64:29]
            round_bit <= _round_bit_T @[dut.scala 64:19]
            node _sticky_T = bits(product, 23, 0) @[dut.scala 65:26]
            node _sticky_T_1 = orr(_sticky_T) @[dut.scala 65:34]
            sticky <= _sticky_T_1 @[dut.scala 65:16]
            node _z_exponent_T_3 = add(z_exponent, UInt<1>("h1")) @[dut.scala 66:34]
            node _z_exponent_T_4 = tail(_z_exponent_T_3, 1) @[dut.scala 66:34]
            z_exponent <= _z_exponent_T_4 @[dut.scala 66:20]
          else :
            node _z_mantissa_T_5 = bits(product, 48, 25) @[dut.scala 68:30]
            z_mantissa <= _z_mantissa_T_5 @[dut.scala 68:20]
            node _guard_bit_T_1 = bits(product, 24, 24) @[dut.scala 69:29]
            guard_bit <= _guard_bit_T_1 @[dut.scala 69:19]
            node _round_bit_T_1 = bits(product, 23, 23) @[dut.scala 70:29]
            round_bit <= _round_bit_T_1 @[dut.scala 70:19]
            node _sticky_T_2 = bits(product, 22, 0) @[dut.scala 71:26]
            node _sticky_T_3 = orr(_sticky_T_2) @[dut.scala 71:34]
            sticky <= _sticky_T_3 @[dut.scala 71:16]
          node _counter_T_4 = add(counter, UInt<1>("h1")) @[dut.scala 73:26]
          node _counter_T_5 = tail(_counter_T_4, 1) @[dut.scala 73:26]
          counter <= _counter_T_5 @[dut.scala 73:15]
        else :
          node _T_7 = eq(UInt<2>("h3"), counter) @[dut.scala 31:19]
          when _T_7 : @[dut.scala 31:19]
            node _T_8 = or(round_bit, sticky) @[dut.scala 78:36]
            node _T_9 = bits(z_mantissa, 0, 0) @[dut.scala 78:59]
            node _T_10 = or(_T_8, _T_9) @[dut.scala 78:46]
            node _T_11 = and(guard_bit, _T_10) @[dut.scala 78:22]
            when _T_11 : @[dut.scala 78:65]
              node _z_mantissa_T_6 = add(z_mantissa, UInt<1>("h1")) @[dut.scala 79:34]
              node _z_mantissa_T_7 = tail(_z_mantissa_T_6, 1) @[dut.scala 79:34]
              z_mantissa <= _z_mantissa_T_7 @[dut.scala 79:20]
              node _T_12 = andr(z_mantissa) @[dut.scala 80:25]
              when _T_12 : @[dut.scala 80:31]
                node _z_exponent_T_5 = add(z_exponent, UInt<1>("h1")) @[dut.scala 81:36]
                node _z_exponent_T_6 = tail(_z_exponent_T_5, 1) @[dut.scala 81:36]
                z_exponent <= _z_exponent_T_6 @[dut.scala 81:22]
            node _counter_T_6 = add(counter, UInt<1>("h1")) @[dut.scala 84:26]
            node _counter_T_7 = tail(_counter_T_6, 1) @[dut.scala 84:26]
            counter <= _counter_T_7 @[dut.scala 84:15]
          else :
            node _T_13 = eq(UInt<3>("h4"), counter) @[dut.scala 31:19]
            when _T_13 : @[dut.scala 31:19]
              node _T_14 = geq(z_exponent, UInt<8>("hff")) @[dut.scala 89:23]
              when _T_14 : @[dut.scala 89:33]
                node io_z_hi = cat(z_sign, UInt<8>("hff")) @[Cat.scala 33:92]
                node _io_z_T = cat(io_z_hi, UInt<23>("h0")) @[Cat.scala 33:92]
                io.z <= _io_z_T @[dut.scala 91:14]
              else :
                node _T_15 = leq(z_exponent, UInt<1>("h0")) @[dut.scala 92:29]
                when _T_15 : @[dut.scala 92:37]
                  node _io_z_T_1 = cat(z_sign, UInt<31>("h0")) @[Cat.scala 33:92]
                  io.z <= _io_z_T_1 @[dut.scala 94:14]
                else :
                  node _io_z_T_2 = bits(z_exponent, 7, 0) @[dut.scala 96:39]
                  node _io_z_T_3 = bits(z_mantissa, 22, 0) @[dut.scala 96:57]
                  node io_z_hi_1 = cat(z_sign, _io_z_T_2) @[Cat.scala 33:92]
                  node _io_z_T_4 = cat(io_z_hi_1, _io_z_T_3) @[Cat.scala 33:92]
                  io.z <= _io_z_T_4 @[dut.scala 96:14]
              counter <= UInt<1>("h0") @[dut.scala 98:15]


