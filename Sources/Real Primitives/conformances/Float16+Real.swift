// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Float16 is available on arm64 Apple platforms, iOS, tvOS, watchOS, and visionOS.
#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))

extension Float16: Numeric.Real {}

#endif
