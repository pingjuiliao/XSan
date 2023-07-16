#ifndef XSAN_H
#define XSAN_H

#include "sanitizer_common/sanitizer_internal_defs.h"

extern "C" {

void xsan_call_trace(char* caller, char* callee);
void xsan_ret_trace(char* callee, char* caller);

}
#endif // XSAN_H
