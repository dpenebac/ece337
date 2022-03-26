/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 26 12:08:11 2022
/////////////////////////////////////////////////////////////


module ahb_lite_slave ( clk, n_rst, coefficient_num, modwait, fir_out, err, 
        hsel, haddr, hsize, htrans, hwrite, hwdata, sample_data, data_ready, 
        new_coefficient_set, fir_coefficient, hrdata, hresp );
  input [1:0] coefficient_num;
  input [15:0] fir_out;
  input [3:0] haddr;
  input [1:0] htrans;
  input [15:0] hwdata;
  output [15:0] sample_data;
  output [15:0] fir_coefficient;
  output [15:0] hrdata;
  input clk, n_rst, modwait, err, hsel, hsize, hwrite;
  output data_ready, new_coefficient_set, hresp;
  wire   prev_hsize, \next_status_reg[8] , N96, n389, n391, n393, n395, n397,
         n399, n401, n403, n422, n424, n426, n428, n430, n432, n434, n436,
         n446, n448, n450, n452, n454, n456, n458, n460, n462, n464, n466,
         n468, n470, n472, n474, n476, n486, n488, n490, n492, n494, n496,
         n498, n500, n542, n543, n544, n545, n546, n547, n548, n549, n550,
         n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561,
         n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715,
         n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726,
         n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737,
         n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748,
         n749, n750, n751, n752, n753, n754, n755, n756, n757, n758, n759,
         n760, n761, n762, n763, n764, n765, n766, n767, n768, n769, n770,
         n771, n772, n773, n774, n775, n776, n777, n778, n779, n780, n781,
         n782, n783, n784, n785, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882, n883, n884, n885, n886, n887, n888, n889, n890, n891,
         n892, n893, n894, n895, n896, n897, n898, n899, n900, n901, n902,
         n903, n904, n905, n906, n907, n908, n909, n910, n911, n912, n913,
         n914, n915, n916, n917, n918, n919, n920, n921, n922, n923, n924,
         n925, n926, n927, n928, n929, n930, n931, n932, n933, n934, n935,
         n936, n937, n938, n939, n940, n941, n942, n943, n944, n945, n946,
         n947, n948, n949, n950, n951, n952, n953, n954, n955, n956, n957,
         n958;
  wire   [1:0] state;
  wire   [15:0] status_reg;
  wire   [15:0] result_reg;
  wire   [15:0] f0_reg;
  wire   [15:0] f1_reg;
  wire   [15:0] f2_reg;
  wire   [15:0] f3_reg;
  wire   [7:1] new_coeff_reg;
  wire   [3:0] prev_haddr;
  wire   [7:0] next_new_coeff_reg;
  assign \next_status_reg[8]  = err;
  assign hresp = N96;

  DFFSR \state_reg[1]  ( .D(n585), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR \state_reg[0]  ( .D(n584), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR prev_hsize_reg ( .D(hsize), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prev_hsize) );
  DFFSR \status_reg_reg[8]  ( .D(\next_status_reg[8] ), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(status_reg[8]) );
  DFFSR \result_reg_reg[15]  ( .D(fir_out[15]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[15]) );
  DFFSR \result_reg_reg[14]  ( .D(fir_out[14]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[14]) );
  DFFSR \result_reg_reg[13]  ( .D(fir_out[13]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[13]) );
  DFFSR \result_reg_reg[12]  ( .D(fir_out[12]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[12]) );
  DFFSR \result_reg_reg[11]  ( .D(fir_out[11]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[11]) );
  DFFSR \result_reg_reg[10]  ( .D(fir_out[10]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[10]) );
  DFFSR \result_reg_reg[9]  ( .D(fir_out[9]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[9]) );
  DFFSR \result_reg_reg[8]  ( .D(fir_out[8]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[8]) );
  DFFSR \result_reg_reg[7]  ( .D(fir_out[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[7]) );
  DFFSR \result_reg_reg[6]  ( .D(fir_out[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[6]) );
  DFFSR \result_reg_reg[5]  ( .D(fir_out[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[5]) );
  DFFSR \result_reg_reg[4]  ( .D(fir_out[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[4]) );
  DFFSR \result_reg_reg[3]  ( .D(fir_out[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[3]) );
  DFFSR \result_reg_reg[2]  ( .D(fir_out[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[2]) );
  DFFSR \result_reg_reg[1]  ( .D(fir_out[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[1]) );
  DFFSR \result_reg_reg[0]  ( .D(fir_out[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(result_reg[0]) );
  DFFSR \prev_haddr_reg[3]  ( .D(haddr[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[3]) );
  DFFSR \prev_haddr_reg[2]  ( .D(haddr[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[2]) );
  DFFSR \prev_haddr_reg[1]  ( .D(haddr[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[1]) );
  DFFSR \prev_haddr_reg[0]  ( .D(haddr[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[0]) );
  DFFSR data_ready_reg ( .D(n543), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR \f3_reg_reg[7]  ( .D(n544), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[7]) );
  DFFSR \f3_reg_reg[6]  ( .D(n545), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[6]) );
  DFFSR \f3_reg_reg[5]  ( .D(n546), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[5]) );
  DFFSR \f3_reg_reg[4]  ( .D(n547), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[4]) );
  DFFSR \f3_reg_reg[3]  ( .D(n548), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[3]) );
  DFFSR \f3_reg_reg[2]  ( .D(n549), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[2]) );
  DFFSR \f3_reg_reg[1]  ( .D(n550), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[1]) );
  DFFSR \f3_reg_reg[0]  ( .D(n551), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[0]) );
  DFFSR \f3_reg_reg[8]  ( .D(n500), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[8]) );
  DFFSR \f3_reg_reg[9]  ( .D(n498), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[9]) );
  DFFSR \f3_reg_reg[10]  ( .D(n496), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[10]) );
  DFFSR \f3_reg_reg[11]  ( .D(n494), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[11]) );
  DFFSR \f3_reg_reg[12]  ( .D(n492), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[12]) );
  DFFSR \f3_reg_reg[13]  ( .D(n490), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[13]) );
  DFFSR \f3_reg_reg[14]  ( .D(n488), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[14]) );
  DFFSR \f3_reg_reg[15]  ( .D(n486), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f3_reg[15]) );
  DFFSR \f1_reg_reg[7]  ( .D(n560), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[7]) );
  DFFSR \f1_reg_reg[6]  ( .D(n561), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[6]) );
  DFFSR \f1_reg_reg[5]  ( .D(n562), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[5]) );
  DFFSR \f1_reg_reg[4]  ( .D(n563), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[4]) );
  DFFSR \f1_reg_reg[3]  ( .D(n564), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[3]) );
  DFFSR \f1_reg_reg[2]  ( .D(n565), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[2]) );
  DFFSR \f1_reg_reg[1]  ( .D(n566), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[1]) );
  DFFSR \f1_reg_reg[0]  ( .D(n567), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[0]) );
  DFFSR \f1_reg_reg[8]  ( .D(n476), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[8]) );
  DFFSR \f1_reg_reg[9]  ( .D(n474), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[9]) );
  DFFSR \f1_reg_reg[10]  ( .D(n472), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[10]) );
  DFFSR \f1_reg_reg[11]  ( .D(n470), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[11]) );
  DFFSR \f1_reg_reg[12]  ( .D(n468), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[12]) );
  DFFSR \f1_reg_reg[13]  ( .D(n466), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[13]) );
  DFFSR \f1_reg_reg[14]  ( .D(n464), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[14]) );
  DFFSR \f1_reg_reg[15]  ( .D(n462), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f1_reg[15]) );
  DFFSR \f2_reg_reg[8]  ( .D(n460), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[8]) );
  DFFSR \f2_reg_reg[9]  ( .D(n458), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[9]) );
  DFFSR \f2_reg_reg[10]  ( .D(n456), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[10]) );
  DFFSR \f2_reg_reg[11]  ( .D(n454), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[11]) );
  DFFSR \f2_reg_reg[12]  ( .D(n452), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[12]) );
  DFFSR \f2_reg_reg[13]  ( .D(n450), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[13]) );
  DFFSR \f2_reg_reg[14]  ( .D(n448), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[14]) );
  DFFSR \f2_reg_reg[15]  ( .D(n446), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[15]) );
  DFFSR \f0_reg_reg[7]  ( .D(n568), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[7]) );
  DFFSR \f0_reg_reg[6]  ( .D(n569), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[6]) );
  DFFSR \f0_reg_reg[5]  ( .D(n570), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[5]) );
  DFFSR \f0_reg_reg[4]  ( .D(n571), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[4]) );
  DFFSR \f0_reg_reg[3]  ( .D(n572), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[3]) );
  DFFSR \f0_reg_reg[2]  ( .D(n573), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[2]) );
  DFFSR \f0_reg_reg[1]  ( .D(n574), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[1]) );
  DFFSR \f0_reg_reg[0]  ( .D(n575), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[0]) );
  DFFSR \f0_reg_reg[8]  ( .D(n436), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[8]) );
  DFFSR \f0_reg_reg[9]  ( .D(n434), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[9]) );
  DFFSR \f0_reg_reg[10]  ( .D(n432), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[10]) );
  DFFSR \f0_reg_reg[11]  ( .D(n430), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[11]) );
  DFFSR \f0_reg_reg[12]  ( .D(n428), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[12]) );
  DFFSR \f0_reg_reg[13]  ( .D(n426), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[13]) );
  DFFSR \f0_reg_reg[14]  ( .D(n424), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[14]) );
  DFFSR \f0_reg_reg[15]  ( .D(n422), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f0_reg[15]) );
  DFFSR \new_coeff_reg_reg[7]  ( .D(next_new_coeff_reg[7]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[7]) );
  DFFSR \new_coeff_reg_reg[6]  ( .D(next_new_coeff_reg[6]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[6]) );
  DFFSR \new_coeff_reg_reg[5]  ( .D(next_new_coeff_reg[5]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[5]) );
  DFFSR \new_coeff_reg_reg[4]  ( .D(next_new_coeff_reg[4]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[4]) );
  DFFSR \new_coeff_reg_reg[3]  ( .D(next_new_coeff_reg[3]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[3]) );
  DFFSR \new_coeff_reg_reg[2]  ( .D(next_new_coeff_reg[2]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[2]) );
  DFFSR \new_coeff_reg_reg[1]  ( .D(next_new_coeff_reg[1]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coeff_reg[1]) );
  DFFSR \new_coeff_reg_reg[0]  ( .D(next_new_coeff_reg[0]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coefficient_set) );
  DFFSR \status_reg_reg[0]  ( .D(n542), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        status_reg[0]) );
  DFFSR \new_sample_reg_reg[7]  ( .D(n576), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[7]) );
  DFFSR \new_sample_reg_reg[6]  ( .D(n577), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[6]) );
  DFFSR \new_sample_reg_reg[5]  ( .D(n578), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[5]) );
  DFFSR \new_sample_reg_reg[4]  ( .D(n579), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[4]) );
  DFFSR \new_sample_reg_reg[3]  ( .D(n580), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[3]) );
  DFFSR \new_sample_reg_reg[2]  ( .D(n581), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[2]) );
  DFFSR \new_sample_reg_reg[1]  ( .D(n582), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[1]) );
  DFFSR \new_sample_reg_reg[0]  ( .D(n583), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[0]) );
  DFFSR \new_sample_reg_reg[15]  ( .D(n403), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[15]) );
  DFFSR \new_sample_reg_reg[14]  ( .D(n401), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[14]) );
  DFFSR \new_sample_reg_reg[13]  ( .D(n399), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[13]) );
  DFFSR \new_sample_reg_reg[12]  ( .D(n397), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[12]) );
  DFFSR \new_sample_reg_reg[11]  ( .D(n395), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[11]) );
  DFFSR \new_sample_reg_reg[10]  ( .D(n393), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[10]) );
  DFFSR \new_sample_reg_reg[9]  ( .D(n391), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[9]) );
  DFFSR \new_sample_reg_reg[8]  ( .D(n389), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(sample_data[8]) );
  DFFSR \f2_reg_reg[0]  ( .D(n559), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[0]) );
  DFFSR \f2_reg_reg[1]  ( .D(n558), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[1]) );
  DFFSR \f2_reg_reg[2]  ( .D(n557), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[2]) );
  DFFSR \f2_reg_reg[3]  ( .D(n556), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[3]) );
  DFFSR \f2_reg_reg[4]  ( .D(n555), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[4]) );
  DFFSR \f2_reg_reg[5]  ( .D(n554), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[5]) );
  DFFSR \f2_reg_reg[6]  ( .D(n553), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[6]) );
  DFFSR \f2_reg_reg[7]  ( .D(n552), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        f2_reg[7]) );
  INVX2 U621 ( .A(n608), .Y(n920) );
  AND2X2 U622 ( .A(coefficient_num[0]), .B(n954), .Y(n922) );
  BUFX2 U623 ( .A(n921), .Y(n586) );
  INVX2 U624 ( .A(n898), .Y(n794) );
  BUFX2 U625 ( .A(n923), .Y(n587) );
  OAI22X1 U626 ( .A(n588), .B(n589), .C(n590), .D(n591), .Y(
        next_new_coeff_reg[7]) );
  INVX1 U627 ( .A(new_coeff_reg[7]), .Y(n591) );
  OAI22X1 U628 ( .A(n588), .B(n592), .C(n590), .D(n593), .Y(
        next_new_coeff_reg[6]) );
  INVX1 U629 ( .A(new_coeff_reg[6]), .Y(n593) );
  OAI22X1 U630 ( .A(n588), .B(n594), .C(n590), .D(n595), .Y(
        next_new_coeff_reg[5]) );
  INVX1 U631 ( .A(new_coeff_reg[5]), .Y(n595) );
  OAI22X1 U632 ( .A(n588), .B(n596), .C(n590), .D(n597), .Y(
        next_new_coeff_reg[4]) );
  INVX1 U633 ( .A(new_coeff_reg[4]), .Y(n597) );
  OAI22X1 U634 ( .A(n588), .B(n598), .C(n590), .D(n599), .Y(
        next_new_coeff_reg[3]) );
  INVX1 U635 ( .A(new_coeff_reg[3]), .Y(n599) );
  OAI22X1 U636 ( .A(n588), .B(n600), .C(n590), .D(n601), .Y(
        next_new_coeff_reg[2]) );
  INVX1 U637 ( .A(new_coeff_reg[2]), .Y(n601) );
  OAI22X1 U638 ( .A(n588), .B(n602), .C(n590), .D(n603), .Y(
        next_new_coeff_reg[1]) );
  INVX1 U639 ( .A(new_coeff_reg[1]), .Y(n603) );
  OAI22X1 U640 ( .A(n588), .B(n604), .C(n590), .D(n605), .Y(
        next_new_coeff_reg[0]) );
  OAI21X1 U641 ( .A(n606), .B(n607), .C(n608), .Y(n590) );
  NAND2X1 U642 ( .A(n609), .B(n610), .Y(n607) );
  NAND2X1 U643 ( .A(n611), .B(n612), .Y(n606) );
  NAND2X1 U644 ( .A(n613), .B(n609), .Y(n588) );
  OAI21X1 U645 ( .A(n614), .B(n615), .C(n616), .Y(n585) );
  OAI21X1 U646 ( .A(n617), .B(hwrite), .C(n618), .Y(n616) );
  INVX1 U647 ( .A(n619), .Y(n617) );
  OAI21X1 U648 ( .A(n615), .B(n620), .C(n621), .Y(n584) );
  OAI21X1 U649 ( .A(n622), .B(n623), .C(n618), .Y(n621) );
  INVX1 U650 ( .A(n624), .Y(n618) );
  OAI21X1 U651 ( .A(htrans[1]), .B(htrans[0]), .C(n615), .Y(n624) );
  NAND2X1 U652 ( .A(n625), .B(n619), .Y(n623) );
  OAI21X1 U653 ( .A(htrans[0]), .B(htrans[1]), .C(n626), .Y(n615) );
  INVX1 U654 ( .A(hsel), .Y(n626) );
  OAI22X1 U655 ( .A(n627), .B(n628), .C(n604), .D(n629), .Y(n583) );
  OAI22X1 U656 ( .A(n627), .B(n630), .C(n602), .D(n629), .Y(n582) );
  INVX1 U657 ( .A(sample_data[1]), .Y(n630) );
  OAI22X1 U658 ( .A(n627), .B(n631), .C(n600), .D(n629), .Y(n581) );
  INVX1 U659 ( .A(sample_data[2]), .Y(n631) );
  OAI22X1 U660 ( .A(n627), .B(n632), .C(n598), .D(n629), .Y(n580) );
  INVX1 U661 ( .A(sample_data[3]), .Y(n632) );
  OAI22X1 U662 ( .A(n627), .B(n633), .C(n596), .D(n629), .Y(n579) );
  INVX1 U663 ( .A(sample_data[4]), .Y(n633) );
  OAI22X1 U664 ( .A(n627), .B(n634), .C(n594), .D(n629), .Y(n578) );
  INVX1 U665 ( .A(sample_data[5]), .Y(n634) );
  OAI22X1 U666 ( .A(n627), .B(n635), .C(n592), .D(n629), .Y(n577) );
  INVX1 U667 ( .A(sample_data[6]), .Y(n635) );
  OAI22X1 U668 ( .A(n627), .B(n636), .C(n589), .D(n629), .Y(n576) );
  NAND2X1 U669 ( .A(n637), .B(n638), .Y(n629) );
  INVX1 U670 ( .A(sample_data[7]), .Y(n636) );
  INVX1 U671 ( .A(n639), .Y(n627) );
  NAND3X1 U672 ( .A(n638), .B(n640), .C(n641), .Y(n639) );
  OAI21X1 U673 ( .A(n642), .B(n643), .C(n644), .Y(n638) );
  OAI22X1 U674 ( .A(n645), .B(n646), .C(n604), .D(n647), .Y(n575) );
  OAI22X1 U675 ( .A(n645), .B(n648), .C(n602), .D(n647), .Y(n574) );
  OAI22X1 U676 ( .A(n645), .B(n649), .C(n600), .D(n647), .Y(n573) );
  OAI22X1 U677 ( .A(n645), .B(n650), .C(n598), .D(n647), .Y(n572) );
  OAI22X1 U678 ( .A(n645), .B(n651), .C(n596), .D(n647), .Y(n571) );
  OAI22X1 U679 ( .A(n645), .B(n652), .C(n594), .D(n647), .Y(n570) );
  OAI22X1 U680 ( .A(n645), .B(n653), .C(n592), .D(n647), .Y(n569) );
  OAI22X1 U681 ( .A(n645), .B(n654), .C(n589), .D(n647), .Y(n568) );
  NAND2X1 U682 ( .A(n655), .B(n656), .Y(n647) );
  INVX1 U683 ( .A(n657), .Y(n645) );
  NAND3X1 U684 ( .A(n656), .B(n658), .C(n641), .Y(n657) );
  NOR2X1 U685 ( .A(n659), .B(n660), .Y(n641) );
  OAI22X1 U686 ( .A(n661), .B(n662), .C(n604), .D(n663), .Y(n567) );
  INVX1 U687 ( .A(f1_reg[0]), .Y(n662) );
  OAI22X1 U688 ( .A(n661), .B(n664), .C(n602), .D(n663), .Y(n566) );
  INVX1 U689 ( .A(f1_reg[1]), .Y(n664) );
  OAI22X1 U690 ( .A(n661), .B(n665), .C(n600), .D(n663), .Y(n565) );
  INVX1 U691 ( .A(f1_reg[2]), .Y(n665) );
  OAI22X1 U692 ( .A(n661), .B(n666), .C(n598), .D(n663), .Y(n564) );
  INVX1 U693 ( .A(f1_reg[3]), .Y(n666) );
  OAI22X1 U694 ( .A(n661), .B(n667), .C(n596), .D(n663), .Y(n563) );
  INVX1 U695 ( .A(f1_reg[4]), .Y(n667) );
  OAI22X1 U696 ( .A(n661), .B(n668), .C(n594), .D(n663), .Y(n562) );
  INVX1 U697 ( .A(f1_reg[5]), .Y(n668) );
  OAI22X1 U698 ( .A(n661), .B(n669), .C(n592), .D(n663), .Y(n561) );
  INVX1 U699 ( .A(f1_reg[6]), .Y(n669) );
  OAI22X1 U700 ( .A(n661), .B(n670), .C(n589), .D(n663), .Y(n560) );
  NAND2X1 U701 ( .A(n671), .B(n672), .Y(n663) );
  INVX1 U702 ( .A(f1_reg[7]), .Y(n670) );
  INVX1 U703 ( .A(n673), .Y(n661) );
  NAND3X1 U704 ( .A(n672), .B(n674), .C(n675), .Y(n673) );
  OAI21X1 U705 ( .A(n676), .B(n643), .C(n644), .Y(n672) );
  OAI22X1 U706 ( .A(n677), .B(n678), .C(n604), .D(n679), .Y(n559) );
  INVX1 U707 ( .A(hwdata[0]), .Y(n604) );
  OAI22X1 U708 ( .A(n677), .B(n680), .C(n602), .D(n679), .Y(n558) );
  INVX1 U709 ( .A(f2_reg[1]), .Y(n680) );
  OAI22X1 U710 ( .A(n677), .B(n681), .C(n600), .D(n679), .Y(n557) );
  INVX1 U711 ( .A(f2_reg[2]), .Y(n681) );
  OAI22X1 U712 ( .A(n677), .B(n682), .C(n598), .D(n679), .Y(n556) );
  INVX1 U713 ( .A(f2_reg[3]), .Y(n682) );
  OAI22X1 U714 ( .A(n677), .B(n683), .C(n596), .D(n679), .Y(n555) );
  INVX1 U715 ( .A(f2_reg[4]), .Y(n683) );
  OAI22X1 U716 ( .A(n677), .B(n684), .C(n594), .D(n679), .Y(n554) );
  INVX1 U717 ( .A(f2_reg[5]), .Y(n684) );
  OAI22X1 U718 ( .A(n677), .B(n685), .C(n592), .D(n679), .Y(n553) );
  INVX1 U719 ( .A(f2_reg[6]), .Y(n685) );
  OAI22X1 U720 ( .A(n677), .B(n686), .C(n589), .D(n679), .Y(n552) );
  NAND2X1 U721 ( .A(n687), .B(n656), .Y(n679) );
  INVX1 U722 ( .A(f2_reg[7]), .Y(n686) );
  INVX1 U723 ( .A(n688), .Y(n677) );
  NAND3X1 U724 ( .A(n656), .B(n689), .C(n675), .Y(n688) );
  NOR2X1 U725 ( .A(n690), .B(n660), .Y(n675) );
  OAI21X1 U726 ( .A(n691), .B(n643), .C(n644), .Y(n656) );
  INVX1 U727 ( .A(n692), .Y(n551) );
  MUX2X1 U728 ( .B(f3_reg[0]), .A(hwdata[0]), .S(n693), .Y(n692) );
  MUX2X1 U729 ( .B(n694), .A(n602), .S(n693), .Y(n550) );
  INVX1 U730 ( .A(hwdata[1]), .Y(n602) );
  INVX1 U731 ( .A(f3_reg[1]), .Y(n694) );
  MUX2X1 U732 ( .B(n695), .A(n600), .S(n693), .Y(n549) );
  INVX1 U733 ( .A(hwdata[2]), .Y(n600) );
  INVX1 U734 ( .A(f3_reg[2]), .Y(n695) );
  MUX2X1 U735 ( .B(n696), .A(n598), .S(n693), .Y(n548) );
  INVX1 U736 ( .A(hwdata[3]), .Y(n598) );
  INVX1 U737 ( .A(f3_reg[3]), .Y(n696) );
  MUX2X1 U738 ( .B(n697), .A(n596), .S(n693), .Y(n547) );
  INVX1 U739 ( .A(hwdata[4]), .Y(n596) );
  INVX1 U740 ( .A(f3_reg[4]), .Y(n697) );
  MUX2X1 U741 ( .B(n698), .A(n594), .S(n693), .Y(n546) );
  INVX1 U742 ( .A(hwdata[5]), .Y(n594) );
  INVX1 U743 ( .A(f3_reg[5]), .Y(n698) );
  MUX2X1 U744 ( .B(n699), .A(n592), .S(n693), .Y(n545) );
  INVX1 U745 ( .A(hwdata[6]), .Y(n592) );
  INVX1 U746 ( .A(f3_reg[6]), .Y(n699) );
  MUX2X1 U747 ( .B(n700), .A(n589), .S(n693), .Y(n544) );
  OAI21X1 U748 ( .A(n701), .B(n702), .C(n703), .Y(n693) );
  INVX1 U749 ( .A(hwdata[7]), .Y(n589) );
  INVX1 U750 ( .A(f3_reg[7]), .Y(n700) );
  OAI21X1 U751 ( .A(modwait), .B(n704), .C(n705), .Y(n543) );
  AOI21X1 U752 ( .A(n706), .B(n609), .C(n642), .Y(n705) );
  NOR2X1 U753 ( .A(prev_haddr[1]), .B(n707), .Y(n706) );
  INVX1 U754 ( .A(data_ready), .Y(n704) );
  AOI21X1 U755 ( .A(n605), .B(n708), .C(\next_status_reg[8] ), .Y(n542) );
  INVX1 U756 ( .A(modwait), .Y(n708) );
  OAI21X1 U757 ( .A(n709), .B(n710), .C(n711), .Y(n500) );
  AOI22X1 U758 ( .A(f3_reg[8]), .B(n702), .C(n712), .D(hwdata[0]), .Y(n711) );
  OAI21X1 U759 ( .A(n709), .B(n713), .C(n714), .Y(n498) );
  AOI22X1 U760 ( .A(f3_reg[9]), .B(n702), .C(n712), .D(hwdata[1]), .Y(n714) );
  OAI21X1 U761 ( .A(n709), .B(n715), .C(n716), .Y(n496) );
  AOI22X1 U762 ( .A(f3_reg[10]), .B(n702), .C(n712), .D(hwdata[2]), .Y(n716)
         );
  OAI21X1 U763 ( .A(n709), .B(n717), .C(n718), .Y(n494) );
  AOI22X1 U764 ( .A(f3_reg[11]), .B(n702), .C(n712), .D(hwdata[3]), .Y(n718)
         );
  OAI21X1 U765 ( .A(n709), .B(n719), .C(n720), .Y(n492) );
  AOI22X1 U766 ( .A(f3_reg[12]), .B(n702), .C(n712), .D(hwdata[4]), .Y(n720)
         );
  OAI21X1 U767 ( .A(n709), .B(n721), .C(n722), .Y(n490) );
  AOI22X1 U768 ( .A(f3_reg[13]), .B(n702), .C(n712), .D(hwdata[5]), .Y(n722)
         );
  OAI21X1 U769 ( .A(n709), .B(n723), .C(n724), .Y(n488) );
  AOI22X1 U770 ( .A(f3_reg[14]), .B(n702), .C(n712), .D(hwdata[6]), .Y(n724)
         );
  OAI21X1 U771 ( .A(n709), .B(n725), .C(n726), .Y(n486) );
  AOI22X1 U772 ( .A(f3_reg[15]), .B(n702), .C(n712), .D(hwdata[7]), .Y(n726)
         );
  NOR2X1 U773 ( .A(n727), .B(n728), .Y(n712) );
  NAND2X1 U774 ( .A(n609), .B(n729), .Y(n702) );
  INVX1 U775 ( .A(n730), .Y(n709) );
  OAI21X1 U776 ( .A(n728), .B(n731), .C(n703), .Y(n730) );
  NAND2X1 U777 ( .A(n732), .B(n729), .Y(n703) );
  OAI21X1 U778 ( .A(n733), .B(n710), .C(n734), .Y(n476) );
  AOI22X1 U779 ( .A(f1_reg[8]), .B(n735), .C(n736), .D(hwdata[0]), .Y(n734) );
  OAI21X1 U780 ( .A(n733), .B(n713), .C(n737), .Y(n474) );
  AOI22X1 U781 ( .A(f1_reg[9]), .B(n735), .C(n736), .D(hwdata[1]), .Y(n737) );
  OAI21X1 U782 ( .A(n733), .B(n715), .C(n738), .Y(n472) );
  AOI22X1 U783 ( .A(f1_reg[10]), .B(n735), .C(n736), .D(hwdata[2]), .Y(n738)
         );
  OAI21X1 U784 ( .A(n733), .B(n717), .C(n739), .Y(n470) );
  AOI22X1 U785 ( .A(f1_reg[11]), .B(n735), .C(n736), .D(hwdata[3]), .Y(n739)
         );
  OAI21X1 U786 ( .A(n733), .B(n719), .C(n740), .Y(n468) );
  AOI22X1 U787 ( .A(f1_reg[12]), .B(n735), .C(n736), .D(hwdata[4]), .Y(n740)
         );
  OAI21X1 U788 ( .A(n733), .B(n721), .C(n741), .Y(n466) );
  AOI22X1 U789 ( .A(f1_reg[13]), .B(n735), .C(n736), .D(hwdata[5]), .Y(n741)
         );
  OAI21X1 U790 ( .A(n733), .B(n723), .C(n742), .Y(n464) );
  AOI22X1 U791 ( .A(f1_reg[14]), .B(n735), .C(n736), .D(hwdata[6]), .Y(n742)
         );
  OAI21X1 U792 ( .A(n733), .B(n725), .C(n743), .Y(n462) );
  AOI22X1 U793 ( .A(f1_reg[15]), .B(n735), .C(n736), .D(hwdata[7]), .Y(n743)
         );
  NOR2X1 U794 ( .A(n744), .B(n745), .Y(n736) );
  NAND3X1 U795 ( .A(n610), .B(n674), .C(n746), .Y(n735) );
  AOI22X1 U796 ( .A(n747), .B(n748), .C(n671), .D(n732), .Y(n733) );
  INVX1 U797 ( .A(n689), .Y(n671) );
  OAI21X1 U798 ( .A(n749), .B(n710), .C(n750), .Y(n460) );
  AOI22X1 U799 ( .A(f2_reg[8]), .B(n751), .C(n752), .D(hwdata[0]), .Y(n750) );
  OAI21X1 U800 ( .A(n749), .B(n713), .C(n753), .Y(n458) );
  AOI22X1 U801 ( .A(f2_reg[9]), .B(n751), .C(n752), .D(hwdata[1]), .Y(n753) );
  OAI21X1 U802 ( .A(n749), .B(n715), .C(n754), .Y(n456) );
  AOI22X1 U803 ( .A(f2_reg[10]), .B(n751), .C(n752), .D(hwdata[2]), .Y(n754)
         );
  OAI21X1 U804 ( .A(n749), .B(n717), .C(n755), .Y(n454) );
  AOI22X1 U805 ( .A(f2_reg[11]), .B(n751), .C(n752), .D(hwdata[3]), .Y(n755)
         );
  OAI21X1 U806 ( .A(n749), .B(n719), .C(n756), .Y(n452) );
  AOI22X1 U807 ( .A(f2_reg[12]), .B(n751), .C(n752), .D(hwdata[4]), .Y(n756)
         );
  OAI21X1 U808 ( .A(n749), .B(n721), .C(n757), .Y(n450) );
  AOI22X1 U809 ( .A(f2_reg[13]), .B(n751), .C(n752), .D(hwdata[5]), .Y(n757)
         );
  OAI21X1 U810 ( .A(n749), .B(n723), .C(n758), .Y(n448) );
  AOI22X1 U811 ( .A(f2_reg[14]), .B(n751), .C(n752), .D(hwdata[6]), .Y(n758)
         );
  OAI21X1 U812 ( .A(n749), .B(n725), .C(n759), .Y(n446) );
  AOI22X1 U813 ( .A(f2_reg[15]), .B(n751), .C(n752), .D(hwdata[7]), .Y(n759)
         );
  NOR2X1 U814 ( .A(n760), .B(n744), .Y(n752) );
  INVX1 U815 ( .A(n748), .Y(n744) );
  NAND3X1 U816 ( .A(n610), .B(n689), .C(n746), .Y(n751) );
  AOI22X1 U817 ( .A(n761), .B(n748), .C(n687), .D(n732), .Y(n749) );
  INVX1 U818 ( .A(n674), .Y(n687) );
  NOR2X1 U819 ( .A(n728), .B(n762), .Y(n748) );
  OAI21X1 U820 ( .A(n763), .B(n710), .C(n764), .Y(n436) );
  AOI22X1 U821 ( .A(f0_reg[8]), .B(n765), .C(n766), .D(hwdata[0]), .Y(n764) );
  OAI21X1 U822 ( .A(n763), .B(n713), .C(n767), .Y(n434) );
  AOI22X1 U823 ( .A(f0_reg[9]), .B(n765), .C(n766), .D(hwdata[1]), .Y(n767) );
  OAI21X1 U824 ( .A(n763), .B(n715), .C(n768), .Y(n432) );
  AOI22X1 U825 ( .A(f0_reg[10]), .B(n765), .C(n766), .D(hwdata[2]), .Y(n768)
         );
  OAI21X1 U826 ( .A(n763), .B(n717), .C(n769), .Y(n430) );
  AOI22X1 U827 ( .A(f0_reg[11]), .B(n765), .C(n766), .D(hwdata[3]), .Y(n769)
         );
  OAI21X1 U828 ( .A(n763), .B(n719), .C(n770), .Y(n428) );
  AOI22X1 U829 ( .A(f0_reg[12]), .B(n765), .C(n766), .D(hwdata[4]), .Y(n770)
         );
  OAI21X1 U830 ( .A(n763), .B(n721), .C(n771), .Y(n426) );
  AOI22X1 U831 ( .A(f0_reg[13]), .B(n765), .C(n766), .D(hwdata[5]), .Y(n771)
         );
  OAI21X1 U832 ( .A(n763), .B(n723), .C(n772), .Y(n424) );
  AOI22X1 U833 ( .A(f0_reg[14]), .B(n765), .C(n766), .D(hwdata[6]), .Y(n772)
         );
  OAI21X1 U834 ( .A(n763), .B(n725), .C(n773), .Y(n422) );
  AOI22X1 U835 ( .A(f0_reg[15]), .B(n765), .C(n766), .D(hwdata[7]), .Y(n773)
         );
  AND2X1 U836 ( .A(n774), .B(n691), .Y(n766) );
  NAND3X1 U837 ( .A(n611), .B(n658), .C(n746), .Y(n765) );
  AOI22X1 U838 ( .A(n761), .B(n774), .C(n655), .D(n732), .Y(n763) );
  INVX1 U839 ( .A(n640), .Y(n655) );
  OAI21X1 U840 ( .A(n775), .B(n725), .C(n776), .Y(n403) );
  AOI22X1 U841 ( .A(sample_data[15]), .B(n777), .C(n778), .D(hwdata[7]), .Y(
        n776) );
  INVX1 U842 ( .A(hwdata[15]), .Y(n725) );
  OAI21X1 U843 ( .A(n775), .B(n723), .C(n779), .Y(n401) );
  AOI22X1 U844 ( .A(sample_data[14]), .B(n777), .C(n778), .D(hwdata[6]), .Y(
        n779) );
  INVX1 U845 ( .A(hwdata[14]), .Y(n723) );
  OAI21X1 U846 ( .A(n775), .B(n721), .C(n780), .Y(n399) );
  AOI22X1 U847 ( .A(sample_data[13]), .B(n777), .C(n778), .D(hwdata[5]), .Y(
        n780) );
  INVX1 U848 ( .A(hwdata[13]), .Y(n721) );
  OAI21X1 U849 ( .A(n775), .B(n719), .C(n781), .Y(n397) );
  AOI22X1 U850 ( .A(sample_data[12]), .B(n777), .C(n778), .D(hwdata[4]), .Y(
        n781) );
  INVX1 U851 ( .A(hwdata[12]), .Y(n719) );
  OAI21X1 U852 ( .A(n775), .B(n717), .C(n782), .Y(n395) );
  AOI22X1 U853 ( .A(sample_data[11]), .B(n777), .C(n778), .D(hwdata[3]), .Y(
        n782) );
  INVX1 U854 ( .A(hwdata[11]), .Y(n717) );
  OAI21X1 U855 ( .A(n775), .B(n715), .C(n783), .Y(n393) );
  AOI22X1 U856 ( .A(sample_data[10]), .B(n777), .C(n778), .D(hwdata[2]), .Y(
        n783) );
  INVX1 U857 ( .A(hwdata[10]), .Y(n715) );
  OAI21X1 U858 ( .A(n775), .B(n713), .C(n784), .Y(n391) );
  AOI22X1 U859 ( .A(sample_data[9]), .B(n777), .C(n778), .D(hwdata[1]), .Y(
        n784) );
  INVX1 U860 ( .A(hwdata[9]), .Y(n713) );
  OAI21X1 U861 ( .A(n775), .B(n710), .C(n785), .Y(n389) );
  AOI22X1 U862 ( .A(sample_data[8]), .B(n777), .C(n778), .D(hwdata[0]), .Y(
        n785) );
  NOR2X1 U863 ( .A(n786), .B(n728), .Y(n778) );
  NAND3X1 U864 ( .A(n611), .B(n640), .C(n746), .Y(n777) );
  NOR2X1 U865 ( .A(n660), .B(n643), .Y(n746) );
  NAND2X1 U866 ( .A(n612), .B(n787), .Y(n660) );
  NAND3X1 U867 ( .A(n611), .B(n787), .C(n610), .Y(n612) );
  INVX1 U868 ( .A(n690), .Y(n610) );
  NAND2X1 U869 ( .A(n658), .B(n640), .Y(n690) );
  OAI21X1 U870 ( .A(n761), .B(n691), .C(n788), .Y(n640) );
  INVX1 U871 ( .A(n659), .Y(n611) );
  NAND2X1 U872 ( .A(n689), .B(n674), .Y(n659) );
  OAI21X1 U873 ( .A(n761), .B(n691), .C(n789), .Y(n674) );
  INVX1 U874 ( .A(n760), .Y(n691) );
  INVX1 U875 ( .A(hwdata[8]), .Y(n710) );
  AOI22X1 U876 ( .A(n747), .B(n774), .C(n637), .D(n732), .Y(n775) );
  INVX1 U877 ( .A(n644), .Y(n732) );
  NAND2X1 U878 ( .A(prev_hsize), .B(n609), .Y(n644) );
  INVX1 U879 ( .A(n658), .Y(n637) );
  OAI21X1 U880 ( .A(n747), .B(n790), .C(n788), .Y(n658) );
  NOR2X1 U881 ( .A(n728), .B(n707), .Y(n774) );
  NAND2X1 U882 ( .A(n609), .B(n791), .Y(n728) );
  INVX1 U883 ( .A(n643), .Y(n609) );
  NAND2X1 U884 ( .A(state[1]), .B(n620), .Y(n643) );
  INVX1 U885 ( .A(state[0]), .Y(n620) );
  NAND2X1 U886 ( .A(n792), .B(n793), .Y(hrdata[9]) );
  AOI22X1 U887 ( .A(n794), .B(n795), .C(n796), .D(f2_reg[9]), .Y(n793) );
  OAI21X1 U888 ( .A(n797), .B(n798), .C(n799), .Y(n795) );
  AOI22X1 U889 ( .A(n800), .B(f0_reg[9]), .C(result_reg[9]), .D(n801), .Y(n799) );
  INVX1 U890 ( .A(sample_data[9]), .Y(n798) );
  AOI22X1 U891 ( .A(n802), .B(f1_reg[9]), .C(n803), .D(f3_reg[9]), .Y(n792) );
  NAND2X1 U892 ( .A(n804), .B(n805), .Y(hrdata[8]) );
  AOI22X1 U893 ( .A(n794), .B(n806), .C(n796), .D(f2_reg[8]), .Y(n805) );
  NAND2X1 U894 ( .A(n807), .B(n808), .Y(n806) );
  AOI22X1 U895 ( .A(n809), .B(status_reg[8]), .C(n800), .D(f0_reg[8]), .Y(n808) );
  AOI21X1 U896 ( .A(n745), .B(n810), .C(n811), .Y(n809) );
  AOI22X1 U897 ( .A(result_reg[8]), .B(n801), .C(sample_data[8]), .D(n812), 
        .Y(n807) );
  AOI22X1 U898 ( .A(n802), .B(f1_reg[8]), .C(n803), .D(f3_reg[8]), .Y(n804) );
  INVX1 U899 ( .A(n813), .Y(hrdata[7]) );
  OAI21X1 U900 ( .A(n814), .B(n815), .C(n794), .Y(n813) );
  OAI21X1 U901 ( .A(n654), .B(n816), .C(n817), .Y(n815) );
  AOI22X1 U902 ( .A(n613), .B(new_coeff_reg[7]), .C(result_reg[7]), .D(n818), 
        .Y(n817) );
  INVX1 U903 ( .A(f0_reg[7]), .Y(n654) );
  NAND2X1 U904 ( .A(n819), .B(n820), .Y(n814) );
  AOI22X1 U905 ( .A(n821), .B(f2_reg[7]), .C(n822), .D(f1_reg[7]), .Y(n820) );
  AOI22X1 U906 ( .A(f3_reg[7]), .B(n823), .C(sample_data[7]), .D(n824), .Y(
        n819) );
  INVX1 U907 ( .A(n825), .Y(hrdata[6]) );
  OAI21X1 U908 ( .A(n826), .B(n827), .C(n794), .Y(n825) );
  OAI21X1 U909 ( .A(n653), .B(n816), .C(n828), .Y(n827) );
  AOI22X1 U910 ( .A(new_coeff_reg[6]), .B(n613), .C(result_reg[6]), .D(n818), 
        .Y(n828) );
  INVX1 U911 ( .A(f0_reg[6]), .Y(n653) );
  NAND2X1 U912 ( .A(n829), .B(n830), .Y(n826) );
  AOI22X1 U913 ( .A(n821), .B(f2_reg[6]), .C(n822), .D(f1_reg[6]), .Y(n830) );
  AOI22X1 U914 ( .A(f3_reg[6]), .B(n823), .C(sample_data[6]), .D(n824), .Y(
        n829) );
  INVX1 U915 ( .A(n831), .Y(hrdata[5]) );
  OAI21X1 U916 ( .A(n832), .B(n833), .C(n794), .Y(n831) );
  OAI21X1 U917 ( .A(n652), .B(n816), .C(n834), .Y(n833) );
  AOI22X1 U918 ( .A(new_coeff_reg[5]), .B(n613), .C(result_reg[5]), .D(n818), 
        .Y(n834) );
  INVX1 U919 ( .A(f0_reg[5]), .Y(n652) );
  NAND2X1 U920 ( .A(n835), .B(n836), .Y(n832) );
  AOI22X1 U921 ( .A(n821), .B(f2_reg[5]), .C(n822), .D(f1_reg[5]), .Y(n836) );
  AOI22X1 U922 ( .A(f3_reg[5]), .B(n823), .C(sample_data[5]), .D(n824), .Y(
        n835) );
  INVX1 U923 ( .A(n837), .Y(hrdata[4]) );
  OAI21X1 U924 ( .A(n838), .B(n839), .C(n794), .Y(n837) );
  OAI21X1 U925 ( .A(n651), .B(n816), .C(n840), .Y(n839) );
  AOI22X1 U926 ( .A(new_coeff_reg[4]), .B(n613), .C(result_reg[4]), .D(n818), 
        .Y(n840) );
  INVX1 U927 ( .A(f0_reg[4]), .Y(n651) );
  NAND2X1 U928 ( .A(n841), .B(n842), .Y(n838) );
  AOI22X1 U929 ( .A(n821), .B(f2_reg[4]), .C(n822), .D(f1_reg[4]), .Y(n842) );
  AOI22X1 U930 ( .A(f3_reg[4]), .B(n823), .C(sample_data[4]), .D(n824), .Y(
        n841) );
  INVX1 U931 ( .A(n843), .Y(hrdata[3]) );
  OAI21X1 U932 ( .A(n844), .B(n845), .C(n794), .Y(n843) );
  OAI21X1 U933 ( .A(n650), .B(n816), .C(n846), .Y(n845) );
  AOI22X1 U934 ( .A(new_coeff_reg[3]), .B(n613), .C(result_reg[3]), .D(n818), 
        .Y(n846) );
  INVX1 U935 ( .A(f0_reg[3]), .Y(n650) );
  NAND2X1 U936 ( .A(n847), .B(n848), .Y(n844) );
  AOI22X1 U937 ( .A(n821), .B(f2_reg[3]), .C(n822), .D(f1_reg[3]), .Y(n848) );
  AOI22X1 U938 ( .A(f3_reg[3]), .B(n823), .C(sample_data[3]), .D(n824), .Y(
        n847) );
  INVX1 U939 ( .A(n849), .Y(hrdata[2]) );
  OAI21X1 U940 ( .A(n850), .B(n851), .C(n794), .Y(n849) );
  OAI21X1 U941 ( .A(n649), .B(n816), .C(n852), .Y(n851) );
  AOI22X1 U942 ( .A(new_coeff_reg[2]), .B(n613), .C(result_reg[2]), .D(n818), 
        .Y(n852) );
  INVX1 U943 ( .A(f0_reg[2]), .Y(n649) );
  NAND2X1 U944 ( .A(n853), .B(n854), .Y(n850) );
  AOI22X1 U945 ( .A(n821), .B(f2_reg[2]), .C(n822), .D(f1_reg[2]), .Y(n854) );
  AOI22X1 U946 ( .A(f3_reg[2]), .B(n823), .C(sample_data[2]), .D(n824), .Y(
        n853) );
  INVX1 U947 ( .A(n855), .Y(hrdata[1]) );
  OAI21X1 U948 ( .A(n856), .B(n857), .C(n794), .Y(n855) );
  OAI21X1 U949 ( .A(n648), .B(n816), .C(n858), .Y(n857) );
  AOI22X1 U950 ( .A(new_coeff_reg[1]), .B(n613), .C(result_reg[1]), .D(n818), 
        .Y(n858) );
  INVX1 U951 ( .A(n787), .Y(n613) );
  INVX1 U952 ( .A(f0_reg[1]), .Y(n648) );
  NAND2X1 U953 ( .A(n859), .B(n860), .Y(n856) );
  AOI22X1 U954 ( .A(n821), .B(f2_reg[1]), .C(n822), .D(f1_reg[1]), .Y(n860) );
  INVX1 U955 ( .A(n861), .Y(n821) );
  AOI22X1 U956 ( .A(f3_reg[1]), .B(n823), .C(sample_data[1]), .D(n824), .Y(
        n859) );
  INVX1 U957 ( .A(n862), .Y(n824) );
  NAND2X1 U958 ( .A(n863), .B(n864), .Y(hrdata[15]) );
  AOI22X1 U959 ( .A(n794), .B(n865), .C(n796), .D(f2_reg[15]), .Y(n864) );
  OAI21X1 U960 ( .A(n797), .B(n866), .C(n867), .Y(n865) );
  AOI22X1 U961 ( .A(n800), .B(f0_reg[15]), .C(result_reg[15]), .D(n801), .Y(
        n867) );
  INVX1 U962 ( .A(sample_data[15]), .Y(n866) );
  AOI22X1 U963 ( .A(n802), .B(f1_reg[15]), .C(n803), .D(f3_reg[15]), .Y(n863)
         );
  NAND2X1 U964 ( .A(n868), .B(n869), .Y(hrdata[14]) );
  AOI22X1 U965 ( .A(n794), .B(n870), .C(n796), .D(f2_reg[14]), .Y(n869) );
  OAI21X1 U966 ( .A(n797), .B(n871), .C(n872), .Y(n870) );
  AOI22X1 U967 ( .A(n800), .B(f0_reg[14]), .C(result_reg[14]), .D(n801), .Y(
        n872) );
  INVX1 U968 ( .A(sample_data[14]), .Y(n871) );
  AOI22X1 U969 ( .A(n802), .B(f1_reg[14]), .C(n803), .D(f3_reg[14]), .Y(n868)
         );
  NAND2X1 U970 ( .A(n873), .B(n874), .Y(hrdata[13]) );
  AOI22X1 U971 ( .A(n794), .B(n875), .C(n796), .D(f2_reg[13]), .Y(n874) );
  OAI21X1 U972 ( .A(n797), .B(n876), .C(n877), .Y(n875) );
  AOI22X1 U973 ( .A(n800), .B(f0_reg[13]), .C(result_reg[13]), .D(n801), .Y(
        n877) );
  INVX1 U974 ( .A(sample_data[13]), .Y(n876) );
  AOI22X1 U975 ( .A(n802), .B(f1_reg[13]), .C(n803), .D(f3_reg[13]), .Y(n873)
         );
  NAND2X1 U976 ( .A(n878), .B(n879), .Y(hrdata[12]) );
  AOI22X1 U977 ( .A(n794), .B(n880), .C(n796), .D(f2_reg[12]), .Y(n879) );
  OAI21X1 U978 ( .A(n797), .B(n881), .C(n882), .Y(n880) );
  AOI22X1 U979 ( .A(n800), .B(f0_reg[12]), .C(result_reg[12]), .D(n801), .Y(
        n882) );
  INVX1 U980 ( .A(sample_data[12]), .Y(n881) );
  AOI22X1 U981 ( .A(n802), .B(f1_reg[12]), .C(n803), .D(f3_reg[12]), .Y(n878)
         );
  NAND2X1 U982 ( .A(n883), .B(n884), .Y(hrdata[11]) );
  AOI22X1 U983 ( .A(n794), .B(n885), .C(n796), .D(f2_reg[11]), .Y(n884) );
  OAI21X1 U984 ( .A(n797), .B(n886), .C(n887), .Y(n885) );
  AOI22X1 U985 ( .A(n800), .B(f0_reg[11]), .C(result_reg[11]), .D(n801), .Y(
        n887) );
  INVX1 U986 ( .A(sample_data[11]), .Y(n886) );
  AOI22X1 U987 ( .A(n802), .B(f1_reg[11]), .C(n803), .D(f3_reg[11]), .Y(n883)
         );
  NAND2X1 U988 ( .A(n888), .B(n889), .Y(hrdata[10]) );
  AOI22X1 U989 ( .A(n794), .B(n890), .C(n796), .D(f2_reg[10]), .Y(n889) );
  AND2X1 U990 ( .A(n794), .B(n891), .Y(n796) );
  OAI21X1 U991 ( .A(n762), .B(n760), .C(n892), .Y(n891) );
  NAND3X1 U992 ( .A(n761), .B(n789), .C(prev_hsize), .Y(n892) );
  OAI21X1 U993 ( .A(n797), .B(n893), .C(n894), .Y(n890) );
  AOI22X1 U994 ( .A(n800), .B(f0_reg[10]), .C(result_reg[10]), .D(n801), .Y(
        n894) );
  AND2X1 U995 ( .A(n895), .B(n896), .Y(n801) );
  AND2X1 U996 ( .A(n788), .B(n896), .Y(n800) );
  OAI21X1 U997 ( .A(n897), .B(n791), .C(n760), .Y(n896) );
  INVX1 U998 ( .A(sample_data[10]), .Y(n893) );
  INVX1 U999 ( .A(n812), .Y(n797) );
  OAI21X1 U1000 ( .A(n707), .B(n810), .C(n786), .Y(n812) );
  AOI22X1 U1001 ( .A(n802), .B(f1_reg[10]), .C(n803), .D(f3_reg[10]), .Y(n888)
         );
  NOR2X1 U1002 ( .A(n898), .B(n899), .Y(n803) );
  OAI21X1 U1003 ( .A(prev_hsize), .B(n701), .C(n729), .Y(n899) );
  NAND2X1 U1004 ( .A(n727), .B(n731), .Y(n729) );
  INVX1 U1005 ( .A(n727), .Y(n701) );
  INVX1 U1006 ( .A(n900), .Y(n802) );
  OAI21X1 U1007 ( .A(n676), .B(n901), .C(n794), .Y(n900) );
  NOR2X1 U1008 ( .A(n762), .B(n810), .Y(n901) );
  NAND2X1 U1009 ( .A(n747), .B(prev_hsize), .Y(n810) );
  NOR2X1 U1010 ( .A(n745), .B(n762), .Y(n676) );
  AOI21X1 U1011 ( .A(n902), .B(n903), .C(n898), .Y(hrdata[0]) );
  NAND2X1 U1012 ( .A(state[0]), .B(n614), .Y(n898) );
  INVX1 U1013 ( .A(state[1]), .Y(n614) );
  NOR2X1 U1014 ( .A(n904), .B(n905), .Y(n903) );
  INVX1 U1015 ( .A(n906), .Y(n905) );
  AOI22X1 U1016 ( .A(n823), .B(f3_reg[0]), .C(f1_reg[0]), .D(n822), .Y(n906)
         );
  AOI21X1 U1017 ( .A(n791), .B(n907), .C(n689), .Y(n822) );
  OAI21X1 U1018 ( .A(n747), .B(n790), .C(n789), .Y(n689) );
  OAI21X1 U1019 ( .A(n791), .B(n727), .C(n731), .Y(n823) );
  NAND2X1 U1020 ( .A(n747), .B(n908), .Y(n731) );
  NAND2X1 U1021 ( .A(n790), .B(n908), .Y(n727) );
  OAI21X1 U1022 ( .A(n678), .B(n861), .C(n909), .Y(n904) );
  NAND3X1 U1023 ( .A(n895), .B(n910), .C(status_reg[0]), .Y(n909) );
  OAI21X1 U1024 ( .A(n745), .B(n791), .C(n907), .Y(n910) );
  INVX1 U1025 ( .A(n747), .Y(n907) );
  NAND2X1 U1026 ( .A(n789), .B(n911), .Y(n861) );
  INVX1 U1027 ( .A(n762), .Y(n789) );
  NAND2X1 U1028 ( .A(prev_haddr[3]), .B(n912), .Y(n762) );
  INVX1 U1029 ( .A(f2_reg[0]), .Y(n678) );
  NOR2X1 U1030 ( .A(n913), .B(n914), .Y(n902) );
  OAI21X1 U1031 ( .A(n646), .B(n816), .C(n915), .Y(n914) );
  NAND2X1 U1032 ( .A(result_reg[0]), .B(n818), .Y(n915) );
  AND2X1 U1033 ( .A(n895), .B(n911), .Y(n818) );
  INVX1 U1034 ( .A(n811), .Y(n895) );
  NAND2X1 U1035 ( .A(n916), .B(n912), .Y(n811) );
  NAND2X1 U1036 ( .A(n788), .B(n911), .Y(n816) );
  OAI21X1 U1037 ( .A(n791), .B(n760), .C(n897), .Y(n911) );
  INVX1 U1038 ( .A(n761), .Y(n897) );
  NAND2X1 U1039 ( .A(prev_haddr[0]), .B(prev_haddr[1]), .Y(n760) );
  INVX1 U1040 ( .A(prev_hsize), .Y(n791) );
  INVX1 U1041 ( .A(f0_reg[0]), .Y(n646) );
  OAI22X1 U1042 ( .A(n787), .B(n605), .C(n862), .D(n628), .Y(n913) );
  INVX1 U1043 ( .A(sample_data[0]), .Y(n628) );
  AOI22X1 U1044 ( .A(n788), .B(n747), .C(prev_hsize), .D(n642), .Y(n862) );
  INVX1 U1045 ( .A(n786), .Y(n642) );
  NAND2X1 U1046 ( .A(n790), .B(n788), .Y(n786) );
  INVX1 U1047 ( .A(n745), .Y(n790) );
  NAND2X1 U1048 ( .A(prev_haddr[0]), .B(n917), .Y(n745) );
  NOR2X1 U1049 ( .A(prev_haddr[0]), .B(prev_haddr[1]), .Y(n747) );
  INVX1 U1050 ( .A(n707), .Y(n788) );
  NAND2X1 U1051 ( .A(prev_haddr[2]), .B(n916), .Y(n707) );
  INVX1 U1052 ( .A(new_coefficient_set), .Y(n605) );
  NAND2X1 U1053 ( .A(n761), .B(n908), .Y(n787) );
  NOR2X1 U1054 ( .A(n916), .B(n912), .Y(n908) );
  INVX1 U1055 ( .A(prev_haddr[2]), .Y(n912) );
  INVX1 U1056 ( .A(prev_haddr[3]), .Y(n916) );
  NOR2X1 U1057 ( .A(n917), .B(prev_haddr[0]), .Y(n761) );
  INVX1 U1058 ( .A(prev_haddr[1]), .Y(n917) );
  NAND2X1 U1059 ( .A(n918), .B(n919), .Y(fir_coefficient[9]) );
  AOI22X1 U1060 ( .A(n920), .B(f3_reg[9]), .C(n586), .D(f2_reg[9]), .Y(n919)
         );
  AOI22X1 U1061 ( .A(n922), .B(f1_reg[9]), .C(n587), .D(f0_reg[9]), .Y(n918)
         );
  NAND2X1 U1062 ( .A(n924), .B(n925), .Y(fir_coefficient[8]) );
  AOI22X1 U1063 ( .A(n920), .B(f3_reg[8]), .C(n586), .D(f2_reg[8]), .Y(n925)
         );
  AOI22X1 U1064 ( .A(n922), .B(f1_reg[8]), .C(n587), .D(f0_reg[8]), .Y(n924)
         );
  NAND2X1 U1065 ( .A(n926), .B(n927), .Y(fir_coefficient[7]) );
  AOI22X1 U1066 ( .A(n920), .B(f3_reg[7]), .C(n586), .D(f2_reg[7]), .Y(n927)
         );
  AOI22X1 U1067 ( .A(n922), .B(f1_reg[7]), .C(n587), .D(f0_reg[7]), .Y(n926)
         );
  NAND2X1 U1068 ( .A(n928), .B(n929), .Y(fir_coefficient[6]) );
  AOI22X1 U1069 ( .A(n920), .B(f3_reg[6]), .C(n586), .D(f2_reg[6]), .Y(n929)
         );
  AOI22X1 U1070 ( .A(n922), .B(f1_reg[6]), .C(n587), .D(f0_reg[6]), .Y(n928)
         );
  NAND2X1 U1071 ( .A(n930), .B(n931), .Y(fir_coefficient[5]) );
  AOI22X1 U1072 ( .A(n920), .B(f3_reg[5]), .C(n586), .D(f2_reg[5]), .Y(n931)
         );
  AOI22X1 U1073 ( .A(n922), .B(f1_reg[5]), .C(n587), .D(f0_reg[5]), .Y(n930)
         );
  NAND2X1 U1074 ( .A(n932), .B(n933), .Y(fir_coefficient[4]) );
  AOI22X1 U1075 ( .A(n920), .B(f3_reg[4]), .C(n586), .D(f2_reg[4]), .Y(n933)
         );
  AOI22X1 U1076 ( .A(n922), .B(f1_reg[4]), .C(n587), .D(f0_reg[4]), .Y(n932)
         );
  NAND2X1 U1077 ( .A(n934), .B(n935), .Y(fir_coefficient[3]) );
  AOI22X1 U1078 ( .A(n920), .B(f3_reg[3]), .C(n586), .D(f2_reg[3]), .Y(n935)
         );
  AOI22X1 U1079 ( .A(n922), .B(f1_reg[3]), .C(n587), .D(f0_reg[3]), .Y(n934)
         );
  NAND2X1 U1080 ( .A(n936), .B(n937), .Y(fir_coefficient[2]) );
  AOI22X1 U1081 ( .A(n920), .B(f3_reg[2]), .C(n586), .D(f2_reg[2]), .Y(n937)
         );
  AOI22X1 U1082 ( .A(n922), .B(f1_reg[2]), .C(n587), .D(f0_reg[2]), .Y(n936)
         );
  NAND2X1 U1083 ( .A(n938), .B(n939), .Y(fir_coefficient[1]) );
  AOI22X1 U1084 ( .A(n920), .B(f3_reg[1]), .C(n586), .D(f2_reg[1]), .Y(n939)
         );
  AOI22X1 U1085 ( .A(n922), .B(f1_reg[1]), .C(n587), .D(f0_reg[1]), .Y(n938)
         );
  NAND2X1 U1086 ( .A(n940), .B(n941), .Y(fir_coefficient[15]) );
  AOI22X1 U1087 ( .A(n920), .B(f3_reg[15]), .C(n586), .D(f2_reg[15]), .Y(n941)
         );
  AOI22X1 U1088 ( .A(n922), .B(f1_reg[15]), .C(n587), .D(f0_reg[15]), .Y(n940)
         );
  NAND2X1 U1089 ( .A(n942), .B(n943), .Y(fir_coefficient[14]) );
  AOI22X1 U1090 ( .A(n920), .B(f3_reg[14]), .C(n586), .D(f2_reg[14]), .Y(n943)
         );
  AOI22X1 U1091 ( .A(n922), .B(f1_reg[14]), .C(n587), .D(f0_reg[14]), .Y(n942)
         );
  NAND2X1 U1092 ( .A(n944), .B(n945), .Y(fir_coefficient[13]) );
  AOI22X1 U1093 ( .A(n920), .B(f3_reg[13]), .C(n586), .D(f2_reg[13]), .Y(n945)
         );
  AOI22X1 U1094 ( .A(n922), .B(f1_reg[13]), .C(n587), .D(f0_reg[13]), .Y(n944)
         );
  NAND2X1 U1095 ( .A(n946), .B(n947), .Y(fir_coefficient[12]) );
  AOI22X1 U1096 ( .A(n920), .B(f3_reg[12]), .C(n586), .D(f2_reg[12]), .Y(n947)
         );
  AOI22X1 U1097 ( .A(n922), .B(f1_reg[12]), .C(n587), .D(f0_reg[12]), .Y(n946)
         );
  NAND2X1 U1098 ( .A(n948), .B(n949), .Y(fir_coefficient[11]) );
  AOI22X1 U1099 ( .A(n920), .B(f3_reg[11]), .C(n586), .D(f2_reg[11]), .Y(n949)
         );
  AOI22X1 U1100 ( .A(n922), .B(f1_reg[11]), .C(n587), .D(f0_reg[11]), .Y(n948)
         );
  NAND2X1 U1101 ( .A(n950), .B(n951), .Y(fir_coefficient[10]) );
  AOI22X1 U1102 ( .A(n920), .B(f3_reg[10]), .C(n586), .D(f2_reg[10]), .Y(n951)
         );
  AOI22X1 U1103 ( .A(n922), .B(f1_reg[10]), .C(n587), .D(f0_reg[10]), .Y(n950)
         );
  NAND2X1 U1104 ( .A(n952), .B(n953), .Y(fir_coefficient[0]) );
  AOI22X1 U1105 ( .A(n920), .B(f3_reg[0]), .C(n586), .D(f2_reg[0]), .Y(n953)
         );
  NOR2X1 U1106 ( .A(n954), .B(coefficient_num[0]), .Y(n921) );
  NAND2X1 U1107 ( .A(coefficient_num[1]), .B(coefficient_num[0]), .Y(n608) );
  AOI22X1 U1108 ( .A(n922), .B(f1_reg[0]), .C(n587), .D(f0_reg[0]), .Y(n952)
         );
  NOR2X1 U1109 ( .A(coefficient_num[0]), .B(coefficient_num[1]), .Y(n923) );
  INVX1 U1110 ( .A(coefficient_num[1]), .Y(n954) );
  AND2X1 U1111 ( .A(hsel), .B(n955), .Y(N96) );
  OAI21X1 U1112 ( .A(n622), .B(n625), .C(n619), .Y(n955) );
  NAND3X1 U1113 ( .A(haddr[1]), .B(haddr[0]), .C(n956), .Y(n619) );
  NOR2X1 U1114 ( .A(n957), .B(n958), .Y(n956) );
  NAND2X1 U1115 ( .A(n958), .B(n957), .Y(n625) );
  INVX1 U1116 ( .A(haddr[2]), .Y(n957) );
  INVX1 U1117 ( .A(haddr[3]), .Y(n958) );
  INVX1 U1118 ( .A(hwrite), .Y(n622) );
endmodule

