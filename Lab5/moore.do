onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {Test Case} /tb_moore/tb_test_case
add wave -noupdate -label CLK /tb_moore/tb_clk
add wave -noupdate -label RST /tb_moore/tb_n_rst
add wave -noupdate -label {Input Stream} /tb_moore/inputStream
add wave -noupdate -label {Output Stream} /tb_moore/outputStream
add wave -noupdate -label I /tb_moore/tb_i
add wave -noupdate -label O /tb_moore/tb_o
add wave -noupdate -label {Expected O} /tb_moore/expected_o
add wave -noupdate -label Check /tb_moore/tb_check
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49947 ps} 0}
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
