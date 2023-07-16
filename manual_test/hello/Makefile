LLVM_BIN=../../llvm-project/build/bin
CC=$(LLVM_BIN)/clang
CXX=$(LLVM_BIN)/clang++

CFLAGS=-m64 -fsanitize=x
CXXFLAGS=$(CFLAGS)

DFSANFLAGS=-m64 -fsanitize=dataflow

.PHONY: clean
all: hello.exe
hello.exe: hello.c
	$(CC) $(CFLAGS) -o $@ $<
dfsan: hello.c
	$(CC) $(DFSANFLAGS) -o $@.exe $<
clean:
	rm $(wildcard *.exe)
