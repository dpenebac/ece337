onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {Test Case} /tb_stp_sr_4_lsb/tb_test_case
add wave -noupdate -label CLK /tb_stp_sr_4_lsb/tb_clk
add wave -noupdate -label N_Rst /tb_stp_sr_4_lsb/tb_n_rst
add wave -noupdate -label {Shift Enable} /tb_stp_sr_4_lsb/tb_shift_enable
add wave -noupdate -label {Serial In} /tb_stp_sr_4_lsb/tb_serial_in
add wave -noupdate -label {Expected Out} /tb_stp_sr_4_lsb/tb_expected_ouput
add wave -noupdate -label {Parallel Out} /tb_stp_sr_4_lsb/tb_parallel_out
add wave -noupdate -label Mismatc /tb_stp_sr_4_lsb/tb_mismatch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {247097 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 133
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
configure wave -timelineunits ns
update
WaveRestoreZoom {175778 ps} {233279 ps}
