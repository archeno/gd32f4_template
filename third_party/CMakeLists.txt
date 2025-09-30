cmake_minimum_required(VERSION 3.20)

if(NOT TARGET gd32f4xx_config)
	message(FATAL_ERROR "gd32f4xx_config target not found. Please add gd32f4xx_libopt.h and CMakeLists.txt in  src/config directory ")
endif()

add_library(gd32f4_hal)

set(gd32f4_hal_dir ${CMAKE_CURRENT_SOURCE_DIR}/GD32Firmware/GD32F4XX/GD32F4xx_standard_peripheral)
set(gd32f4_cmsis_core_dir ${CMAKE_CURRENT_SOURCE_DIR}/GD32Firmware/GD32F4XX/CMSIS)
set(gd32f4_cmsis_device_dir ${CMAKE_CURRENT_SOURCE_DIR}/GD32Firmware/GD32F4XX/CMSIS/GD/GD32F4xx)

file(GLOB_RECURSE gd32f4_hal_srcs CONFIGURE_DEPENDS
	${gd32f4_hal_dir}/*.c
	${gd32f4_cmsis_core_dir}/*.c
)
target_sources(gd32f4_hal PRIVATE
	${gd32f4_hal_srcs}
)

target_include_directories(gd32f4_hal PUBLIC
	${gd32f4_hal_dir}/Include
	${gd32f4_cmsis_core_dir}
	${gd32f4_cmsis_device_dir}/Include
)

target_link_libraries(gd32f4_hal PUBLIC gd32f4xx_config)

# get_target_property(gd32f4_hal_include_dirs gd32f4_hal INCLUDE_DIRECTORIES)
# message(STATUS "GD32F4xx HAL sources: ${gd32f4_hal_srcs}")
# message(STATUS "GD32F4xx HAL include directories: ${gd32f4_hal_include_dirs}")