//
//  HTML.RenderOutput.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 18/12/2025.
//

extension HTML {
    /// A protocol for types that can be used as rendering output targets.
    ///
    /// `HTML.RenderOutput` defines the abstraction for different rendering targets.
    /// Each output type is associated with a specific context type that carries
    /// state during rendering.
    ///
    /// ## Static Dispatch
    ///
    /// All rendering using `HTML.RenderOutput` uses pure static dispatch. The compiler
    /// monomorphizes the generic `_render` methods for each concrete output type,
    /// enabling full inlining and optimization.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Byte rendering (standard HTML)
    /// let bytes = [UInt8](myView)
    /// ```
    public protocol RenderOutput {
        /// The context type used during rendering for this output type.
        associatedtype Context
    }
}

// MARK: - UInt8 Conformance

/// `UInt8` is the standard output type for rendering HTML to bytes.
///
/// When using `UInt8` as the output type, HTML views render to raw bytes
/// that can be directly written to files, network streams, or converted to strings.
///
/// ## Example
///
/// ```swift
/// let bytes = [UInt8](myView)
/// let html = String(decoding: bytes, as: UTF8.self)
/// ```
extension UInt8: HTML.RenderOutput {
    public typealias Context = HTML.Context
}
