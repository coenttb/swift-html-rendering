//
//  WHATWG_HTML.Document.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 22/07/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// A complete HTML document with head and body sections.
    ///
    /// `WHATWG_HTML.Document` represents a full HTML page with proper structure including
    /// doctype, html, head, and body elements. Use this type when you need
    /// to render a complete HTML document rather than just a fragment.
    ///
    /// Example:
    /// ```swift
    /// let page = WHATWG_HTML.Document {
    ///     div {
    ///         h1 { "Welcome" }
    ///         p { "Hello, World!" }
    ///     }
    /// } head: {
    ///     title { "My Page" }
    ///     meta().charset("utf-8")
    /// }
    /// ```
    public struct Document<Body: WHATWG_HTML.View, Head: WHATWG_HTML.View>: WHATWG_HTML.DocumentProtocol {
        public let head: Head
        public let body: Body

        /// Creates a new HTML document.
        ///
        /// - Parameters:
        ///   - body: A builder closure that returns the body content.
        ///   - head: A builder closure that returns the head content. Defaults to empty.
        public init(
            @WHATWG_HTML.Builder body: () -> Body,
            @WHATWG_HTML.Builder head: () -> Head = { Empty() }
        ) {
            self.body = body()
            self.head = head()
        }
    }
}

extension WHATWG_HTML.Document {
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
        @WHATWG_HTML.Builder head: () -> Head = { Empty() },
        @WHATWG_HTML.Builder body: () -> Body
    ) {
        self.body = body()
        self.head = head()
    }
}

extension WHATWG_HTML.Document: Sendable where Body: Sendable, Head: Sendable {}
