; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: opt -S -mtriple=amdgcn-- -structurizecfg -si-annotate-control-flow %s | FileCheck -check-prefix=IR %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck %s

define void @loop_on_argument(i1 %arg) {
; IR-LABEL: @loop_on_argument(
; IR-NEXT:  entry:
; IR-NEXT:    br label [[LOOP:%.*]]
; IR:       loop:
; IR-NEXT:    [[PHI_BROKEN:%.*]] = phi i64 [ [[TMP0:%.*]], [[LOOP]] ], [ 0, [[ENTRY:%.*]] ]
; IR-NEXT:    [[TMP0]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[ARG:%.*]], i64 [[PHI_BROKEN]])
; IR-NEXT:    store volatile i32 0, ptr addrspace(1) undef, align 4
; IR-NEXT:    [[TMP1:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP0]])
; IR-NEXT:    br i1 [[TMP1]], label [[EXIT:%.*]], label [[LOOP]]
; IR:       exit:
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP0]])
; IR-NEXT:    ret void
;
; CHECK-LABEL: loop_on_argument:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; CHECK-NEXT:    s_mov_b64 s[4:5], 0
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:  .LBB0_1: ; %loop
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    s_and_b64 s[6:7], exec, vcc
; CHECK-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; CHECK-NEXT:    global_store_dword v[0:1], v0, off
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_andn2_b64 exec, exec, s[4:5]
; CHECK-NEXT:    s_cbranch_execnz .LBB0_1
; CHECK-NEXT:  ; %bb.2: ; %exit
; CHECK-NEXT:    s_or_b64 exec, exec, s[4:5]
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  br label %loop

loop:
  store volatile i32 0, ptr addrspace(1) undef
  br i1 %arg, label %exit, label %loop

exit:
  ret void
}