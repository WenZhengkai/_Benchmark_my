circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    wire _btb_table_WIRE : UInt<2>[16] @[dut.scala 14:34]
    _btb_table_WIRE[0] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[1] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[2] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[3] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[4] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[5] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[6] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[7] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[8] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[9] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[10] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[11] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[12] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[13] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[14] <= UInt<2>("h0") @[dut.scala 14:34]
    _btb_table_WIRE[15] <= UInt<2>("h0") @[dut.scala 14:34]
    reg btb_table : UInt<2>[16], clock with :
      reset => (reset, _btb_table_WIRE) @[dut.scala 14:26]
    node pred_index = bits(io.pc, 5, 2) @[dut.scala 25:25]
    node _io_btb_taken_T = geq(btb_table[pred_index], UInt<2>("h2")) @[dut.scala 27:36]
    node _io_btb_taken_T_1 = mux(_io_btb_taken_T, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 27:22]
    io.btb_taken <= _io_btb_taken_T_1 @[dut.scala 27:16]
    node update_index = bits(io.mem_pc, 5, 2) @[dut.scala 30:31]
    node _T = eq(io.branch, UInt<1>("h1")) @[dut.scala 31:18]
    when _T : @[dut.scala 31:27]
      node _updated_counter_T = eq(io.pcsrc, UInt<1>("h1")) @[dut.scala 33:67]
      node _updated_counter_T_1 = eq(btb_table[update_index], UInt<2>("h3")) @[dut.scala 19:15]
      node _updated_counter_T_2 = add(btb_table[update_index], UInt<1>("h1")) @[dut.scala 19:33]
      node _updated_counter_T_3 = tail(_updated_counter_T_2, 1) @[dut.scala 19:33]
      node _updated_counter_T_4 = mux(_updated_counter_T_1, UInt<2>("h3"), _updated_counter_T_3) @[dut.scala 19:10]
      node _updated_counter_T_5 = eq(btb_table[update_index], UInt<1>("h0")) @[dut.scala 20:15]
      node _updated_counter_T_6 = sub(btb_table[update_index], UInt<1>("h1")) @[dut.scala 20:33]
      node _updated_counter_T_7 = tail(_updated_counter_T_6, 1) @[dut.scala 20:33]
      node _updated_counter_T_8 = mux(_updated_counter_T_5, UInt<1>("h0"), _updated_counter_T_7) @[dut.scala 20:10]
      node updated_counter = mux(_updated_counter_T, _updated_counter_T_4, _updated_counter_T_8) @[dut.scala 18:8]
      btb_table[update_index] <= updated_counter @[dut.scala 34:29]


