# Audit: swift-numeric-primitives

## Legacy — Consolidated 2026-04-08

### From: swift-institute/Research/platform-compliance-audit.md (2026-03-19)

**Skill**: platform — [PLAT-ARCH-001-010], [PATTERN-001], [PATTERN-004a], [PATTERN-005]

| # | Severity | Rule | Location | Finding | Status |
|---|----------|------|----------|---------|--------|
| H-46 | HIGH | [PLAT-ARCH-008] | Numeric.Math.swift:110,210,218,308 | `canImport(Darwin||Glibc||Musl)` for lgamma; `os(iOS|macOS|...)` for Float16. | OPEN — lgamma genuinely unavailable on Windows; Float16 needs `#if os(...)` as only mechanism |
| H-47 | HIGH | [PLAT-ARCH-008] | Numeric.Math.Accessor.swift:152,300,313,449 | Same patterns as Math.swift. | OPEN |
| H-48 | HIGH | [PLAT-ARCH-008] | Numeric.Transcendental+Conformances.swift:75 | `os(iOS|macOS|...)` for Float16 conformance. | OPEN — Swift lacks `#if hasFeature(Float16)` |
| M-1 | MEDIUM | [PATTERN-001] | _Shims/include/shims.h:114,141,262,275,417 | Single shared C header with `#if defined(_WIN32)` conditionals for hypotf and lgamma. Fix: Split into per-platform shim files. | OPEN |

---

### From: swift-institute/Research/audits/implementation-naming-2026-03-20/swift-data-structures-batch.md (2026-03-20)

**Implementation + naming audit**

CLEAN - no findings
