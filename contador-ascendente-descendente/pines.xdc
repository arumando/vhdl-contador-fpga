set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN V10 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN U11  [get_ports hold]  
set_property IOSTANDARD LVCMOS33 [get_ports hold]

set_property PACKAGE_PIN U12  [get_ports load]   
set_property IOSTANDARD LVCMOS33 [get_ports load]

set_property PACKAGE_PIN H6  [get_ports updown]   
set_property IOSTANDARD LVCMOS33 [get_ports updown]


set_property PACKAGE_PIN H17 [get_ports {dato[0]}] 
set_property PACKAGE_PIN K15 [get_ports {dato[1]}]
set_property PACKAGE_PIN J13 [get_ports {dato[2]}]
set_property PACKAGE_PIN N14 [get_ports {dato[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dato[*]}]


set_property PACKAGE_PIN J15 [get_ports {datoload[0]}] 
set_property PACKAGE_PIN L16 [get_ports {datoload[1]}]
set_property PACKAGE_PIN M13 [get_ports {datoload[2]}]
set_property PACKAGE_PIN R15 [get_ports {datoload[3]}]
set_property PACKAGE_PIN R17 [get_ports {datoload[4]}]
set_property PACKAGE_PIN T18 [get_ports {datoload[5]}]
set_property PACKAGE_PIN U18 [get_ports {datoload[6]}]
set_property PACKAGE_PIN R13 [get_ports {datoload[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {datoload[*]}]

############################
## DISPLAY 7 SEGMENTOS
############################
set_property PACKAGE_PIN T10 [get_ports {datoSeg[0]}]
set_property PACKAGE_PIN R10 [get_ports {datoSeg[1]}]
set_property PACKAGE_PIN K16 [get_ports {datoSeg[2]}]
set_property PACKAGE_PIN K13 [get_ports {datoSeg[3]}]
set_property PACKAGE_PIN P15 [get_ports {datoSeg[4]}]
set_property PACKAGE_PIN T11 [get_ports {datoSeg[5]}]
set_property PACKAGE_PIN L18 [get_ports {datoSeg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {datoSeg[*]}]

############################
## CONTROL DE DISPLAYS
############################
set_property PACKAGE_PIN J17 [get_ports {controlSeg[0]}]
set_property PACKAGE_PIN J18 [get_ports {controlSeg[1]}]
set_property PACKAGE_PIN T9  [get_ports {controlSeg[2]}]
set_property PACKAGE_PIN J14 [get_ports {controlSeg[3]}]
set_property PACKAGE_PIN P14 [get_ports {controlSeg[4]}]
set_property PACKAGE_PIN T14 [get_ports {controlSeg[5]}]
set_property PACKAGE_PIN K2  [get_ports {controlSeg[6]}]
set_property PACKAGE_PIN U13 [get_ports {controlSeg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {controlSeg[*]}]