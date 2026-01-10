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

// Float16 is only available on arm64 macOS, not on x86_64.
#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: Numeric.Real {}

#endif
