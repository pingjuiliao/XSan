include_directories(..)

set(XSAN_RTL_SOURCES
  xsan.cpp
  )

set(XSAN_RTL_HEADERS
  xsan.h
  )
set(XSAN_COMMON_CFLAGS ${SANITIZER_COMMON_CFLAGS})


append_rtti_flag(OFF XSAN_COMMON_CFLAGS)
add_compiler_rt_component(xsan)

foreach(arch ${XSAN_SUPPORTED_ARCH})
  set(XSAN_CFLAGS ${XSAN_COMMON_CFLAGS})
  append_list_if(COMPILER_RT_HAS_FPIE_FLAG -fPIE XSAN_CFLAGS)
  add_compiler_rt_runtime(clang_rt.xsan
    STATIC
    ARCHS ${arch}
    SOURCES ${XSAN_RTL_SOURCES}
    $<TARGET_OBJECTS:RTInterception.${arch}>
    $<TARGET_OBJECTS:RTSanitizerCommon.${arch}>
    $<TARGET_OBJECTS:RTSanitizerCommonLibc.${arch}>
    ADDITIONAL_HEADERS ${XSAN_RTL_HEADERS}
    CFLAGS ${XSAN_CFLAGS}
    PARENT_TARGET xsan)
  add_sanitizer_rt_symbols(clang_rt.xsan
    ARCHS ${arch}
     )
  add_dependencies(xsan
    clang_rt.xsan-${arch}-symbols)
endforeach()
