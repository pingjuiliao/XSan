; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple powerpc-ibm-aix-xcoff -mcpu=pwr4 \
; RUN:     -mattr=+altivec -vec-extabi -xcoff-traceback-table=true < %s | \
; RUN:   FileCheck --check-prefix=CHECK-ASM32 %s

; RUN: llc -verify-machineinstrs -mtriple powerpc64-ibm-aix-xcoff -mcpu=pwr4 \
; RUN:     -mattr=+altivec -vec-extabi -xcoff-traceback-table=true < %s | \
; RUN:   FileCheck --check-prefix=CHECK-ASM64 %s

@var = local_unnamed_addr global i32 0

define i32 @varalloca() local_unnamed_addr {
; CHECK-ASM32-LABEL: varalloca:
; CHECK-ASM32:       # %bb.0: # %entry
; CHECK-ASM32-NEXT:    stw 31, -4(1)
; CHECK-ASM32-NEXT:    stwu 1, -48(1)
; CHECK-ASM32-NEXT:    lwz 3, L..C0(2) # @var
; CHECK-ASM32-NEXT:    mr 31, 1
; CHECK-ASM32-NEXT:    addi 4, 31, 48
; CHECK-ASM32-NEXT:    lwz 3, 0(3)
; CHECK-ASM32-NEXT:    addi 3, 3, 15
; CHECK-ASM32-NEXT:    rlwinm 3, 3, 0, 0, 27
; CHECK-ASM32-NEXT:    neg 3, 3
; CHECK-ASM32-NEXT:    stwux 4, 1, 3
; CHECK-ASM32-NEXT:    addi 3, 1, 32
; CHECK-ASM32-NEXT:    lwz 3, 0(3)
; CHECK-ASM32-NEXT:    lwz 1, 0(1)
; CHECK-ASM32-NEXT:    lwz 31, -4(1)
; CHECK-ASM32-NEXT:    blr
; CHECK-ASM32-NEXT:    L..varalloca0:
; CHECK-ASM32-NEXT:    	.vbyte	4, 0x00000000                   # Traceback table begin
; CHECK-ASM32-NEXT:    	.byte	0x00                            # Version = 0
; CHECK-ASM32-NEXT:    	.byte	0x09                            # Language = CPlusPlus
; CHECK-ASM32-NEXT:    	.byte	0x20                            # -IsGlobaLinkage, -IsOutOfLineEpilogOrPrologue
; CHECK-ASM32-NEXT:                                            # +HasTraceBackTableOffset, -IsInternalProcedure
; CHECK-ASM32-NEXT:                                            # -HasControlledStorage, -IsTOCless
; CHECK-ASM32-NEXT:                                            # -IsFloatingPointPresent
; CHECK-ASM32-NEXT:                                            # -IsFloatingPointOperationLogOrAbortEnabled
; CHECK-ASM32-NEXT:    	.byte	0x60                            # -IsInterruptHandler, +IsFunctionNamePresent, +IsAllocaUsed
; CHECK-ASM32-NEXT:                                            # OnConditionDirective = 0, -IsCRSaved, -IsLRSaved
; CHECK-ASM32-NEXT:    	.byte	0x80                            # +IsBackChainStored, -IsFixup, NumOfFPRsSaved = 0
; CHECK-ASM32-NEXT:    	.byte	0x01                            # -HasExtensionTable, -HasVectorInfo, NumOfGPRsSaved = 1
; CHECK-ASM32-NEXT:    	.byte	0x00                            # NumberOfFixedParms = 0
; CHECK-ASM32-NEXT:    	.byte	0x01                            # NumberOfFPParms = 0, +HasParmsOnStack
; CHECK-ASM32-NEXT:    	.vbyte	4, L..varalloca0-.varalloca     # Function size
; CHECK-ASM32-NEXT:    	.vbyte	2, 0x0009                       # Function name len = 9
; CHECK-ASM32-NEXT:    	.byte	"varalloca"                     # Function Name
; CHECK-ASM32-NEXT:    	.byte	0x1f                            # AllocaUsed
; CHECK-ASM32-NEXT:                                            # -- End function
;
; CHECK-ASM64-LABEL: varalloca:
; CHECK-ASM64:       # %bb.0: # %entry
; CHECK-ASM64-NEXT:    std 31, -8(1)
; CHECK-ASM64-NEXT:    stdu 1, -64(1)
; CHECK-ASM64-NEXT:    ld 3, L..C0(2) # @var
; CHECK-ASM64-NEXT:    mr 31, 1
; CHECK-ASM64-NEXT:    addi 4, 31, 64
; CHECK-ASM64-NEXT:    lwz 3, 0(3)
; CHECK-ASM64-NEXT:    addi 3, 3, 15
; CHECK-ASM64-NEXT:    rldicl 3, 3, 60, 4
; CHECK-ASM64-NEXT:    rldicl 3, 3, 4, 31
; CHECK-ASM64-NEXT:    neg 3, 3
; CHECK-ASM64-NEXT:    stdux 4, 1, 3
; CHECK-ASM64-NEXT:    addi 3, 1, 48
; CHECK-ASM64-NEXT:    lwz 3, 0(3)
; CHECK-ASM64-NEXT:    ld 1, 0(1)
; CHECK-ASM64-NEXT:    ld 31, -8(1)
; CHECK-ASM64-NEXT:    blr
; CHECK-ASM64-NEXT:    L..varalloca0:
; CHECK-ASM64-NEXT:    	.vbyte	4, 0x00000000                   # Traceback table begin
; CHECK-ASM64-NEXT:    	.byte	0x00                            # Version = 0
; CHECK-ASM64-NEXT:    	.byte	0x09                            # Language = CPlusPlus
; CHECK-ASM64-NEXT:    	.byte	0x20                            # -IsGlobaLinkage, -IsOutOfLineEpilogOrPrologue
; CHECK-ASM64-NEXT:                                            # +HasTraceBackTableOffset, -IsInternalProcedure
; CHECK-ASM64-NEXT:                                            # -HasControlledStorage, -IsTOCless
; CHECK-ASM64-NEXT:                                            # -IsFloatingPointPresent
; CHECK-ASM64-NEXT:                                            # -IsFloatingPointOperationLogOrAbortEnabled
; CHECK-ASM64-NEXT:    	.byte	0x60                            # -IsInterruptHandler, +IsFunctionNamePresent, +IsAllocaUsed
; CHECK-ASM64-NEXT:                                            # OnConditionDirective = 0, -IsCRSaved, -IsLRSaved
; CHECK-ASM64-NEXT:    	.byte	0x80                            # +IsBackChainStored, -IsFixup, NumOfFPRsSaved = 0
; CHECK-ASM64-NEXT:    	.byte	0x01                            # -HasExtensionTable, -HasVectorInfo, NumOfGPRsSaved = 1
; CHECK-ASM64-NEXT:    	.byte	0x00                            # NumberOfFixedParms = 0
; CHECK-ASM64-NEXT:    	.byte	0x01                            # NumberOfFPParms = 0, +HasParmsOnStack
; CHECK-ASM64-NEXT:    	.vbyte	4, L..varalloca0-.varalloca     # Function size
; CHECK-ASM64-NEXT:    	.vbyte	2, 0x0009                       # Function name len = 9
; CHECK-ASM64-NEXT:    	.byte	"varalloca"                     # Function Name
; CHECK-ASM64-NEXT:    	.byte	0x1f                            # AllocaUsed
; CHECK-ASM64-NEXT:                                            # -- End function
entry:
  %0 = load i32, ptr @var
  %1 = alloca i8, i32 %0
  %2 = load i32, ptr %1
  ret i32 %2
}
