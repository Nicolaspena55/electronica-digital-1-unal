all: syn pnr pack config

syn:
	yosys -p "synth_ice40 -top top -json top.json" top.v

pnr:
	nextpnr-ice40 --hx4k --package tq144\
	 --json top.json --pcf top.pcf --asc top.pnr
	 
pack:
	icepack top.pnr top.bin
	

config:
	stty -F /dev/ttyACM0 raw
	cat top.bin > /dev/ttyACM0
