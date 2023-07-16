LLVM_BIN=../../llvm-project/build/bin
CC=$(LLVM_BIN)/clang
CXX=$(LLVM_BIN)/clang++

CFLAGS=-m64 -fsanitize=x
CXXFLAGS=$(CFLAGS)

.PHONY: clean
all: hello.exe
hello.exe: hello.c
	$(CC) $(CFLAGS) -o $@ $<
clean:
	rm $(wildcard *.exe)
