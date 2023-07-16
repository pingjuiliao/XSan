#include "xsan/xsan.h"
#include <stdio.h>
#include <stdlib.h>


extern "C" SANITIZER_INTERFACE_ATTRIBUTE
void __xsan_call_trace(char* caller, char* callee) {
  printf("[XSan] |%s| calling... |%s|\n", caller, callee);
}

extern "C" SANITIZER_INTERFACE_ATTRIBUTE
void __xsan_ret_trace(char* callee, char* caller) {
  printf("[XSan] |%s| ret back to |%s|\n", callee, caller); 
}
