add_library(gd32f4xx_config INTERFACE)
target_include_directories(gd32f4xx_config INTERFACE
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
	$<INSTALL_INTERFACE:include>
)

target_compile_definitions(gd32f4xx_config INTERFACE
	-DGD32F425
)
install(TARGETS gd32f4xx_config EXPORT gd32f4xx_HalTargets
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	RUNTIME DESTINATION bin
	INCLUDES DESTINATION include
)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
