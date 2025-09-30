cmake_minimum_required(VERSION 3.20)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/toolchain_arm_gcc.cmake CACHE STRING "Toolchain file")
project(gd32f4_template VERSION 1.0.0 LANGUAGES C CXX ASM)

add_subdirectory(src/config)
add_subdirectory(src/port)
add_subdirectory(third_party)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE
	src/app/main.c
	$<TARGET_OBJECTS:gd32f4_port>
)

target_link_libraries(${PROJECT_NAME} PRIVATE
	gd32f4_hal
)

if(LD_SCRIPT_FILE)
	target_link_options(${PROJECT_NAME} PRIVATE "-T${LD_SCRIPT_FILE}")
else()
	message(FATAL_ERROR "LD_SCRIPT_FILE is not set. Please set LD_SCRIPT_FILE in src/port/CMakeLists.txt")
endif()