//
//  File.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from rendered WHATWG_HTML.
    ///
    /// This is the canonical way to render HTML to bytes when you need the
    /// complete document. Works with any `RangeReplaceableCollection<UInt8>`.
    ///
    /// ## When to Use
    ///
    /// Use `[UInt8](html)` when:
    /// - You need the complete document (e.g., PDF generation)
    /// - The document is small to medium sized
    /// - Simplicity is preferred over streaming
    ///
    /// Use `AsyncChannel { html }` instead when:
    /// - Streaming large documents to HTTP clients
    /// - Memory usage must be bounded regardless of document size
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// let bytes = [UInt8](myView)
    /// ```
    ///
    /// ## Memory Characteristics
    ///
    /// | Pattern | Memory |
    /// |---------|--------|
    /// | `[UInt8](html)` | O(doc size) |
    /// | `AsyncChannel { html }` | O(chunkSize) |
    ///
    /// - Parameters:
    ///   - view: The HTML content to render to bytes
    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
    @inlinable
    public init<View: WHATWG_HTML.View>(
        _ view: View,
        configuration: WHATWG_HTML.Context.Configuration? = nil
    ) {
        var buffer = Self()
        var context = WHATWG_HTML.Context(configuration ?? .current)
        View._render(view, into: &buffer, context: &context)
        self = buffer
    }
}
//
// extension RangeReplaceableCollection<UInt8> {
//    /// Creates a byte collection from rendered WHATWG_HTML.
//    ///
//    /// Convenience overload that accepts HTML as the first unlabeled parameter.
//    ///
//    /// - Parameters:
//    ///   - html: The HTML content to render to bytes
//    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
//    @inlinable
//    public init(
//        _ html: some WHATWG_HTML.View,
//        configuration: WHATWG_HTML.Context.Configuration? = nil
//    ) {
//        self.init(html: WHATWG_HTML.View, configuration: configuration)
//    }
// }

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render HTML to a byte collection.
    ///
    /// This yields to the scheduler during rendering to avoid blocking,
    /// making it suitable for use in async contexts where responsiveness matters.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let html = div { "Hello" }
    /// let bytes: [UInt8] = await .init(html: html)
    /// ```
    ///
    /// - Parameters:
    ///   - html: The HTML content to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<View: WHATWG_HTML.View>(
        _ view: View,
        configuration: WHATWG_HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var buffer = Self()
        var context = WHATWG_HTML.Context(configuration ?? .current)
        View._render(view, into: &buffer, context: &context)
        self = buffer
    }
}

// MARK: - Document Rendering

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from a rendered HTML document.
    ///
    /// - Parameters:
    ///   - document: The HTML document to render.
    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
    @inlinable
    public init<Document: WHATWG_HTML.DocumentProtocol>(
        _ document: Document,
        configuration: WHATWG_HTML.Context.Configuration? = nil
    ) {
        var buffer = Self()
        var context = WHATWG_HTML.Context(configuration ?? .current)
        Document._render(document, into: &buffer, context: &context)
        self = buffer
    }
}

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render an HTML document to a byte collection.
    ///
    /// - Parameters:
    ///   - document: The HTML document to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<Document: WHATWG_HTML.DocumentProtocol>(
        _ document: Document,
        configuration: WHATWG_HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var buffer = Self()
        var context = WHATWG_HTML.Context(configuration ?? .current)
        Document._render(document, into: &buffer, context: &context)
        self = buffer
    }
}
