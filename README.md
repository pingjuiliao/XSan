# XSanitizer
A learning repo to build a LLVM sanitizer.   
For now, it simply logs the calling context.    

## Build sanitizer
```
mkdir build
cd build && cmake ..
make llvm-rebuild # remove and re-create the ./llvm-project/build directory 
```

## usage: run sanitizer
```
./llvm-project/build/bin/clang -m64 -fsanitize=x -o hello.exe hello.c
```
See manual_test for more usage.

## Some minor changes
This repo made several changes to [trailofbits_sanitizer_tutorial][1]. 
1. Building the whole llvm-project-16.0.0
  - so some APIs are changed.
  - so it includes some redundant codes.
  - see CMakeLists.txt for my build configuration.
2. Using the new pass manager (therefore, no out-of-source build)

## TODOs
1. make sanitizer useful
2. integrate some testcases into CMake
  - manual_test are intentionally out of CMake scope.

## Integrating LLVM Sanitizer in different llvm versions
As [trailofbits_sanitizer_tutorial][1] mentioned, following how `dfsan` is implemented. 
The reason is that the codes related to `dfsan` are shorter than other sanitizers (asan, msan, ...).  
Use the `grep` to search how it is implemented in the codes would help a lot.
Note that the keywords are not just `dfsan` but also `Dfsan`, `DataFlow`, `DataFlowSanitizer`.  

## Reference
[Trailofbits_sanitizer_tutorial](https://github.com/trailofbits/llvm-sanitizer-tutorial/tree/master)

[1]: <https://github.com/trailofbits/llvm-sanitizer-tutorial/tree/master> "trailofbits_sanitizer_tutorial"
