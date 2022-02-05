onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Tests /tb_flex_counter/test_num
add wave -noupdate -expand -group Tests /tb_flex_counter/test_case
add wave -noupdate -expand -group Inputs -label Clk /tb_flex_counter/tb_clk
add wave -noupdate -expand -group Inputs -label Reset /tb_flex_counter/tb_n_rst
add wave -noupdate -expand -group Inputs -label Clear /tb_flex_counter/tb_clear
add wave -noupdate -expand -group Inputs -label Enable /tb_flex_counter/tb_count_enable
add wave -noupdate -expand -group Inputs -label {Rollover Value} -radix unsigned /tb_flex_counter/tb_rollover_val
add wave -noupdate -expand -group Outputs -color gold -label {Expected Out} -radix unsigned /tb_flex_counter/expected_out
add wave -noupdate -expand -group Outputs -label {Count Out} -radix unsigned /tb_flex_counter/tb_count_out
add wave -noupdate -expand -group Outputs -color gold -label {Expected Flag} /tb_flex_counter/expected_flag
add wave -noupdate -expand -group Outputs -label {Rollover Flag} /tb_flex_counter/tb_rollover_flag
add wave -noupdate -expand -group Error -color red -label {Count Error} /tb_flex_counter/countError
add wave -noupdate -expand -group Error -color red -label {Flag Error} /tb_flex_counter/flagError
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34296 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {12123 ps} {51994 ps}
