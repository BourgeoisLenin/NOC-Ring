onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /router_output_ctrl_tb/dut/clk
add wave -noupdate /router_output_ctrl_tb/dut/reset
add wave -noupdate /router_output_ctrl_tb/dut/polarity
add wave -noupdate /router_output_ctrl_tb/dut/req1
add wave -noupdate /router_output_ctrl_tb/dut/req2
add wave -noupdate /router_output_ctrl_tb/dut/ro
add wave -noupdate /router_output_ctrl_tb/dut/di1
add wave -noupdate /router_output_ctrl_tb/dut/di2
add wave -noupdate /router_output_ctrl_tb/dut/ack1
add wave -noupdate /router_output_ctrl_tb/dut/ack2
add wave -noupdate /router_output_ctrl_tb/dut/dout
add wave -noupdate /router_output_ctrl_tb/dut/so
add wave -noupdate /router_output_ctrl_tb/dut/arb_ack1
add wave -noupdate /router_output_ctrl_tb/dut/arb_ack2
add wave -noupdate /router_output_ctrl_tb/dut/odd_full
add wave -noupdate /router_output_ctrl_tb/dut/even_full
add wave -noupdate /router_output_ctrl_tb/dut/odd_buf
add wave -noupdate /router_output_ctrl_tb/dut/even_buf
add wave -noupdate /router_output_ctrl_tb/hop1
add wave -noupdate /router_output_ctrl_tb/hop2
add wave -noupdate /router_output_ctrl_tb/clk_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
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
WaveRestoreZoom {6 ns} {61 ns}
