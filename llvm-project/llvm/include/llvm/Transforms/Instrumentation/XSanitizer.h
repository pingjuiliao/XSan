#ifndef LLVM_TRANSFORMS_INSTRUMENTATION_XSANITIZER_H
#define LLVM_TRANSFORMS_INSTRUMENTATION_XSANITIZER_H

#include "llvm/IR/PassManager.h"

#define XSAN_PREFIX "__xsan"

namespace llvm {

class XSanitizerPass : public PassInfoMixin<XSanitizerPass> {
public:
  static char ID;
  PreservedAnalyses run(Module&, ModuleAnalysisManager&);
private:
  void InstrumentXSanCallSiteTrace(CallInst*, Function&);
};
}

#endif  // LLVM_TRANSFORMS_INSTRUMENTATION_XSANITIZER_H
