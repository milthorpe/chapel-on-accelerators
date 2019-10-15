; LLVM IR representation of vec_add function after none optimization stage
; ModuleID = 'root'
source_filename = "root"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t = type { i64, %chpl_DefaultRectangularArr_1_int64_t_F__real64_int64_t_object*, i8 }
%chpl_DefaultRectangularArr_1_int64_t_F__real64_int64_t_object = type { %chpl_BaseRectangularArr_1_int64_t_F__real64_object, %chpl_DefaultRectangularDom_1_int64_t_F_object*, [1 x i64], [1 x i64], [1 x i64], [1 x i64], i64, double*, double*, i8, i8, i8, i8*, %range_int64_t_bounded_F }
%chpl_BaseRectangularArr_1_int64_t_F__real64_object = type { %chpl_BaseArrOverRectangularDom_1_int64_t_F_object }
%chpl_BaseArrOverRectangularDom_1_int64_t_F_object = type { %chpl_BaseArr_object }
%chpl_BaseArr_object = type { %chpl_object_object, i64, i8 }
%chpl_object_object = type { i32, i32 }
%chpl_DefaultRectangularDom_1_int64_t_F_object = type { %chpl_BaseRectangularDom_1_int64_t_F_object, %chpl_DefaultDist_object*, [1 x %range_int64_t_bounded_F] }
%chpl_BaseRectangularDom_1_int64_t_F_object = type { %chpl_BaseDom_object }
%chpl_BaseDom_object = type { %chpl_object_object, %LinkedList_BaseArr_chpl, i64, %chpl_LocalSpinlock, i8, i64 }
%LinkedList_BaseArr_chpl = type { %chpl_listNode_BaseArr_chpl_object*, %chpl_listNode_BaseArr_chpl_object*, i64 }
%chpl_listNode_BaseArr_chpl_object = type { %chpl_object_object, %chpl_BaseArr_object*, %chpl_listNode_BaseArr_chpl_object* }
%chpl_LocalSpinlock = type { %AtomicBool }
%AtomicBool = type { i8 }
%chpl_DefaultDist_object = type { %chpl_BaseDist_object }
%chpl_BaseDist_object = type { %chpl_object_object, %LinkedList_BaseDom_chpl, %chpl_LocalSpinlock, i8, i64 }
%LinkedList_BaseDom_chpl = type { %chpl_listNode_BaseDom_chpl_object*, %chpl_listNode_BaseDom_chpl_object*, i64 }
%chpl_listNode_BaseDom_chpl_object = type { %chpl_object_object, %chpl_BaseDom_object*, %chpl_listNode_BaseDom_chpl_object* }
%range_int64_t_bounded_F = type { i64, i64 }
%_domain_DefaultRectangularDom_1_int64_t_F = type { i64, %chpl_DefaultRectangularDom_1_int64_t_F_object*, i8 }
%_ir_chpl_promo1__PLUS_ = type { %chpl_DefaultRectangularDom_1_int64_t_F_object*, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t }

declare dso_local void @_dom3(%_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* nonnull, %_domain_DefaultRectangularDom_1_int64_t_F* nonnull, i64, i32)

declare dso_local void @chpl__unref(%_ir_chpl_promo1__PLUS_* nonnull, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* nonnull, i64, i32)

declare dso_local void @chpl__autoDestroy2(%_domain_DefaultRectangularDom_1_int64_t_F* nonnull, i64, i32)

; Function Attrs: noinline
define weak dso_local void @vec_add_chpl(%_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* nonnull %a_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* nonnull %b_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* nonnull %_retArg_chpl) #0 {
entry:
  %chpl_macro_tmp_2223 = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*
  %0 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2223 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %0)
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %a_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2223, !tbaa !0
  %chpl_macro_tmp_2224 = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*
  %1 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2224 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %1)
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %b_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2224, !tbaa !0
  %chpl_macro_tmp_2225 = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*
  %2 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2225 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %2)
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_retArg_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2225, !tbaa !0
  %ret_chpl = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t
  %3 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_chpl to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %3)
  %_ir_F0_a_chpl = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t
  %4 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F0_a_chpl to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %4)
  %_ir_F1_b_chpl = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t
  %5 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F1_b_chpl to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %5)
  %call_tmp_chpl5 = alloca %_domain_DefaultRectangularDom_1_int64_t_F
  %6 = bitcast %_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %6)
  %ret_tmp_chpl = alloca %_domain_DefaultRectangularDom_1_int64_t_F
  %7 = bitcast %_domain_DefaultRectangularDom_1_int64_t_F* %ret_tmp_chpl to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %7)
  %ret_chpl2 = alloca %chpl_DefaultRectangularDom_1_int64_t_F_object*
  %8 = bitcast %chpl_DefaultRectangularDom_1_int64_t_F_object** %ret_chpl2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %8)
  store %chpl_DefaultRectangularDom_1_int64_t_F_object* null, %chpl_DefaultRectangularDom_1_int64_t_F_object** %ret_chpl2
  %array_unref_ret_tmp_chpl = alloca %_ir_chpl_promo1__PLUS_
  %9 = bitcast %_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* %9)
  %ret_tmp_chpl2 = alloca %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t
  %10 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_tmp_chpl2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %10)
  br label %vec_add_chpl_2blk_body_

