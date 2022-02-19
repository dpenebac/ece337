onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {Test Case} /tb_mealy/tb_test_case
add wave -noupdate -label CLK /tb_mealy/tb_clk
add wave -noupdate -label NRST /tb_mealy/tb_n_rst
add wave -noupdate -label I /tb_mealy/tb_i
add wave -noupdate -label O /tb_mealy/tb_o
add wave -noupdate -label {Expected O} /tb_mealy/expected_o
add wave -noupdate -label Mismatch /tb_mealy/tb_mismatch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20518 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {13554 ps} {55620 ps}
