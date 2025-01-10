circuit DcMcCrossbarUInt8_M2N2 :
  module DCMirror_UInt8_N2 :
    input clock : Clock
    input reset : Reset
    output io : { flip dst : UInt<2>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[DCMirror.scala 23:18]
    reg pValid : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[DCMirror.scala 24:23]
    node pReady = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[DCMirror.scala 26:27]
    node _nxtAccept_T_1 = neq(pValid, UInt<1>("h0")) @[DCMirror.scala 26:48]
    node _nxtAccept_T_2 = and(pValid, pReady) @[DCMirror.scala 26:69]
    node _nxtAccept_T_3 = eq(_nxtAccept_T_2, pValid) @[DCMirror.scala 26:79]
    node _nxtAccept_T_4 = and(_nxtAccept_T_1, _nxtAccept_T_3) @[DCMirror.scala 26:57]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_4) @[DCMirror.scala 26:36]
    when nxtAccept : @[DCMirror.scala 28:19]
      node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
      node _pValid_T_1 = mux(_pValid_T, UInt<2>("h3"), UInt<2>("h0")) @[Bitwise.scala 77:12]
      node _pValid_T_2 = and(_pValid_T_1, io.dst) @[DCMirror.scala 29:35]
      pValid <= _pValid_T_2 @[DCMirror.scala 29:12]
      pData <= io.c.bits @[DCMirror.scala 30:11]
    else :
      node _pValid_T_3 = not(pReady) @[DCMirror.scala 32:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[DCMirror.scala 32:22]
      pValid <= _pValid_T_4 @[DCMirror.scala 32:12]
    io.c.ready <= nxtAccept @[DCMirror.scala 34:14]
    io.p[0].bits <= pData @[DCMirror.scala 37:18]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[DCMirror.scala 38:28]
    io.p[0].valid <= _io_p_0_valid_T @[DCMirror.scala 38:19]
    io.p[1].bits <= pData @[DCMirror.scala 37:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[DCMirror.scala 38:28]
    io.p[1].valid <= _io_p_1_valid_T @[DCMirror.scala 38:19]

  module DCMirror_UInt8_N2_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip dst : UInt<2>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[DCMirror.scala 23:18]
    reg pValid : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[DCMirror.scala 24:23]
    node pReady = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[DCMirror.scala 26:27]
    node _nxtAccept_T_1 = neq(pValid, UInt<1>("h0")) @[DCMirror.scala 26:48]
    node _nxtAccept_T_2 = and(pValid, pReady) @[DCMirror.scala 26:69]
    node _nxtAccept_T_3 = eq(_nxtAccept_T_2, pValid) @[DCMirror.scala 26:79]
    node _nxtAccept_T_4 = and(_nxtAccept_T_1, _nxtAccept_T_3) @[DCMirror.scala 26:57]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_4) @[DCMirror.scala 26:36]
    when nxtAccept : @[DCMirror.scala 28:19]
      node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
      node _pValid_T_1 = mux(_pValid_T, UInt<2>("h3"), UInt<2>("h0")) @[Bitwise.scala 77:12]
      node _pValid_T_2 = and(_pValid_T_1, io.dst) @[DCMirror.scala 29:35]
      pValid <= _pValid_T_2 @[DCMirror.scala 29:12]
      pData <= io.c.bits @[DCMirror.scala 30:11]
    else :
      node _pValid_T_3 = not(pReady) @[DCMirror.scala 32:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[DCMirror.scala 32:22]
      pValid <= _pValid_T_4 @[DCMirror.scala 32:12]
    io.c.ready <= nxtAccept @[DCMirror.scala 34:14]
    io.p[0].bits <= pData @[DCMirror.scala 37:18]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[DCMirror.scala 38:28]
    io.p[0].valid <= _io_p_0_valid_T @[DCMirror.scala 38:19]
    io.p[1].bits <= pData @[DCMirror.scala 37:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[DCMirror.scala 38:28]
    io.p[1].valid <= _io_p_1_valid_T @[DCMirror.scala 38:19]

  module DCArbiter_UInt8 :
    input clock : Clock
    input reset : Reset
    output io : { flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2], p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, grant : UInt<2>}

    reg justGranted : UInt<2>, clock with :
      reset => (reset, UInt<2>("h1")) @[DCArbiter.scala 25:28]
    wire toBeGranted : UInt<2> @[DCArbiter.scala 26:25]
    wire nxtRRLocked : UInt<1> @[DCArbiter.scala 27:25]
    wire ioCValid : UInt<2> @[DCArbiter.scala 28:22]
    node _io_c_0_ready_T = bits(toBeGranted, 0, 0) @[DCArbiter.scala 31:33]
    node _io_c_0_ready_T_1 = and(_io_c_0_ready_T, io.p.ready) @[DCArbiter.scala 31:37]
    io.c[0].ready <= _io_c_0_ready_T_1 @[DCArbiter.scala 31:19]
    node _io_c_1_ready_T = bits(toBeGranted, 1, 1) @[DCArbiter.scala 31:33]
    node _io_c_1_ready_T_1 = and(_io_c_1_ready_T, io.p.ready) @[DCArbiter.scala 31:37]
    io.c[1].ready <= _io_c_1_ready_T_1 @[DCArbiter.scala 31:19]
    io.grant <= toBeGranted @[DCArbiter.scala 33:12]
    node _ioCValid_T = cat(io.c[1].valid, io.c[0].valid) @[Cat.scala 33:92]
    ioCValid <= _ioCValid_T @[DCArbiter.scala 63:12]
    node _io_p_valid_T = orr(ioCValid) @[DCArbiter.scala 65:26]
    io.p.valid <= _io_p_valid_T @[DCArbiter.scala 65:14]
    toBeGranted <= justGranted @[DCArbiter.scala 66:15]
    nxtRRLocked <= UInt<1>("h0") @[DCArbiter.scala 89:17]
    wire toBeGranted_mskReq : UInt<2> @[DCArbiter.scala 36:22]
    wire toBeGranted_tmpGrant : UInt<2> @[DCArbiter.scala 37:24]
    wire toBeGranted_tmpGrant2 : UInt<2> @[DCArbiter.scala 38:25]
    wire toBeGranted_rv : UInt<2> @[DCArbiter.scala 39:18]
    node _toBeGranted_mskReq_T = sub(justGranted, UInt<1>("h1")) @[DCArbiter.scala 41:38]
    node _toBeGranted_mskReq_T_1 = tail(_toBeGranted_mskReq_T, 1) @[DCArbiter.scala 41:38]
    node _toBeGranted_mskReq_T_2 = or(_toBeGranted_mskReq_T_1, justGranted) @[DCArbiter.scala 41:45]
    node _toBeGranted_mskReq_T_3 = not(_toBeGranted_mskReq_T_2) @[DCArbiter.scala 41:25]
    node _toBeGranted_mskReq_T_4 = and(ioCValid, _toBeGranted_mskReq_T_3) @[DCArbiter.scala 41:23]
    toBeGranted_mskReq <= _toBeGranted_mskReq_T_4 @[DCArbiter.scala 41:12]
    node _toBeGranted_tmpGrant_T = not(toBeGranted_mskReq) @[DCArbiter.scala 42:27]
    node _toBeGranted_tmpGrant_T_1 = add(_toBeGranted_tmpGrant_T, UInt<1>("h1")) @[DCArbiter.scala 42:35]
    node _toBeGranted_tmpGrant_T_2 = tail(_toBeGranted_tmpGrant_T_1, 1) @[DCArbiter.scala 42:35]
    node _toBeGranted_tmpGrant_T_3 = and(toBeGranted_mskReq, _toBeGranted_tmpGrant_T_2) @[DCArbiter.scala 42:24]
    toBeGranted_tmpGrant <= _toBeGranted_tmpGrant_T_3 @[DCArbiter.scala 42:14]
    node _toBeGranted_tmpGrant2_T = not(ioCValid) @[DCArbiter.scala 43:29]
    node _toBeGranted_tmpGrant2_T_1 = add(_toBeGranted_tmpGrant2_T, UInt<1>("h1")) @[DCArbiter.scala 43:38]
    node _toBeGranted_tmpGrant2_T_2 = tail(_toBeGranted_tmpGrant2_T_1, 1) @[DCArbiter.scala 43:38]
    node _toBeGranted_tmpGrant2_T_3 = and(ioCValid, _toBeGranted_tmpGrant2_T_2) @[DCArbiter.scala 43:26]
    toBeGranted_tmpGrant2 <= _toBeGranted_tmpGrant2_T_3 @[DCArbiter.scala 43:15]
    when io.p.ready : @[DCArbiter.scala 45:22]
      node _toBeGranted_T = neq(toBeGranted_mskReq, UInt<1>("h0")) @[DCArbiter.scala 46:19]
      when _toBeGranted_T : @[DCArbiter.scala 46:28]
        toBeGranted_rv <= toBeGranted_tmpGrant @[DCArbiter.scala 47:12]
      else :
        toBeGranted_rv <= toBeGranted_tmpGrant2 @[DCArbiter.scala 49:12]
    else :
      node _toBeGranted_T_1 = neq(ioCValid, UInt<1>("h0")) @[DCArbiter.scala 51:24]
      when _toBeGranted_T_1 : @[DCArbiter.scala 51:33]
        node _toBeGranted_T_2 = neq(toBeGranted_mskReq, UInt<1>("h0")) @[DCArbiter.scala 52:19]
        when _toBeGranted_T_2 : @[DCArbiter.scala 52:28]
          node _toBeGranted_rv_T = bits(toBeGranted_tmpGrant, 0, 0) @[DCArbiter.scala 53:27]
          node _toBeGranted_rv_T_1 = bits(toBeGranted_tmpGrant, 1, 1) @[DCArbiter.scala 53:40]
          node _toBeGranted_rv_T_2 = cat(_toBeGranted_rv_T, _toBeGranted_rv_T_1) @[Cat.scala 33:92]
          toBeGranted_rv <= _toBeGranted_rv_T_2 @[DCArbiter.scala 53:12]
        else :
          node _toBeGranted_rv_T_3 = bits(toBeGranted_tmpGrant2, 0, 0) @[DCArbiter.scala 55:28]
          node _toBeGranted_rv_T_4 = bits(toBeGranted_tmpGrant2, 1, 1) @[DCArbiter.scala 55:42]
          node _toBeGranted_rv_T_5 = cat(_toBeGranted_rv_T_3, _toBeGranted_rv_T_4) @[Cat.scala 33:92]
          toBeGranted_rv <= _toBeGranted_rv_T_5 @[DCArbiter.scala 55:12]
      else :
        toBeGranted_rv <= justGranted @[DCArbiter.scala 58:10]
    toBeGranted <= toBeGranted_rv @[DCArbiter.scala 90:17]
    node _T = neq(toBeGranted, UInt<1>("h0")) @[DCArbiter.scala 93:20]
    when _T : @[DCArbiter.scala 93:29]
      justGranted <= toBeGranted @[DCArbiter.scala 94:17]
    io.p.bits <= io.c[0].bits @[DCArbiter.scala 97:13]
    node _T_1 = bits(toBeGranted, 0, 0) @[DCArbiter.scala 99:21]
    when _T_1 : @[DCArbiter.scala 99:26]
      io.p.bits <= io.c[0].bits @[DCArbiter.scala 100:17]
    node _T_2 = bits(toBeGranted, 1, 1) @[DCArbiter.scala 99:21]
    when _T_2 : @[DCArbiter.scala 99:26]
      io.p.bits <= io.c[1].bits @[DCArbiter.scala 100:17]


  module DCArbiter_UInt8_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2], p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, grant : UInt<2>}

    reg justGranted : UInt<2>, clock with :
      reset => (reset, UInt<2>("h1")) @[DCArbiter.scala 25:28]
    wire toBeGranted : UInt<2> @[DCArbiter.scala 26:25]
    wire nxtRRLocked : UInt<1> @[DCArbiter.scala 27:25]
    wire ioCValid : UInt<2> @[DCArbiter.scala 28:22]
    node _io_c_0_ready_T = bits(toBeGranted, 0, 0) @[DCArbiter.scala 31:33]
    node _io_c_0_ready_T_1 = and(_io_c_0_ready_T, io.p.ready) @[DCArbiter.scala 31:37]
    io.c[0].ready <= _io_c_0_ready_T_1 @[DCArbiter.scala 31:19]
    node _io_c_1_ready_T = bits(toBeGranted, 1, 1) @[DCArbiter.scala 31:33]
    node _io_c_1_ready_T_1 = and(_io_c_1_ready_T, io.p.ready) @[DCArbiter.scala 31:37]
    io.c[1].ready <= _io_c_1_ready_T_1 @[DCArbiter.scala 31:19]
    io.grant <= toBeGranted @[DCArbiter.scala 33:12]
    node _ioCValid_T = cat(io.c[1].valid, io.c[0].valid) @[Cat.scala 33:92]
    ioCValid <= _ioCValid_T @[DCArbiter.scala 63:12]
    node _io_p_valid_T = orr(ioCValid) @[DCArbiter.scala 65:26]
    io.p.valid <= _io_p_valid_T @[DCArbiter.scala 65:14]
    toBeGranted <= justGranted @[DCArbiter.scala 66:15]
    nxtRRLocked <= UInt<1>("h0") @[DCArbiter.scala 89:17]
    wire toBeGranted_mskReq : UInt<2> @[DCArbiter.scala 36:22]
    wire toBeGranted_tmpGrant : UInt<2> @[DCArbiter.scala 37:24]
    wire toBeGranted_tmpGrant2 : UInt<2> @[DCArbiter.scala 38:25]
    wire toBeGranted_rv : UInt<2> @[DCArbiter.scala 39:18]
    node _toBeGranted_mskReq_T = sub(justGranted, UInt<1>("h1")) @[DCArbiter.scala 41:38]
    node _toBeGranted_mskReq_T_1 = tail(_toBeGranted_mskReq_T, 1) @[DCArbiter.scala 41:38]
    node _toBeGranted_mskReq_T_2 = or(_toBeGranted_mskReq_T_1, justGranted) @[DCArbiter.scala 41:45]
    node _toBeGranted_mskReq_T_3 = not(_toBeGranted_mskReq_T_2) @[DCArbiter.scala 41:25]
    node _toBeGranted_mskReq_T_4 = and(ioCValid, _toBeGranted_mskReq_T_3) @[DCArbiter.scala 41:23]
    toBeGranted_mskReq <= _toBeGranted_mskReq_T_4 @[DCArbiter.scala 41:12]
    node _toBeGranted_tmpGrant_T = not(toBeGranted_mskReq) @[DCArbiter.scala 42:27]
    node _toBeGranted_tmpGrant_T_1 = add(_toBeGranted_tmpGrant_T, UInt<1>("h1")) @[DCArbiter.scala 42:35]
    node _toBeGranted_tmpGrant_T_2 = tail(_toBeGranted_tmpGrant_T_1, 1) @[DCArbiter.scala 42:35]
    node _toBeGranted_tmpGrant_T_3 = and(toBeGranted_mskReq, _toBeGranted_tmpGrant_T_2) @[DCArbiter.scala 42:24]
    toBeGranted_tmpGrant <= _toBeGranted_tmpGrant_T_3 @[DCArbiter.scala 42:14]
    node _toBeGranted_tmpGrant2_T = not(ioCValid) @[DCArbiter.scala 43:29]
    node _toBeGranted_tmpGrant2_T_1 = add(_toBeGranted_tmpGrant2_T, UInt<1>("h1")) @[DCArbiter.scala 43:38]
    node _toBeGranted_tmpGrant2_T_2 = tail(_toBeGranted_tmpGrant2_T_1, 1) @[DCArbiter.scala 43:38]
    node _toBeGranted_tmpGrant2_T_3 = and(ioCValid, _toBeGranted_tmpGrant2_T_2) @[DCArbiter.scala 43:26]
    toBeGranted_tmpGrant2 <= _toBeGranted_tmpGrant2_T_3 @[DCArbiter.scala 43:15]
    when io.p.ready : @[DCArbiter.scala 45:22]
      node _toBeGranted_T = neq(toBeGranted_mskReq, UInt<1>("h0")) @[DCArbiter.scala 46:19]
      when _toBeGranted_T : @[DCArbiter.scala 46:28]
        toBeGranted_rv <= toBeGranted_tmpGrant @[DCArbiter.scala 47:12]
      else :
        toBeGranted_rv <= toBeGranted_tmpGrant2 @[DCArbiter.scala 49:12]
    else :
      node _toBeGranted_T_1 = neq(ioCValid, UInt<1>("h0")) @[DCArbiter.scala 51:24]
      when _toBeGranted_T_1 : @[DCArbiter.scala 51:33]
        node _toBeGranted_T_2 = neq(toBeGranted_mskReq, UInt<1>("h0")) @[DCArbiter.scala 52:19]
        when _toBeGranted_T_2 : @[DCArbiter.scala 52:28]
          node _toBeGranted_rv_T = bits(toBeGranted_tmpGrant, 0, 0) @[DCArbiter.scala 53:27]
          node _toBeGranted_rv_T_1 = bits(toBeGranted_tmpGrant, 1, 1) @[DCArbiter.scala 53:40]
          node _toBeGranted_rv_T_2 = cat(_toBeGranted_rv_T, _toBeGranted_rv_T_1) @[Cat.scala 33:92]
          toBeGranted_rv <= _toBeGranted_rv_T_2 @[DCArbiter.scala 53:12]
        else :
          node _toBeGranted_rv_T_3 = bits(toBeGranted_tmpGrant2, 0, 0) @[DCArbiter.scala 55:28]
          node _toBeGranted_rv_T_4 = bits(toBeGranted_tmpGrant2, 1, 1) @[DCArbiter.scala 55:42]
          node _toBeGranted_rv_T_5 = cat(_toBeGranted_rv_T_3, _toBeGranted_rv_T_4) @[Cat.scala 33:92]
          toBeGranted_rv <= _toBeGranted_rv_T_5 @[DCArbiter.scala 55:12]
      else :
        toBeGranted_rv <= justGranted @[DCArbiter.scala 58:10]
    toBeGranted <= toBeGranted_rv @[DCArbiter.scala 90:17]
    node _T = neq(toBeGranted, UInt<1>("h0")) @[DCArbiter.scala 93:20]
    when _T : @[DCArbiter.scala 93:29]
      justGranted <= toBeGranted @[DCArbiter.scala 94:17]
    io.p.bits <= io.c[0].bits @[DCArbiter.scala 97:13]
    node _T_1 = bits(toBeGranted, 0, 0) @[DCArbiter.scala 99:21]
    when _T_1 : @[DCArbiter.scala 99:26]
      io.p.bits <= io.c[0].bits @[DCArbiter.scala 100:17]
    node _T_2 = bits(toBeGranted, 1, 1) @[DCArbiter.scala 99:21]
    when _T_2 : @[DCArbiter.scala 99:26]
      io.p.bits <= io.c[1].bits @[DCArbiter.scala 100:17]


  module DcMcCrossbarUInt8_M2N2 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<2>[2], flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2], p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[2]}

    inst demuxList_0 of DCMirror_UInt8_N2 @[golden.scala 19:59]
    demuxList_0.clock <= clock
    demuxList_0.reset <= reset
    inst demuxList_1 of DCMirror_UInt8_N2_1 @[golden.scala 19:59]
    demuxList_1.clock <= clock
    demuxList_1.reset <= reset
    inst arbList_0 of DCArbiter_UInt8 @[golden.scala 20:58]
    arbList_0.clock <= clock
    arbList_0.reset <= reset
    inst arbList_1 of DCArbiter_UInt8_1 @[golden.scala 20:58]
    arbList_1.clock <= clock
    arbList_1.reset <= reset
    demuxList_0.io.c <= io.c[0] @[golden.scala 22:25]
    demuxList_0.io.dst <= io.sel[0] @[golden.scala 23:27]
    arbList_0.io.c[0] <= demuxList_0.io.p[0] @[golden.scala 26:30]
    arbList_1.io.c[0] <= demuxList_0.io.p[1] @[golden.scala 26:30]
    demuxList_1.io.c <= io.c[1] @[golden.scala 22:25]
    demuxList_1.io.dst <= io.sel[1] @[golden.scala 23:27]
    arbList_0.io.c[1] <= demuxList_1.io.p[0] @[golden.scala 26:30]
    arbList_1.io.c[1] <= demuxList_1.io.p[1] @[golden.scala 26:30]
    io.p[0].bits <= arbList_0.io.p.bits @[golden.scala 30:23]
    io.p[0].valid <= arbList_0.io.p.valid @[golden.scala 30:23]
    arbList_0.io.p.ready <= io.p[0].ready @[golden.scala 30:23]
    io.p[1].bits <= arbList_1.io.p.bits @[golden.scala 30:23]
    io.p[1].valid <= arbList_1.io.p.valid @[golden.scala 30:23]
    arbList_1.io.p.ready <= io.p[1].ready @[golden.scala 30:23]

