onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/clk
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/reset
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/di
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/polarity
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/si
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/ri
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/req
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/ack
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/odd_full
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/odd_buf
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/even_full
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/even_buf
add wave -noupdate -radix unsigned /router_input_ctrl_tb/dut/dout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 146
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
WaveRestoreZoom {9 ns} {39 ns}
