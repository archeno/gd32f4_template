.PHONY: all clean build config flash
all: build

config:
	cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release	

build: config
	cmake --build build

flash:
	openocd -f interface/cmsis-dap.cfg -f target/stm32f4x.cfg -c "program build/gd32f4_template.elf verify reset exit"

clean:
	rm -rf build
