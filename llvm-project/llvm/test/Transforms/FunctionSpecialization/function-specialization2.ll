; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes="ipsccp<func-spec>,deadargelim" -force-function-specialization -S < %s | FileCheck %s
; RUN: opt -passes="ipsccp<func-spec>,deadargelim" -func-specialization-max-iters=1 -force-function-specialization -S < %s | FileCheck %s
; RUN: opt -passes="ipsccp<func-spec>,deadargelim" -func-specialization-max-iters=0 -force-function-specialization -S < %s | FileCheck %s --check-prefix=DISABLED
; RUN: opt -passes="ipsccp<func-spec>,deadargelim" -func-specialization-avg-iters-cost=1 -force-function-specialization -S < %s | FileCheck %s

; DISABLED-NOT: @func.1(
; DISABLED-NOT: @func.2(

define internal i32 @func(ptr %0, i32 %1, ptr nocapture %2) {
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = icmp slt i32 %5, 1
  br i1 %6, label %14, label %7

7:                                                ; preds = %3
  %8 = load i32, ptr %4, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  call void %2(ptr %10)
  %11 = load i32, ptr %4, align 4
  %12 = add nsw i32 %11, -1
  %13 = call i32 @func(ptr %0, i32 %12, ptr %2)
  br label %14

14:                                               ; preds = %3, %7
  ret i32 0
}

define internal void @increment(ptr nocapture %0) {
  %2 = load i32, ptr %0, align 4
  %3 = add nsw i32 %2, 1
  store i32 %3, ptr %0, align 4
  ret void
}

define internal void @decrement(ptr nocapture %0) {
  %2 = load i32, ptr %0, align 4
  %3 = add nsw i32 %2, -1
  store i32 %3, ptr %0, align 4
  ret void
}

define i32 @main(ptr %0, i32 %1) {
; CHECK:    call void @func.2(ptr [[TMP0:%.*]], i32 [[TMP1:%.*]])
  %3 = call i32 @func(ptr %0, i32 %1, ptr nonnull @increment)
; CHECK:    call void @func.1(ptr [[TMP0]], i32 0)
  %4 = call i32 @func(ptr %0, i32 %3, ptr nonnull @decrement)
; CHECK:    ret i32 0
  ret i32 %4
}

; CHECK: @func.1(
; CHECK:    [[TMP3:%.*]] = alloca i32, align 4
; CHECK:    store i32 [[TMP1:%.*]], ptr [[TMP3]], align 4
; CHECK:    [[TMP4:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP5:%.*]] = icmp slt i32 [[TMP4]], 1
; CHECK:    br i1 [[TMP5]], label [[TMP13:%.*]], label [[TMP6:%.*]]
; CHECK:       6:
; CHECK:    [[TMP7:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP8:%.*]] = sext i32 [[TMP7]] to i64
; CHECK:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP0:%.*]], i64 [[TMP8]]
; CHECK:    call void @decrement(ptr [[TMP9]])
; CHECK:    [[TMP10:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP11:%.*]] = add nsw i32 [[TMP10]], -1
; CHECK:    call void @func.1(ptr [[TMP0]], i32 [[TMP11]])
; CHECK:    br label [[TMP12:%.*]]
; CHECK:       12:
; CHECK:    ret void
;
;
; CHECK: @func.2(
; CHECK:    [[TMP3:%.*]] = alloca i32, align 4
; CHECK:    store i32 [[TMP1:%.*]], ptr [[TMP3]], align 4
; CHECK:    [[TMP4:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP5:%.*]] = icmp slt i32 [[TMP4]], 1
; CHECK:    br i1 [[TMP5]], label [[TMP13:%.*]], label [[TMP6:%.*]]
; CHECK:       6:
; CHECK:    [[TMP7:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP8:%.*]] = sext i32 [[TMP7]] to i64
; CHECK:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP0:%.*]], i64 [[TMP8]]
; CHECK:    call void @increment(ptr [[TMP9]])
; CHECK:    [[TMP10:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK:    [[TMP11:%.*]] = add nsw i32 [[TMP10]], -1
; CHECK:    call void @func.2(ptr [[TMP0]], i32 [[TMP11]])
; CHECK:    br label [[TMP12:%.*]]
; CHECK:       12:
; CHECK:    ret void