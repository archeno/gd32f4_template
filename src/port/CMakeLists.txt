add_library(gd32f4_port OBJECT
	startup_gd32f4xx.s
	syscall.c
)

set(LD_SCRIPT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/gd32f4xx.ld" PARENT_SCOPE)