vec_add_chpl_2blk_body_:                          ; preds = %entry
  %11 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2223, !tbaa !0
  %12 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %11
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %12, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F0_a_chpl
  %13 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2224, !tbaa !0
  %14 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %13
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %14, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F1_b_chpl
  %15 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2223, !tbaa !0
  call void @_dom3(%_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %15, %_domain_DefaultRectangularDom_1_int64_t_F* %ret_tmp_chpl, i64 2, i32 60)
  %16 = load %_domain_DefaultRectangularDom_1_int64_t_F, %_domain_DefaultRectangularDom_1_int64_t_F* %ret_tmp_chpl
  store %_domain_DefaultRectangularDom_1_int64_t_F %16, %_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5
  %17 = bitcast %_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5 to i8*
  %18 = call {}* @llvm.invariant.start.p0i8(i64 24, i8* %17)
  %19 = getelementptr inbounds %_domain_DefaultRectangularDom_1_int64_t_F, %_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5, i32 0, i32 1
  %20 = load %chpl_DefaultRectangularDom_1_int64_t_F_object*, %chpl_DefaultRectangularDom_1_int64_t_F_object** %19, !tbaa !5
  store %chpl_DefaultRectangularDom_1_int64_t_F_object* %20, %chpl_DefaultRectangularDom_1_int64_t_F_object** %ret_chpl2, !tbaa !13
  call void @chpl__autoDestroy2(%_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5, i64 2, i32 60)
  %21 = getelementptr inbounds %_ir_chpl_promo1__PLUS_, %_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl, i32 0, i32 0
  %22 = load %chpl_DefaultRectangularDom_1_int64_t_F_object*, %chpl_DefaultRectangularDom_1_int64_t_F_object** %ret_chpl2, !tbaa !13
  store %chpl_DefaultRectangularDom_1_int64_t_F_object* %22, %chpl_DefaultRectangularDom_1_int64_t_F_object** %21, !tbaa !14
  %23 = getelementptr inbounds %_ir_chpl_promo1__PLUS_, %_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl, i32 0, i32 1
  %24 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F0_a_chpl
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %24, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %23
  %25 = getelementptr inbounds %_ir_chpl_promo1__PLUS_, %_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl, i32 0, i32 2
  %26 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F1_b_chpl
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %26, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %25
  call void @chpl__unref(%_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_tmp_chpl2, i64 2, i32 60)
  %27 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_tmp_chpl2
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %27, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_chpl
  %28 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_chpl to i8*
  %29 = call {}* @llvm.invariant.start.p0i8(i64 24, i8* %28)
  %30 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t*, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2225, !tbaa !0
  %31 = load %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_chpl
  store %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t %31, %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %30
  %32 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2223 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %32)
  %33 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2224 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %33)
  %34 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t** %chpl_macro_tmp_2225 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %34)
  %35 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_chpl to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %35)
  %36 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F0_a_chpl to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %36)
  %37 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %_ir_F1_b_chpl to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %37)
  %38 = bitcast %_domain_DefaultRectangularDom_1_int64_t_F* %call_tmp_chpl5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %38)
  %39 = bitcast %_domain_DefaultRectangularDom_1_int64_t_F* %ret_tmp_chpl to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %39)
  %40 = bitcast %chpl_DefaultRectangularDom_1_int64_t_F_object** %ret_chpl2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %40)
  %41 = bitcast %_ir_chpl_promo1__PLUS_* %array_unref_ret_tmp_chpl to i8*
  call void @llvm.lifetime.end.p0i8(i64 56, i8* %41)
  %42 = bitcast %_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t* %ret_tmp_chpl2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %42)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare {}* @llvm.invariant.start.p0i8(i64, i8* nocapture) #1

attributes #0 = { noinline }
attributes #1 = { argmemonly nounwind }

!0 = !{!1, !1, i64 0}
!1 = !{!"_ref__array_DefaultRectangularArr_1_int64_t_F__real64_int64_t", !2, i64 0}
!2 = !{!"C void ptr", !3, i64 0}
!3 = !{!"all unions", !4, i64 0}
!4 = !{!"Chapel types"}
!5 = !{!6, !8, i64 8}
!6 = !{!"_domain_DefaultRectangularDom_1_int64_t_F", !7, i64 0, !8, i64 8, !12, i64 16}
!7 = !{!"int64_t", !3, i64 0}
!8 = !{!"DefaultRectangularDom_1_int64_t_F", !9, i64 0}
!9 = !{!"BaseRectangularDom_1_int64_t_F", !10, i64 0}
!10 = !{!"BaseDom", !11, i64 0}
!11 = !{!"object", !2, i64 0}
!12 = !{!"chpl_bool", !3, i64 0}
!13 = !{!8, !8, i64 0}
!14 = !{!15, !8, i64 0}
!15 = !{!"_ir_chpl_promo1__PLUS_", !8, i64 0, !16, i64 8, !16, i64 32}
!16 = !{!"_array_DefaultRectangularArr_1_int64_t_F__real64_int64_t", !7, i64 0, !17, i64 8, !12, i64 16}
!17 = !{!"DefaultRectangularArr_1_int64_t_F__real64_int64_t", !18, i64 0}
!18 = !{!"BaseRectangularArr_1_int64_t_F__real64", !19, i64 0}
!19 = !{!"BaseArrOverRectangularDom_1_int64_t_F", !20, i64 0}
!20 = !{!"BaseArr", !11, i64 0}
