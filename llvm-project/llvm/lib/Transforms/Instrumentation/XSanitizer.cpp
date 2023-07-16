#include "llvm/Transforms/Instrumentation/XSanitizer.h"

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

PreservedAnalyses XSanitizerPass::run(Module &M, 
                                      ModuleAnalysisManager &AM) {
  for (auto &F: M) {
    errs() << "[XSan] " << F.getName() << "\n";
  }
  return PreservedAnalyses::all();
}

