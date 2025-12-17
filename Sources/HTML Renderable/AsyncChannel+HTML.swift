//
//  AsyncChannel+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Rendering
public import WHATWG_HTML_Shared
public import RenderingAsync

extension AsyncChannel<ArraySlice<UInt8>> {
    /// Stream HTML with true progressive rendering and backpressure.
    ///
    /// This is the canonical way to stream HTML when you need bounded memory.
    /// The producer suspends when the consumer is slow, ensuring memory
    /// usage is bounded to O(chunkSize) throughout the entire process.
    ///
    /// This is an HTML-specific convenience that wraps the generic
    /// `AsyncChannel(rendering:chunkSize:)` from `RenderingAsync`,
    /// adding `@WHATWG_HTML.Builder` syntax and `WHATWG_HTML.Context` configuration.
    ///
    /// ## When to Use
    ///
    /// Use `AsyncChannel` when:
    /// - Streaming large documents to HTTP clients
    /// - Memory usage must be bounded regardless of document size
    /// - You want true backpressure (producer waits for slow consumers)
    ///
    /// Use `[UInt8](html)` instead when:
    /// - You need the complete document (e.g., PDF generation)
    /// - The document is small
    /// - Simplicity is preferred over streaming
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// for await chunk in AsyncChannel { myView } {
    ///     await response.write(chunk)
    /// }
    /// ```
    ///
    /// ## Memory Characteristics
    ///
    /// | Pattern | Memory |
    /// |---------|--------|
    /// | `[UInt8](html)` | O(doc size) |
    /// | `AsyncChannel { html }` | **O(chunkSize)** |
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - view: The HTML content to stream.
    ///
    /// - SeeAlso: `AsyncChannel(rendering:chunkSize:)` in `RenderingAsync` for
    ///   the generic implementation and detailed explanation of the concurrent
    ///   producer/consumer pattern.
    public convenience init<View: WHATWG_HTML.View & AsyncRenderable & Sendable>(
        chunkSize: Int = 4096,
        configuration: WHATWG_HTML.Context.Configuration? = nil,
        @WHATWG_HTML.Builder _ view: () -> View
    ) {
        self.init()
        let view = view()
        let config = configuration ?? .current
        let channel = self

        // Task.detached is required here for concurrent producer/consumer.
        // See AsyncChannel(rendering:chunkSize:) in RenderingAsync for detailed explanation.
        Task.detached {
            let sink = Rendering.Async.Sink.Buffered(channel: channel, chunkSize: chunkSize)
            var context = WHATWG_HTML.Context(config)
            await View._renderAsync(view, into: sink, context: &context)
            await sink.finish()
        }
    }
}

extension AsyncChannel<ArraySlice<UInt8>> {
    /// Stream an HTML document with true progressive rendering and backpressure.
    ///
    /// This is an HTML-specific convenience that wraps the generic
    /// `AsyncChannel(rendering:chunkSize:)` from `RenderingAsync`,
    /// adding `@WHATWG_HTML.Builder` syntax and `WHATWG_HTML.Context` configuration.
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// let document = WHATWG_HTML.Document { div { "Hello" } }
    /// for await chunk in AsyncChannel { document } {
    ///     await response.write(chunk)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - document: The HTML document to stream.
    ///
    /// - SeeAlso: `AsyncChannel(rendering:chunkSize:)` in `RenderingAsync` for
    ///   the generic implementation and detailed explanation of the concurrent
    ///   producer/consumer pattern.
    public convenience init<Document: WHATWG_HTML.DocumentProtocol & AsyncRenderable & Sendable>(
        chunkSize: Int = 4096,
        configuration: WHATWG_HTML.Context.Configuration? = nil,
        @WHATWG_HTML.Builder _ document: () -> Document
    ) {
        self.init()
        let document = document()
        let config = configuration ?? .current
        let channel = self

        // Task.detached is required here for concurrent producer/consumer.
        // See AsyncChannel(rendering:chunkSize:) in RenderingAsync for detailed explanation.
        Task.detached {
            let sink = Rendering.Async.Sink.Buffered(channel: channel, chunkSize: chunkSize)
            var context = WHATWG_HTML.Context(config)
            await Document._renderAsync(document, into: sink, context: &context)
            await sink.finish()
        }
    }
}
