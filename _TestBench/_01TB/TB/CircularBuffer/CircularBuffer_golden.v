module CircularBuffer_golden(
  input          clock,
  input          reset,
  input          io_enq,
  input          io_deq,
  output         io_full,
  output         io_empty,
  output [31:0]  io_head,
  output [127:0] io_tail
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [127:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] head; // @[fetch-buffer.scala 17:21]
  reg [127:0] tail; // @[fetch-buffer.scala 18:21]
  reg  maybe_full; // @[fetch-buffer.scala 20:27]
  wire [127:0] _might_hit_head_T_2 = {tail[126:0],tail[127]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo = {_might_hit_head_T_2[28],_might_hit_head_T_2[24],_might_hit_head_T_2[20],
    _might_hit_head_T_2[16],_might_hit_head_T_2[12],_might_hit_head_T_2[8],_might_hit_head_T_2[4],_might_hit_head_T_2[0]
    }; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo = {_might_hit_head_T_2[60],_might_hit_head_T_2[56],_might_hit_head_T_2[52],
    _might_hit_head_T_2[48],_might_hit_head_T_2[44],_might_hit_head_T_2[40],_might_hit_head_T_2[36],_might_hit_head_T_2[
    32],might_hit_head_lo_lo}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo = {_might_hit_head_T_2[92],_might_hit_head_T_2[88],_might_hit_head_T_2[84],
    _might_hit_head_T_2[80],_might_hit_head_T_2[76],_might_hit_head_T_2[72],_might_hit_head_T_2[68],_might_hit_head_T_2[
    64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_131 = {_might_hit_head_T_2[124],_might_hit_head_T_2[120],_might_hit_head_T_2[116],
    _might_hit_head_T_2[112],_might_hit_head_T_2[108],_might_hit_head_T_2[104],_might_hit_head_T_2[100],
    _might_hit_head_T_2[96],might_hit_head_hi_lo,might_hit_head_lo}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_134 = {tail[125:0],tail[127:126]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_1 = {_might_hit_head_T_134[28],_might_hit_head_T_134[24],_might_hit_head_T_134[20],
    _might_hit_head_T_134[16],_might_hit_head_T_134[12],_might_hit_head_T_134[8],_might_hit_head_T_134[4],
    _might_hit_head_T_134[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_1 = {_might_hit_head_T_134[60],_might_hit_head_T_134[56],_might_hit_head_T_134[52],
    _might_hit_head_T_134[48],_might_hit_head_T_134[44],_might_hit_head_T_134[40],_might_hit_head_T_134[36],
    _might_hit_head_T_134[32],might_hit_head_lo_lo_1}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_1 = {_might_hit_head_T_134[92],_might_hit_head_T_134[88],_might_hit_head_T_134[84],
    _might_hit_head_T_134[80],_might_hit_head_T_134[76],_might_hit_head_T_134[72],_might_hit_head_T_134[68],
    _might_hit_head_T_134[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_263 = {_might_hit_head_T_134[124],_might_hit_head_T_134[120],_might_hit_head_T_134[116],
    _might_hit_head_T_134[112],_might_hit_head_T_134[108],_might_hit_head_T_134[104],_might_hit_head_T_134[100],
    _might_hit_head_T_134[96],might_hit_head_hi_lo_1,might_hit_head_lo_1}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_266 = {tail[124:0],tail[127:125]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_2 = {_might_hit_head_T_266[28],_might_hit_head_T_266[24],_might_hit_head_T_266[20],
    _might_hit_head_T_266[16],_might_hit_head_T_266[12],_might_hit_head_T_266[8],_might_hit_head_T_266[4],
    _might_hit_head_T_266[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_2 = {_might_hit_head_T_266[60],_might_hit_head_T_266[56],_might_hit_head_T_266[52],
    _might_hit_head_T_266[48],_might_hit_head_T_266[44],_might_hit_head_T_266[40],_might_hit_head_T_266[36],
    _might_hit_head_T_266[32],might_hit_head_lo_lo_2}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_2 = {_might_hit_head_T_266[92],_might_hit_head_T_266[88],_might_hit_head_T_266[84],
    _might_hit_head_T_266[80],_might_hit_head_T_266[76],_might_hit_head_T_266[72],_might_hit_head_T_266[68],
    _might_hit_head_T_266[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_395 = {_might_hit_head_T_266[124],_might_hit_head_T_266[120],_might_hit_head_T_266[116],
    _might_hit_head_T_266[112],_might_hit_head_T_266[108],_might_hit_head_T_266[104],_might_hit_head_T_266[100],
    _might_hit_head_T_266[96],might_hit_head_hi_lo_2,might_hit_head_lo_2}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_398 = {tail[123:0],tail[127:124]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_3 = {_might_hit_head_T_398[28],_might_hit_head_T_398[24],_might_hit_head_T_398[20],
    _might_hit_head_T_398[16],_might_hit_head_T_398[12],_might_hit_head_T_398[8],_might_hit_head_T_398[4],
    _might_hit_head_T_398[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_3 = {_might_hit_head_T_398[60],_might_hit_head_T_398[56],_might_hit_head_T_398[52],
    _might_hit_head_T_398[48],_might_hit_head_T_398[44],_might_hit_head_T_398[40],_might_hit_head_T_398[36],
    _might_hit_head_T_398[32],might_hit_head_lo_lo_3}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_3 = {_might_hit_head_T_398[92],_might_hit_head_T_398[88],_might_hit_head_T_398[84],
    _might_hit_head_T_398[80],_might_hit_head_T_398[76],_might_hit_head_T_398[72],_might_hit_head_T_398[68],
    _might_hit_head_T_398[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_527 = {_might_hit_head_T_398[124],_might_hit_head_T_398[120],_might_hit_head_T_398[116],
    _might_hit_head_T_398[112],_might_hit_head_T_398[108],_might_hit_head_T_398[104],_might_hit_head_T_398[100],
    _might_hit_head_T_398[96],might_hit_head_hi_lo_3,might_hit_head_lo_3}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_530 = {tail[122:0],tail[127:123]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_4 = {_might_hit_head_T_530[28],_might_hit_head_T_530[24],_might_hit_head_T_530[20],
    _might_hit_head_T_530[16],_might_hit_head_T_530[12],_might_hit_head_T_530[8],_might_hit_head_T_530[4],
    _might_hit_head_T_530[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_4 = {_might_hit_head_T_530[60],_might_hit_head_T_530[56],_might_hit_head_T_530[52],
    _might_hit_head_T_530[48],_might_hit_head_T_530[44],_might_hit_head_T_530[40],_might_hit_head_T_530[36],
    _might_hit_head_T_530[32],might_hit_head_lo_lo_4}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_4 = {_might_hit_head_T_530[92],_might_hit_head_T_530[88],_might_hit_head_T_530[84],
    _might_hit_head_T_530[80],_might_hit_head_T_530[76],_might_hit_head_T_530[72],_might_hit_head_T_530[68],
    _might_hit_head_T_530[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_659 = {_might_hit_head_T_530[124],_might_hit_head_T_530[120],_might_hit_head_T_530[116],
    _might_hit_head_T_530[112],_might_hit_head_T_530[108],_might_hit_head_T_530[104],_might_hit_head_T_530[100],
    _might_hit_head_T_530[96],might_hit_head_hi_lo_4,might_hit_head_lo_4}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_662 = {tail[121:0],tail[127:122]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_5 = {_might_hit_head_T_662[28],_might_hit_head_T_662[24],_might_hit_head_T_662[20],
    _might_hit_head_T_662[16],_might_hit_head_T_662[12],_might_hit_head_T_662[8],_might_hit_head_T_662[4],
    _might_hit_head_T_662[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_5 = {_might_hit_head_T_662[60],_might_hit_head_T_662[56],_might_hit_head_T_662[52],
    _might_hit_head_T_662[48],_might_hit_head_T_662[44],_might_hit_head_T_662[40],_might_hit_head_T_662[36],
    _might_hit_head_T_662[32],might_hit_head_lo_lo_5}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_5 = {_might_hit_head_T_662[92],_might_hit_head_T_662[88],_might_hit_head_T_662[84],
    _might_hit_head_T_662[80],_might_hit_head_T_662[76],_might_hit_head_T_662[72],_might_hit_head_T_662[68],
    _might_hit_head_T_662[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_791 = {_might_hit_head_T_662[124],_might_hit_head_T_662[120],_might_hit_head_T_662[116],
    _might_hit_head_T_662[112],_might_hit_head_T_662[108],_might_hit_head_T_662[104],_might_hit_head_T_662[100],
    _might_hit_head_T_662[96],might_hit_head_hi_lo_5,might_hit_head_lo_5}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_794 = {tail[120:0],tail[127:121]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_6 = {_might_hit_head_T_794[28],_might_hit_head_T_794[24],_might_hit_head_T_794[20],
    _might_hit_head_T_794[16],_might_hit_head_T_794[12],_might_hit_head_T_794[8],_might_hit_head_T_794[4],
    _might_hit_head_T_794[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_6 = {_might_hit_head_T_794[60],_might_hit_head_T_794[56],_might_hit_head_T_794[52],
    _might_hit_head_T_794[48],_might_hit_head_T_794[44],_might_hit_head_T_794[40],_might_hit_head_T_794[36],
    _might_hit_head_T_794[32],might_hit_head_lo_lo_6}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_6 = {_might_hit_head_T_794[92],_might_hit_head_T_794[88],_might_hit_head_T_794[84],
    _might_hit_head_T_794[80],_might_hit_head_T_794[76],_might_hit_head_T_794[72],_might_hit_head_T_794[68],
    _might_hit_head_T_794[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_923 = {_might_hit_head_T_794[124],_might_hit_head_T_794[120],_might_hit_head_T_794[116],
    _might_hit_head_T_794[112],_might_hit_head_T_794[108],_might_hit_head_T_794[104],_might_hit_head_T_794[100],
    _might_hit_head_T_794[96],might_hit_head_hi_lo_6,might_hit_head_lo_6}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_926 = {tail[119:0],tail[127:120]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_7 = {_might_hit_head_T_926[28],_might_hit_head_T_926[24],_might_hit_head_T_926[20],
    _might_hit_head_T_926[16],_might_hit_head_T_926[12],_might_hit_head_T_926[8],_might_hit_head_T_926[4],
    _might_hit_head_T_926[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_7 = {_might_hit_head_T_926[60],_might_hit_head_T_926[56],_might_hit_head_T_926[52],
    _might_hit_head_T_926[48],_might_hit_head_T_926[44],_might_hit_head_T_926[40],_might_hit_head_T_926[36],
    _might_hit_head_T_926[32],might_hit_head_lo_lo_7}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_7 = {_might_hit_head_T_926[92],_might_hit_head_T_926[88],_might_hit_head_T_926[84],
    _might_hit_head_T_926[80],_might_hit_head_T_926[76],_might_hit_head_T_926[72],_might_hit_head_T_926[68],
    _might_hit_head_T_926[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1055 = {_might_hit_head_T_926[124],_might_hit_head_T_926[120],_might_hit_head_T_926[116]
    ,_might_hit_head_T_926[112],_might_hit_head_T_926[108],_might_hit_head_T_926[104],_might_hit_head_T_926[100],
    _might_hit_head_T_926[96],might_hit_head_hi_lo_7,might_hit_head_lo_7}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1058 = {tail[118:0],tail[127:119]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_8 = {_might_hit_head_T_1058[28],_might_hit_head_T_1058[24],_might_hit_head_T_1058[20],
    _might_hit_head_T_1058[16],_might_hit_head_T_1058[12],_might_hit_head_T_1058[8],_might_hit_head_T_1058[4],
    _might_hit_head_T_1058[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_8 = {_might_hit_head_T_1058[60],_might_hit_head_T_1058[56],_might_hit_head_T_1058[52],
    _might_hit_head_T_1058[48],_might_hit_head_T_1058[44],_might_hit_head_T_1058[40],_might_hit_head_T_1058[36],
    _might_hit_head_T_1058[32],might_hit_head_lo_lo_8}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_8 = {_might_hit_head_T_1058[92],_might_hit_head_T_1058[88],_might_hit_head_T_1058[84],
    _might_hit_head_T_1058[80],_might_hit_head_T_1058[76],_might_hit_head_T_1058[72],_might_hit_head_T_1058[68],
    _might_hit_head_T_1058[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1187 = {_might_hit_head_T_1058[124],_might_hit_head_T_1058[120],_might_hit_head_T_1058[
    116],_might_hit_head_T_1058[112],_might_hit_head_T_1058[108],_might_hit_head_T_1058[104],_might_hit_head_T_1058[100]
    ,_might_hit_head_T_1058[96],might_hit_head_hi_lo_8,might_hit_head_lo_8}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1190 = {tail[117:0],tail[127:118]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_9 = {_might_hit_head_T_1190[28],_might_hit_head_T_1190[24],_might_hit_head_T_1190[20],
    _might_hit_head_T_1190[16],_might_hit_head_T_1190[12],_might_hit_head_T_1190[8],_might_hit_head_T_1190[4],
    _might_hit_head_T_1190[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_9 = {_might_hit_head_T_1190[60],_might_hit_head_T_1190[56],_might_hit_head_T_1190[52],
    _might_hit_head_T_1190[48],_might_hit_head_T_1190[44],_might_hit_head_T_1190[40],_might_hit_head_T_1190[36],
    _might_hit_head_T_1190[32],might_hit_head_lo_lo_9}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_9 = {_might_hit_head_T_1190[92],_might_hit_head_T_1190[88],_might_hit_head_T_1190[84],
    _might_hit_head_T_1190[80],_might_hit_head_T_1190[76],_might_hit_head_T_1190[72],_might_hit_head_T_1190[68],
    _might_hit_head_T_1190[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1319 = {_might_hit_head_T_1190[124],_might_hit_head_T_1190[120],_might_hit_head_T_1190[
    116],_might_hit_head_T_1190[112],_might_hit_head_T_1190[108],_might_hit_head_T_1190[104],_might_hit_head_T_1190[100]
    ,_might_hit_head_T_1190[96],might_hit_head_hi_lo_9,might_hit_head_lo_9}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1322 = {tail[116:0],tail[127:117]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_10 = {_might_hit_head_T_1322[28],_might_hit_head_T_1322[24],_might_hit_head_T_1322[20]
    ,_might_hit_head_T_1322[16],_might_hit_head_T_1322[12],_might_hit_head_T_1322[8],_might_hit_head_T_1322[4],
    _might_hit_head_T_1322[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_10 = {_might_hit_head_T_1322[60],_might_hit_head_T_1322[56],_might_hit_head_T_1322[52],
    _might_hit_head_T_1322[48],_might_hit_head_T_1322[44],_might_hit_head_T_1322[40],_might_hit_head_T_1322[36],
    _might_hit_head_T_1322[32],might_hit_head_lo_lo_10}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_10 = {_might_hit_head_T_1322[92],_might_hit_head_T_1322[88],_might_hit_head_T_1322[84]
    ,_might_hit_head_T_1322[80],_might_hit_head_T_1322[76],_might_hit_head_T_1322[72],_might_hit_head_T_1322[68],
    _might_hit_head_T_1322[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1451 = {_might_hit_head_T_1322[124],_might_hit_head_T_1322[120],_might_hit_head_T_1322[
    116],_might_hit_head_T_1322[112],_might_hit_head_T_1322[108],_might_hit_head_T_1322[104],_might_hit_head_T_1322[100]
    ,_might_hit_head_T_1322[96],might_hit_head_hi_lo_10,might_hit_head_lo_10}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1454 = {tail[115:0],tail[127:116]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_11 = {_might_hit_head_T_1454[28],_might_hit_head_T_1454[24],_might_hit_head_T_1454[20]
    ,_might_hit_head_T_1454[16],_might_hit_head_T_1454[12],_might_hit_head_T_1454[8],_might_hit_head_T_1454[4],
    _might_hit_head_T_1454[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_11 = {_might_hit_head_T_1454[60],_might_hit_head_T_1454[56],_might_hit_head_T_1454[52],
    _might_hit_head_T_1454[48],_might_hit_head_T_1454[44],_might_hit_head_T_1454[40],_might_hit_head_T_1454[36],
    _might_hit_head_T_1454[32],might_hit_head_lo_lo_11}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_11 = {_might_hit_head_T_1454[92],_might_hit_head_T_1454[88],_might_hit_head_T_1454[84]
    ,_might_hit_head_T_1454[80],_might_hit_head_T_1454[76],_might_hit_head_T_1454[72],_might_hit_head_T_1454[68],
    _might_hit_head_T_1454[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1583 = {_might_hit_head_T_1454[124],_might_hit_head_T_1454[120],_might_hit_head_T_1454[
    116],_might_hit_head_T_1454[112],_might_hit_head_T_1454[108],_might_hit_head_T_1454[104],_might_hit_head_T_1454[100]
    ,_might_hit_head_T_1454[96],might_hit_head_hi_lo_11,might_hit_head_lo_11}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1586 = {tail[114:0],tail[127:115]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_12 = {_might_hit_head_T_1586[28],_might_hit_head_T_1586[24],_might_hit_head_T_1586[20]
    ,_might_hit_head_T_1586[16],_might_hit_head_T_1586[12],_might_hit_head_T_1586[8],_might_hit_head_T_1586[4],
    _might_hit_head_T_1586[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_12 = {_might_hit_head_T_1586[60],_might_hit_head_T_1586[56],_might_hit_head_T_1586[52],
    _might_hit_head_T_1586[48],_might_hit_head_T_1586[44],_might_hit_head_T_1586[40],_might_hit_head_T_1586[36],
    _might_hit_head_T_1586[32],might_hit_head_lo_lo_12}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_12 = {_might_hit_head_T_1586[92],_might_hit_head_T_1586[88],_might_hit_head_T_1586[84]
    ,_might_hit_head_T_1586[80],_might_hit_head_T_1586[76],_might_hit_head_T_1586[72],_might_hit_head_T_1586[68],
    _might_hit_head_T_1586[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1715 = {_might_hit_head_T_1586[124],_might_hit_head_T_1586[120],_might_hit_head_T_1586[
    116],_might_hit_head_T_1586[112],_might_hit_head_T_1586[108],_might_hit_head_T_1586[104],_might_hit_head_T_1586[100]
    ,_might_hit_head_T_1586[96],might_hit_head_hi_lo_12,might_hit_head_lo_12}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1718 = {tail[113:0],tail[127:114]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_13 = {_might_hit_head_T_1718[28],_might_hit_head_T_1718[24],_might_hit_head_T_1718[20]
    ,_might_hit_head_T_1718[16],_might_hit_head_T_1718[12],_might_hit_head_T_1718[8],_might_hit_head_T_1718[4],
    _might_hit_head_T_1718[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_13 = {_might_hit_head_T_1718[60],_might_hit_head_T_1718[56],_might_hit_head_T_1718[52],
    _might_hit_head_T_1718[48],_might_hit_head_T_1718[44],_might_hit_head_T_1718[40],_might_hit_head_T_1718[36],
    _might_hit_head_T_1718[32],might_hit_head_lo_lo_13}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_13 = {_might_hit_head_T_1718[92],_might_hit_head_T_1718[88],_might_hit_head_T_1718[84]
    ,_might_hit_head_T_1718[80],_might_hit_head_T_1718[76],_might_hit_head_T_1718[72],_might_hit_head_T_1718[68],
    _might_hit_head_T_1718[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1847 = {_might_hit_head_T_1718[124],_might_hit_head_T_1718[120],_might_hit_head_T_1718[
    116],_might_hit_head_T_1718[112],_might_hit_head_T_1718[108],_might_hit_head_T_1718[104],_might_hit_head_T_1718[100]
    ,_might_hit_head_T_1718[96],might_hit_head_hi_lo_13,might_hit_head_lo_13}; // @[fetch-buffer.scala 29:65]
  wire [127:0] _might_hit_head_T_1850 = {tail[112:0],tail[127:113]}; // @[Cat.scala 33:92]
  wire [7:0] might_hit_head_lo_lo_14 = {_might_hit_head_T_1850[28],_might_hit_head_T_1850[24],_might_hit_head_T_1850[20]
    ,_might_hit_head_T_1850[16],_might_hit_head_T_1850[12],_might_hit_head_T_1850[8],_might_hit_head_T_1850[4],
    _might_hit_head_T_1850[0]}; // @[fetch-buffer.scala 29:65]
  wire [15:0] might_hit_head_lo_14 = {_might_hit_head_T_1850[60],_might_hit_head_T_1850[56],_might_hit_head_T_1850[52],
    _might_hit_head_T_1850[48],_might_hit_head_T_1850[44],_might_hit_head_T_1850[40],_might_hit_head_T_1850[36],
    _might_hit_head_T_1850[32],might_hit_head_lo_lo_14}; // @[fetch-buffer.scala 29:65]
  wire [7:0] might_hit_head_hi_lo_14 = {_might_hit_head_T_1850[92],_might_hit_head_T_1850[88],_might_hit_head_T_1850[84]
    ,_might_hit_head_T_1850[80],_might_hit_head_T_1850[76],_might_hit_head_T_1850[72],_might_hit_head_T_1850[68],
    _might_hit_head_T_1850[64]}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1979 = {_might_hit_head_T_1850[124],_might_hit_head_T_1850[120],_might_hit_head_T_1850[
    116],_might_hit_head_T_1850[112],_might_hit_head_T_1850[108],_might_hit_head_T_1850[104],_might_hit_head_T_1850[100]
    ,_might_hit_head_T_1850[96],might_hit_head_hi_lo_14,might_hit_head_lo_14}; // @[fetch-buffer.scala 29:65]
  wire [31:0] _might_hit_head_T_1980 = head & _might_hit_head_T_131; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1981 = head & _might_hit_head_T_263; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1982 = head & _might_hit_head_T_395; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1983 = head & _might_hit_head_T_527; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1984 = head & _might_hit_head_T_659; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1985 = head & _might_hit_head_T_791; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1986 = head & _might_hit_head_T_923; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1987 = head & _might_hit_head_T_1055; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1988 = head & _might_hit_head_T_1187; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1989 = head & _might_hit_head_T_1319; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1990 = head & _might_hit_head_T_1451; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1991 = head & _might_hit_head_T_1583; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1992 = head & _might_hit_head_T_1715; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1993 = head & _might_hit_head_T_1847; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1994 = head & _might_hit_head_T_1979; // @[fetch-buffer.scala 30:22]
  wire [31:0] _might_hit_head_T_1995 = _might_hit_head_T_1980 | _might_hit_head_T_1981; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_1996 = _might_hit_head_T_1995 | _might_hit_head_T_1982; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_1997 = _might_hit_head_T_1996 | _might_hit_head_T_1983; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_1998 = _might_hit_head_T_1997 | _might_hit_head_T_1984; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_1999 = _might_hit_head_T_1998 | _might_hit_head_T_1985; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2000 = _might_hit_head_T_1999 | _might_hit_head_T_1986; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2001 = _might_hit_head_T_2000 | _might_hit_head_T_1987; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2002 = _might_hit_head_T_2001 | _might_hit_head_T_1988; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2003 = _might_hit_head_T_2002 | _might_hit_head_T_1989; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2004 = _might_hit_head_T_2003 | _might_hit_head_T_1990; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2005 = _might_hit_head_T_2004 | _might_hit_head_T_1991; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2006 = _might_hit_head_T_2005 | _might_hit_head_T_1992; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2007 = _might_hit_head_T_2006 | _might_hit_head_T_1993; // @[fetch-buffer.scala 30:38]
  wire [31:0] _might_hit_head_T_2008 = _might_hit_head_T_2007 | _might_hit_head_T_1994; // @[fetch-buffer.scala 30:38]
  wire  might_hit_head = |_might_hit_head_T_2008; // @[fetch-buffer.scala 30:42]
  wire [7:0] at_head_lo_lo = {tail[28],tail[24],tail[20],tail[16],tail[12],tail[8],tail[4],tail[0]}; // @[fetch-buffer.scala 33:29]
  wire [15:0] at_head_lo = {tail[60],tail[56],tail[52],tail[48],tail[44],tail[40],tail[36],tail[32],at_head_lo_lo}; // @[fetch-buffer.scala 33:29]
  wire [7:0] at_head_hi_lo = {tail[92],tail[88],tail[84],tail[80],tail[76],tail[72],tail[68],tail[64]}; // @[fetch-buffer.scala 33:29]
  wire [31:0] _at_head_T_128 = {tail[124],tail[120],tail[116],tail[112],tail[108],tail[104],tail[100],tail[96],
    at_head_hi_lo,at_head_lo}; // @[fetch-buffer.scala 33:29]
  wire [31:0] _at_head_T_129 = _at_head_T_128 & head; // @[fetch-buffer.scala 33:36]
  wire  at_head = |_at_head_T_129; // @[fetch-buffer.scala 33:44]
  wire  do_enq = ~(at_head & maybe_full | might_hit_head); // @[fetch-buffer.scala 35:16]
  wire [127:0] _GEN_4 = {{96'd0}, head}; // @[fetch-buffer.scala 40:24]
  wire  _T_3 = _GEN_4 == tail & ~maybe_full; // @[fetch-buffer.scala 50:37]
  wire [31:0] _head_T_2 = {head[30:0],head[31]}; // @[Cat.scala 33:92]
  assign io_full = maybe_full; // @[fetch-buffer.scala 53:11]
  assign io_empty = _GEN_4 == tail & ~maybe_full; // @[fetch-buffer.scala 50:37]
  assign io_head = head; // @[fetch-buffer.scala 55:11]
  assign io_tail = tail; // @[fetch-buffer.scala 56:11]
  always @(posedge clock) begin
    if (reset) begin // @[fetch-buffer.scala 17:21]
      head <= 32'h1; // @[fetch-buffer.scala 17:21]
    end else if (io_deq & ~_T_3) begin // @[fetch-buffer.scala 44:28]
      head <= _head_T_2; // @[fetch-buffer.scala 45:10]
    end
    if (reset) begin // @[fetch-buffer.scala 18:21]
      tail <= 128'h1; // @[fetch-buffer.scala 18:21]
    end else if (io_enq & do_enq) begin // @[fetch-buffer.scala 38:26]
      tail <= _might_hit_head_T_2; // @[fetch-buffer.scala 39:10]
    end
    if (reset) begin // @[fetch-buffer.scala 20:27]
      maybe_full <= 1'h0; // @[fetch-buffer.scala 20:27]
    end else if (io_deq & ~_T_3) begin // @[fetch-buffer.scala 44:28]
      maybe_full <= 1'h0; // @[fetch-buffer.scala 46:16]
    end else if (io_enq & do_enq) begin // @[fetch-buffer.scala 38:26]
      maybe_full <= _GEN_4 == _might_hit_head_T_2; // @[fetch-buffer.scala 40:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  head = _RAND_0[31:0];
  _RAND_1 = {4{`RANDOM}};
  tail = _RAND_1[127:0];
  _RAND_2 = {1{`RANDOM}};
  maybe_full = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
