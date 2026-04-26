//===--- shims.h - Numeric primitives libm shims ----------------*- C -*-===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
//===----------------------------------------------------------------------===//

#ifndef NUMERIC_PRIMITIVES_SHIMS_H
#define NUMERIC_PRIMITIVES_SHIMS_H

#ifdef __cplusplus
extern "C" {
#endif

#define SHIM_INLINE static inline __attribute__((__always_inline__))

// ===----------------------------------------------------------------------===//
// MARK: - Float shims
// ===----------------------------------------------------------------------===//

SHIM_INLINE float shim_expf(float x) {
    return __builtin_expf(x);
}

SHIM_INLINE float shim_expm1f(float x) {
    return __builtin_expm1f(x);
}

SHIM_INLINE float shim_logf(float x) {
    return __builtin_logf(x);
}

SHIM_INLINE float shim_log1pf(float x) {
    return __builtin_log1pf(x);
}

SHIM_INLINE float shim_log2f(float x) {
    return __builtin_log2f(x);
}

SHIM_INLINE float shim_log10f(float x) {
    return __builtin_log10f(x);
}

SHIM_INLINE float shim_sinf(float x) {
    return __builtin_sinf(x);
}

SHIM_INLINE float shim_cosf(float x) {
    return __builtin_cosf(x);
}

SHIM_INLINE float shim_tanf(float x) {
    return __builtin_tanf(x);
}

SHIM_INLINE float shim_asinf(float x) {
    return __builtin_asinf(x);
}

SHIM_INLINE float shim_acosf(float x) {
    return __builtin_acosf(x);
}

SHIM_INLINE float shim_atanf(float x) {
    return __builtin_atanf(x);
}

SHIM_INLINE float shim_atan2f(float y, float x) {
    return __builtin_atan2f(y, x);
}

SHIM_INLINE float shim_sinhf(float x) {
    return __builtin_sinhf(x);
}

SHIM_INLINE float shim_coshf(float x) {
    return __builtin_coshf(x);
}

SHIM_INLINE float shim_tanhf(float x) {
    return __builtin_tanhf(x);
}

SHIM_INLINE float shim_asinhf(float x) {
    return __builtin_asinhf(x);
}

SHIM_INLINE float shim_acoshf(float x) {
    return __builtin_acoshf(x);
}

SHIM_INLINE float shim_atanhf(float x) {
    return __builtin_atanhf(x);
}

SHIM_INLINE float shim_powf(float x, float y) {
    return __builtin_powf(x, y);
}

SHIM_INLINE float shim_sqrtf(float x) {
    return __builtin_sqrtf(x);
}

SHIM_INLINE float shim_cbrtf(float x) {
    return __builtin_cbrtf(x);
}

#if defined(_WIN32)
SHIM_INLINE float shim_hypotf(float x, float y) {
    extern float _hypotf(float, float);
    return _hypotf(x, y);
}
#else
SHIM_INLINE float shim_hypotf(float x, float y) {
    return __builtin_hypotf(x, y);
}
#endif

SHIM_INLINE float shim_exp2f(float x) {
    return __builtin_exp2f(x);
}

SHIM_INLINE float shim_erff(float x) {
    return __builtin_erff(x);
}

SHIM_INLINE float shim_erfcf(float x) {
    return __builtin_erfcf(x);
}

SHIM_INLINE float shim_tgammaf(float x) {
    return __builtin_tgammaf(x);
}

// shim_lgammaf removed 2026-04-26 — lgamma relocated to L3 swift-numerics
// per /platform [PLAT-ARCH-008c]. Backed by L2 swift-iso-9899's libm
// bindings (`ISO_9899.Math.lgamma`).

// ===----------------------------------------------------------------------===//
// MARK: - Double shims
// ===----------------------------------------------------------------------===//

SHIM_INLINE double shim_exp(double x) {
    return __builtin_exp(x);
}

SHIM_INLINE double shim_expm1(double x) {
    return __builtin_expm1(x);
}

SHIM_INLINE double shim_log(double x) {
    return __builtin_log(x);
}

SHIM_INLINE double shim_log1p(double x) {
    return __builtin_log1p(x);
}

SHIM_INLINE double shim_log2(double x) {
    return __builtin_log2(x);
}

SHIM_INLINE double shim_log10(double x) {
    return __builtin_log10(x);
}

SHIM_INLINE double shim_sin(double x) {
    return __builtin_sin(x);
}

SHIM_INLINE double shim_cos(double x) {
    return __builtin_cos(x);
}

SHIM_INLINE double shim_tan(double x) {
    return __builtin_tan(x);
}

SHIM_INLINE double shim_asin(double x) {
    return __builtin_asin(x);
}

SHIM_INLINE double shim_acos(double x) {
    return __builtin_acos(x);
}

SHIM_INLINE double shim_atan(double x) {
    return __builtin_atan(x);
}

SHIM_INLINE double shim_atan2(double y, double x) {
    return __builtin_atan2(y, x);
}

SHIM_INLINE double shim_sinh(double x) {
    return __builtin_sinh(x);
}

SHIM_INLINE double shim_cosh(double x) {
    return __builtin_cosh(x);
}

SHIM_INLINE double shim_tanh(double x) {
    return __builtin_tanh(x);
}

SHIM_INLINE double shim_asinh(double x) {
    return __builtin_asinh(x);
}

SHIM_INLINE double shim_acosh(double x) {
    return __builtin_acosh(x);
}

SHIM_INLINE double shim_atanh(double x) {
    return __builtin_atanh(x);
}

SHIM_INLINE double shim_pow(double x, double y) {
    return __builtin_pow(x, y);
}

SHIM_INLINE double shim_sqrt(double x) {
    return __builtin_sqrt(x);
}

SHIM_INLINE double shim_cbrt(double x) {
    return __builtin_cbrt(x);
}

SHIM_INLINE double shim_hypot(double x, double y) {
    return __builtin_hypot(x, y);
}

SHIM_INLINE double shim_exp2(double x) {
    return __builtin_exp2(x);
}

SHIM_INLINE double shim_erf(double x) {
    return __builtin_erf(x);
}

SHIM_INLINE double shim_erfc(double x) {
    return __builtin_erfc(x);
}

SHIM_INLINE double shim_tgamma(double x) {
    return __builtin_tgamma(x);
}

// shim_lgamma removed 2026-04-26 — lgamma relocated to L3 swift-numerics
// per /platform [PLAT-ARCH-008c]. Backed by L2 swift-iso-9899's libm
// bindings (`ISO_9899.Math.lgamma`).

// ===----------------------------------------------------------------------===//
// MARK: - Float80 shims (x86 only, non-Windows)
// ===----------------------------------------------------------------------===//

#if !defined(_WIN32) && (defined(__i386__) || defined(__x86_64__))

SHIM_INLINE long double shim_expl(long double x) {
    return __builtin_expl(x);
}

SHIM_INLINE long double shim_expm1l(long double x) {
    return __builtin_expm1l(x);
}

SHIM_INLINE long double shim_logl(long double x) {
    return __builtin_logl(x);
}

SHIM_INLINE long double shim_log1pl(long double x) {
    return __builtin_log1pl(x);
}

SHIM_INLINE long double shim_log2l(long double x) {
    return __builtin_log2l(x);
}

SHIM_INLINE long double shim_log10l(long double x) {
    return __builtin_log10l(x);
}

SHIM_INLINE long double shim_sinl(long double x) {
    return __builtin_sinl(x);
}

SHIM_INLINE long double shim_cosl(long double x) {
    return __builtin_cosl(x);
}

SHIM_INLINE long double shim_tanl(long double x) {
    return __builtin_tanl(x);
}

SHIM_INLINE long double shim_asinl(long double x) {
    return __builtin_asinl(x);
}

SHIM_INLINE long double shim_acosl(long double x) {
    return __builtin_acosl(x);
}

SHIM_INLINE long double shim_atanl(long double x) {
    return __builtin_atanl(x);
}

SHIM_INLINE long double shim_atan2l(long double y, long double x) {
    return __builtin_atan2l(y, x);
}

SHIM_INLINE long double shim_sinhl(long double x) {
    return __builtin_sinhl(x);
}

SHIM_INLINE long double shim_coshl(long double x) {
    return __builtin_coshl(x);
}

SHIM_INLINE long double shim_tanhl(long double x) {
    return __builtin_tanhl(x);
}

SHIM_INLINE long double shim_asinhl(long double x) {
    return __builtin_asinhl(x);
}

SHIM_INLINE long double shim_acoshl(long double x) {
    return __builtin_acoshl(x);
}

SHIM_INLINE long double shim_atanhl(long double x) {
    return __builtin_atanhl(x);
}

SHIM_INLINE long double shim_powl(long double x, long double y) {
    return __builtin_powl(x, y);
}

SHIM_INLINE long double shim_sqrtl(long double x) {
    return __builtin_sqrtl(x);
}

SHIM_INLINE long double shim_cbrtl(long double x) {
    return __builtin_cbrtl(x);
}

SHIM_INLINE long double shim_hypotl(long double x, long double y) {
    return __builtin_hypotl(x, y);
}

SHIM_INLINE long double shim_exp2l(long double x) {
    return __builtin_exp2l(x);
}

SHIM_INLINE long double shim_erfl(long double x) {
    return __builtin_erfl(x);
}

SHIM_INLINE long double shim_erfcl(long double x) {
    return __builtin_erfcl(x);
}

SHIM_INLINE long double shim_tgammal(long double x) {
    return __builtin_tgammal(x);
}

#endif // Float80

// ===----------------------------------------------------------------------===//
// MARK: - Relaxed arithmetic (allows reassociation and FMA formation)
// ===----------------------------------------------------------------------===//

#define SHIM_RELAX_FP _Pragma("clang fp reassociate(on) contract(fast)")

/// Float addition with reassociation and FMA formation permitted.
SHIM_INLINE float shim_relaxed_addf(float a, float b) {
    SHIM_RELAX_FP
    return a + b;
}

/// Float multiplication with reassociation and FMA formation permitted.
SHIM_INLINE float shim_relaxed_mulf(float a, float b) {
    SHIM_RELAX_FP
    return a * b;
}

/// Double addition with reassociation and FMA formation permitted.
SHIM_INLINE double shim_relaxed_add(double a, double b) {
    SHIM_RELAX_FP
    return a + b;
}

/// Double multiplication with reassociation and FMA formation permitted.
SHIM_INLINE double shim_relaxed_mul(double a, double b) {
    SHIM_RELAX_FP
    return a * b;
}

#if !defined(_WIN32) && (defined(__i386__) || defined(__x86_64__))

/// Float80 addition with reassociation and FMA formation permitted.
SHIM_INLINE long double shim_relaxed_addl(long double a, long double b) {
    SHIM_RELAX_FP
    return a + b;
}

/// Float80 multiplication with reassociation and FMA formation permitted.
SHIM_INLINE long double shim_relaxed_mull(long double a, long double b) {
    SHIM_RELAX_FP
    return a * b;
}

#endif // Float80 relaxed

#undef SHIM_RELAX_FP

#undef SHIM_INLINE

#ifdef __cplusplus
}
#endif

#endif // NUMERIC_PRIMITIVES_SHIMS_H
