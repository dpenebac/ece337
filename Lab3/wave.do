onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_adder_16bit/tb_test_case_num
add wave -noupdate /tb_adder_16bit/tb_test_case
add wave -noupdate /tb_adder_16bit/tb_test_case_stage
add wave -noupdate -format Event -radix decimal /tb_adder_16bit/tb_test_case_err
add wave -noupdate -divider {DUT Signals}
add wave -noupdate -expand -group Inputs -color Blue -radix decimal /tb_adder_16bit/tb_a
add wave -noupdate -expand -group Inputs -color Blue -radix decimal /tb_adder_16bit/tb_b
add wave -noupdate -expand -group Inputs -color Blue -format Literal -radix decimal /tb_adder_16bit/tb_carry_in
add wave -noupdate -expand -group Sum -color Green -radix decimal /tb_adder_16bit/tb_sum
add wave -noupdate -expand -group Sum -color Green -radix decimal /tb_adder_16bit/tb_expected_sum
add wave -noupdate -expand -group Overflow -color Red -format Literal -radix decimal /tb_adder_16bit/tb_overflow
add wave -noupdate -expand -group Overflow -color Red -format Literal -radix decimal /tb_adder_16bit/tb_expected_overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9497 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 252
configure wave -valuecolwidth 106
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
WaveRestoreZoom {0 ps} {44632 ps}
