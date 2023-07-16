#include "llvm/Transforms/Instrumentation/XSanitizer.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <string>

using namespace llvm;

PreservedAnalyses XSanitizerPass::run(Module &M, 
                                      ModuleAnalysisManager &AM) {
  
  for (auto &F: M) {
    if (F.isDeclaration() || F.isIntrinsic())
      continue;
    if (F.getName().starts_with(XSAN_PREFIX))
      continue;
    for (Instruction &I: instructions(F)) {
      if (CallInst* CI = dyn_cast<CallInst>(&I)) {
        Function* Callee = CI->getCalledFunction();
        if (!Callee || Callee->isIntrinsic() || 
            Callee->getName().starts_with(XSAN_PREFIX))
          continue;
        InstrumentXSanCallSiteTrace(CI, F);   
      }
    }
  }
  return PreservedAnalyses::all();
}


void XSanitizerPass::InstrumentXSanCallSiteTrace(CallInst* CI,
                                                 Function &F) {
  Module* M = F.getParent();
  LLVMContext &Ctx = M->getContext();
  FunctionCallee XSanCallTrace = M->getOrInsertFunction(XSAN_PREFIX "_call_trace",
      FunctionType::get(Type::getVoidTy(Ctx),
                        {Type::getInt8PtrTy(Ctx), Type::getInt8PtrTy(Ctx)},
                        false)
      );
  FunctionCallee XSanRetTrace = M->getOrInsertFunction(XSAN_PREFIX "_ret_trace",
      FunctionType::get(Type::getVoidTy(Ctx),
                        {Type::getInt8PtrTy(Ctx), Type::getInt8PtrTy(Ctx)},
                        false)
      );

  IRBuilder<> IRB(CI);
  Constant* CallerStr = IRB.CreateGlobalStringPtr(F.getName());
  Constant* CalleeStr = IRB.CreateGlobalStringPtr(
      CI->getCalledOperand()->getName());
  IRB.CreateCall(XSanCallTrace, {CallerStr, CalleeStr});
  IRB.SetInsertPoint(CI->getNextNode());
  IRB.CreateCall(XSanRetTrace, {CalleeStr, CallerStr});
  return;
}

