onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Test Info} -label {Test Num} /tb_rcv_block/tb_test_num
add wave -noupdate -expand -group {Test Info} -label {Test Case} /tb_rcv_block/tb_test_case
add wave -noupdate -expand -group {Test Info} -label {Test Data} /tb_rcv_block/tb_test_data
add wave -noupdate -expand -group {Test Info} -label {Test Stop Bit} /tb_rcv_block/tb_test_stop_bit
add wave -noupdate -expand -group {Test Info} -label {Test Bit Period} /tb_rcv_block/tb_test_bit_period
add wave -noupdate -group Inputs -label Clk /tb_rcv_block/tb_clk
add wave -noupdate -group Inputs -label N_Rst /tb_rcv_block/tb_n_rst
add wave -noupdate -group Inputs -label {Serial In} /tb_rcv_block/tb_serial_in
add wave -noupdate -group Inputs -label {Data Read} /tb_rcv_block/tb_data_read
add wave -noupdate -expand -group {RX Data} -label {Rx Data} /tb_rcv_block/tb_rx_data
add wave -noupdate -expand -group {RX Data} -label {Expected RX Data} /tb_rcv_block/tb_expected_rx_data
add wave -noupdate -expand -group {Data Ready} -label {Data Ready} /tb_rcv_block/tb_data_ready
add wave -noupdate -expand -group {Data Ready} -label {Expected Data Ready} /tb_rcv_block/tb_expected_data_ready
add wave -noupdate -expand -group {Overrun Error} -label Overrun /tb_rcv_block/tb_overrun_error
add wave -noupdate -expand -group {Overrun Error} -label {Expected Overrun} /tb_rcv_block/tb_expected_overrun
add wave -noupdate -expand -group {Framing Error} -label {Framing Error} /tb_rcv_block/tb_framing_error
add wave -noupdate -expand -group {Framing Error} -label {Expected Framing Error} /tb_rcv_block/tb_expected_framing_error
add wave -noupdate -expand -group RCU -label {New Packet Detected} /tb_rcv_block/DUT/RCU/new_packet_detected
add wave -noupdate -expand -group RCU -label {Packet Done} /tb_rcv_block/DUT/RCU/packet_done
add wave -noupdate -expand -group RCU -label {Framing Error} /tb_rcv_block/DUT/RCU/framing_error
add wave -noupdate -expand -group RCU -label {SBC Clear} /tb_rcv_block/DUT/RCU/sbc_clear
add wave -noupdate -expand -group RCU -label {SBC Enable} /tb_rcv_block/DUT/RCU/sbc_enable
add wave -noupdate -expand -group RCU -label {Load Buffer} /tb_rcv_block/DUT/RCU/load_buffer
add wave -noupdate -expand -group RCU -label {Enable Timer} /tb_rcv_block/DUT/RCU/enable_timer
add wave -noupdate -label state /tb_rcv_block/DUT/RCU/s
add wave -noupdate -label next_state /tb_rcv_block/DUT/RCU/next_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1186250 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1134262 ps} {1231839 ps}
