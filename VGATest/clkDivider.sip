set_global_assignment -entity "clkDivider" -library "lib_clkDivider" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clkDivider" -library "lib_clkDivider" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "clkDivider" -library "lib_clkDivider" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clkDivider" -name SPD_FILE [file join $::quartus(sip_path) "clkDivider.spd"]

set_global_assignment -library "lib_clkDivider" -name MISC_FILE [file join $::quartus(sip_path) "clkDivider_sim/clkDivider.vo"]
