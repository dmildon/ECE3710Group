set_global_assignment -entity "vgaClkDivider" -library "lib_vgaClkDivider" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "vgaClkDivider" -library "lib_vgaClkDivider" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "vgaClkDivider" -library "lib_vgaClkDivider" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_vgaClkDivider" -name SPD_FILE [file join $::quartus(sip_path) "vgaClkDivider.spd"]

set_global_assignment -library "lib_vgaClkDivider" -name MISC_FILE [file join $::quartus(sip_path) "vgaClkDivider_sim/vgaClkDivider.vo"]
