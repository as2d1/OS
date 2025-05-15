main.out: 
	g++ -o main.out main.o c_func.o cpp_func.o asm_func.o -m32
build:
	gcc -o c_func.o -m32 -c c_func.c
	g++ -o cpp_func.o -m32 -c cpp_func.cpp 
	g++ -o main.o -m32 -c main.cpp
	nasm -o asm_func.o -f elf32 asm_func.asm
clean:
	rm *.oS