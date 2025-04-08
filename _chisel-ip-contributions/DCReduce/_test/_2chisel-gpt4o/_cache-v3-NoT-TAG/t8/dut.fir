circuit dut :
  module DCInput_UInt8 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCInput_UInt8_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCInput_UInt8_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCInput_UInt8_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCInput_UInt8_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCInput_UInt8_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[DCInput.scala 23:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCInput.scala 24:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[DCInput.scala 25:17]
    wire load : UInt<1> @[DCInput.scala 26:18]
    wire drain : UInt<1> @[DCInput.scala 27:19]
    node _drain_T = and(occupied, io.deq.ready) @[DCInput.scala 29:21]
    drain <= _drain_T @[DCInput.scala 29:9]
    node _load_T = and(io.enq.valid, ready_r) @[DCInput.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCInput.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[DCInput.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[DCInput.scala 30:35]
    load <= _load_T_3 @[DCInput.scala 30:8]
    when occupied : @[DCInput.scala 32:18]
      io.deq.bits <= hold @[DCInput.scala 33:17]
    else :
      io.deq.bits <= io.enq.bits @[DCInput.scala 35:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[DCInput.scala 38:32]
    io.deq.valid <= _io_deq_valid_T @[DCInput.scala 38:16]
    when load : @[DCInput.scala 39:14]
      occupied <= UInt<1>("h1") @[DCInput.scala 40:14]
      hold <= io.enq.bits @[DCInput.scala 41:10]
    else :
      when drain : @[DCInput.scala 42:21]
        occupied <= UInt<1>("h0") @[DCInput.scala 43:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[DCInput.scala 46:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[DCInput.scala 46:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[DCInput.scala 46:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[DCInput.scala 46:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[DCInput.scala 46:35]
    ready_r <= _ready_r_T_5 @[DCInput.scala 46:11]
    io.enq.ready <= ready_r @[DCInput.scala 47:16]

  module DCOutput_UInt8 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg rValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DCOutput.scala 18:23]
    node _io_enq_ready_T = eq(rValid, UInt<1>("h0")) @[DCOutput.scala 20:35]
    node _io_enq_ready_T_1 = or(io.deq.ready, _io_enq_ready_T) @[DCOutput.scala 20:32]
    io.enq.ready <= _io_enq_ready_T_1 @[DCOutput.scala 20:16]
    node _rValid_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _rValid_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[DCOutput.scala 21:39]
    node _rValid_T_2 = and(rValid, _rValid_T_1) @[DCOutput.scala 21:36]
    node _rValid_T_3 = or(_rValid_T, _rValid_T_2) @[DCOutput.scala 21:25]
    rValid <= _rValid_T_3 @[DCOutput.scala 21:10]
    node _io_deq_bits_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg io_deq_bits_r : UInt<8>, clock with :
      reset => (UInt<1>("h0"), io_deq_bits_r) @[Reg.scala 19:16]
    when _io_deq_bits_T : @[Reg.scala 20:18]
      io_deq_bits_r <= io.enq.bits @[Reg.scala 20:22]
    io.deq.bits <= io_deq_bits_r @[DCOutput.scala 22:15]
    io.deq.valid <= rValid @[DCOutput.scala 23:16]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[6], z : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst aInt_tout of DCInput_UInt8 @[DCInput.scala 53:22]
    aInt_tout.clock <= clock
    aInt_tout.reset <= reset
    aInt_tout.io.enq <= io.a[0] @[DCInput.scala 54:17]
    inst aInt_tout_1 of DCInput_UInt8_1 @[DCInput.scala 53:22]
    aInt_tout_1.clock <= clock
    aInt_tout_1.reset <= reset
    aInt_tout_1.io.enq <= io.a[1] @[DCInput.scala 54:17]
    inst aInt_tout_2 of DCInput_UInt8_2 @[DCInput.scala 53:22]
    aInt_tout_2.clock <= clock
    aInt_tout_2.reset <= reset
    aInt_tout_2.io.enq <= io.a[2] @[DCInput.scala 54:17]
    inst aInt_tout_3 of DCInput_UInt8_3 @[DCInput.scala 53:22]
    aInt_tout_3.clock <= clock
    aInt_tout_3.reset <= reset
    aInt_tout_3.io.enq <= io.a[3] @[DCInput.scala 54:17]
    inst aInt_tout_4 of DCInput_UInt8_4 @[DCInput.scala 53:22]
    aInt_tout_4.clock <= clock
    aInt_tout_4.reset <= reset
    aInt_tout_4.io.enq <= io.a[4] @[DCInput.scala 54:17]
    inst aInt_tout_5 of DCInput_UInt8_5 @[DCInput.scala 53:22]
    aInt_tout_5.clock <= clock
    aInt_tout_5.reset <= reset
    aInt_tout_5.io.enq <= io.a[5] @[DCInput.scala 54:17]
    wire aInt : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[6] @[dut.scala 14:21]
    aInt[0].bits <= aInt_tout.io.deq.bits @[dut.scala 14:21]
    aInt[0].valid <= aInt_tout.io.deq.valid @[dut.scala 14:21]
    aInt_tout.io.deq.ready <= aInt[0].ready @[dut.scala 14:21]
    aInt[1].bits <= aInt_tout_1.io.deq.bits @[dut.scala 14:21]
    aInt[1].valid <= aInt_tout_1.io.deq.valid @[dut.scala 14:21]
    aInt_tout_1.io.deq.ready <= aInt[1].ready @[dut.scala 14:21]
    aInt[2].bits <= aInt_tout_2.io.deq.bits @[dut.scala 14:21]
    aInt[2].valid <= aInt_tout_2.io.deq.valid @[dut.scala 14:21]
    aInt_tout_2.io.deq.ready <= aInt[2].ready @[dut.scala 14:21]
    aInt[3].bits <= aInt_tout_3.io.deq.bits @[dut.scala 14:21]
    aInt[3].valid <= aInt_tout_3.io.deq.valid @[dut.scala 14:21]
    aInt_tout_3.io.deq.ready <= aInt[3].ready @[dut.scala 14:21]
    aInt[4].bits <= aInt_tout_4.io.deq.bits @[dut.scala 14:21]
    aInt[4].valid <= aInt_tout_4.io.deq.valid @[dut.scala 14:21]
    aInt_tout_4.io.deq.ready <= aInt[4].ready @[dut.scala 14:21]
    aInt[5].bits <= aInt_tout_5.io.deq.bits @[dut.scala 14:21]
    aInt[5].valid <= aInt_tout_5.io.deq.valid @[dut.scala 14:21]
    aInt_tout_5.io.deq.ready <= aInt[5].ready @[dut.scala 14:21]
    wire zInt : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>} @[dut.scala 15:18]
    node _all_valid_T = and(aInt[0].valid, aInt[1].valid) @[dut.scala 18:46]
    node _all_valid_T_1 = and(_all_valid_T, aInt[2].valid) @[dut.scala 18:46]
    node _all_valid_T_2 = and(_all_valid_T_1, aInt[3].valid) @[dut.scala 18:46]
    node _all_valid_T_3 = and(_all_valid_T_2, aInt[4].valid) @[dut.scala 18:46]
    node all_valid = and(_all_valid_T_3, aInt[5].valid) @[dut.scala 18:46]
    node _zInt_bits_T = xor(aInt[0].bits, aInt[1].bits) @[driver.scala 6:39]
    node _zInt_bits_T_1 = xor(_zInt_bits_T, aInt[2].bits) @[driver.scala 6:39]
    node _zInt_bits_T_2 = xor(_zInt_bits_T_1, aInt[3].bits) @[driver.scala 6:39]
    node _zInt_bits_T_3 = xor(_zInt_bits_T_2, aInt[4].bits) @[driver.scala 6:39]
    node _zInt_bits_T_4 = xor(_zInt_bits_T_3, aInt[5].bits) @[driver.scala 6:39]
    zInt.bits <= _zInt_bits_T_4 @[dut.scala 21:13]
    node _T = and(all_valid, zInt.ready) @[dut.scala 24:18]
    when _T : @[dut.scala 24:33]
      zInt.valid <= UInt<1>("h1") @[dut.scala 25:16]
      aInt[0].ready <= UInt<1>("h1") @[dut.scala 26:26]
      aInt[1].ready <= UInt<1>("h1") @[dut.scala 26:26]
      aInt[2].ready <= UInt<1>("h1") @[dut.scala 26:26]
      aInt[3].ready <= UInt<1>("h1") @[dut.scala 26:26]
      aInt[4].ready <= UInt<1>("h1") @[dut.scala 26:26]
      aInt[5].ready <= UInt<1>("h1") @[dut.scala 26:26]
    else :
      zInt.valid <= UInt<1>("h0") @[dut.scala 28:16]
      aInt[0].ready <= UInt<1>("h0") @[dut.scala 29:26]
      aInt[1].ready <= UInt<1>("h0") @[dut.scala 29:26]
      aInt[2].ready <= UInt<1>("h0") @[dut.scala 29:26]
      aInt[3].ready <= UInt<1>("h0") @[dut.scala 29:26]
      aInt[4].ready <= UInt<1>("h0") @[dut.scala 29:26]
      aInt[5].ready <= UInt<1>("h0") @[dut.scala 29:26]
    inst zDcout_tout of DCOutput_UInt8 @[DCOutput.scala 29:22]
    zDcout_tout.clock <= clock
    zDcout_tout.reset <= reset
    zDcout_tout.io.enq <= zInt @[DCOutput.scala 30:17]
    io.z.bits <= zDcout_tout.io.deq.bits @[dut.scala 34:8]
    io.z.valid <= zDcout_tout.io.deq.valid @[dut.scala 34:8]
    zDcout_tout.io.deq.ready <= io.z.ready @[dut.scala 34:8]

