//
//  HTML.Document.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 22/07/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// A complete HTML document with head and body sections.
    ///
    /// `HTML.Document` represents a full HTML page with proper structure including
    /// doctype, html, head, and body elements. Use this type when you need
    /// to render a complete HTML document rather than just a fragment.
    ///
    /// The `Document` type is generic over both `Body` and `Head` view types,
    /// allowing it to work with different output types. The `HTML.DocumentProtocol`
    /// conformance is provided conditionally for `UInt8` output.
    ///
    /// Example:
    /// ```swift
    /// let page = HTML.Document {
    ///     div {
    ///         h1 { "Welcome" }
    ///         p { "Hello, World!" }
    ///     }
    /// } head: {
    ///     title { "My Page" }
    ///     meta().charset("utf-8")
    /// }
    /// ```
    public struct Document<Body, Head> {
        public let head: Head
        public let body: Body
    }
}

// MARK: - Initializers for UInt8 Output

extension HTML.Document where Body: HTML.View<UInt8>, Head: HTML.View<UInt8> {
    /// Creates a new HTML document.
    ///
    /// - Parameters:
    ///   - body: A builder closure that returns the body content.
    ///   - head: A builder closure that returns the head content. Defaults to empty.
    public init(
        @HTML.Builder body: () -> Body,
        @HTML.Builder head: () -> Head = { Empty() }
    ) {
        self.body = body()
        self.head = head()
    }

    /// Creates a new HTML document with head specified first.
    ///
    /// This overload allows specifying head before body for cases where
    /// that ordering reads more naturally.
    ///
    /// - Parameters:
    ///   - head: A builder closure that returns the head content. Defaults to empty.
    ///   - body: A builder closure that returns the body content.
    @_disfavoredOverload
    public init(
        @HTML.Builder head: () -> Head = { Empty() },
        @HTML.Builder body: () -> Body
    ) {
        self.body = body()
        self.head = head()
    }
}

// MARK: - HTML.DocumentProtocol Conformance (UInt8 Output)

extension HTML.Document: HTML.DocumentProtocol where Body: HTML.View<UInt8>, Head: HTML.View<UInt8> {}

extension HTML.Document: Sendable where Body: Sendable, Head: Sendable {}
