onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {Test Case} /tb_pts_sr_4_lsb/tb_test_case
add wave -noupdate -label CLK /tb_pts_sr_4_lsb/tb_clk
add wave -noupdate -label N_RST /tb_pts_sr_4_lsb/tb_n_rst
add wave -noupdate -label {Shift Enable} /tb_pts_sr_4_lsb/tb_shift_enable
add wave -noupdate -label {Load Enable} /tb_pts_sr_4_lsb/tb_load_enable
add wave -noupdate -label {Parallel In} /tb_pts_sr_4_lsb/tb_parallel_in
add wave -noupdate -label {Serial out} /tb_pts_sr_4_lsb/tb_serial_out
add wave -noupdate -label {Expected Out} /tb_pts_sr_4_lsb/tb_expected_ouput
add wave -noupdate -label Mismatch /tb_pts_sr_4_lsb/tb_mismatch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53748 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 144
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
WaveRestoreZoom {0 ps} {59318 ps}
