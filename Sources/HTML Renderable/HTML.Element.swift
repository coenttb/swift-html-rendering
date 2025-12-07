//
//  HTML.Element.swift
//
//
//  Created by Point-Free, Inc
//

import INCITS_4_1986
import OrderedCollections
import Renderable
public import WHATWG_HTML_Shared



extension HTML {
    /// Represents an HTML element with a tag, attributes, and optional content.
    ///
    /// `HTML.Element` is a fundamental building block in the PointFreeHTML library,
    /// representing a standard HTML element with a tag name, attributes, and optional
    /// child content. This type handles the rendering of both opening and closing tags,
    /// attribute formatting, and proper indentation based on block vs. inline elements.
    ///
    /// The `Tag` parameter must conform to `WHATWG_HTML.Element`, providing compile-time
    /// type information about the element for type-safe rendering and PDF conversion.
    ///
    /// Example:
    /// ```swift
    /// let element = HTML.Element<WHATWG_HTML.Grouping.Div, _> {
    ///     p { "Hello, world!" }
    /// }
    /// ```
    ///
    /// This type is typically not used directly by library consumers, who would
    /// instead use the more convenient tag functions like `div`, `span`, `p`, etc.
    public struct Element<Tag: WHATWG_HTML.Element.`Protocol`, Content: HTML.View>: HTML.View {
        /// The optional content contained within this element.
        @HTML.Builder public let content: Content?

        /// Creates a new HTML element with the specified content.
        ///
        /// - Parameter content: A closure that returns the content of this element.
        ///                      If no content is provided, the element will be empty.
        public init(
            @HTML.Builder content: () -> Content? = { Never?.none }
        ) {
            self.content = content()
        }

        /// Creates a new HTML element with an explicit Tag type.
        ///
        /// This initializer allows specifying the Tag type parameter explicitly,
        /// which is useful when creating elements from typed marker types.
        ///
        /// - Parameters:
        ///   - tagType: The type to use as the Tag parameter.
        ///   - content: A closure that returns the content of this element.
        public init(
            for tagType: Tag.Type,
            @HTML.Builder content: () -> Content? = { Never?.none }
        ) {
            self.content = content()
        }

        /// Renders this HTML element into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            let isPrettyPrinting = !context.configuration.newline.isEmpty
            let info = ElementRenderingInfo.forTag(Tag.self, isPrettyPrinting: isPrettyPrinting)

            ElementRendering.renderOpenTag(info: info, context: &context, into: &buffer)

            if let content = html.content {
                let saved = ElementRendering.prepareContentContext(info: info, context: &context)
                defer { ElementRendering.restoreContext(saved, context: &context) }
                Content._render(content, into: &buffer, context: &context)
            }

            ElementRendering.renderCloseTag(info: info, context: &context, into: &buffer)
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never {
            fatalError()
        }
    }
}

extension HTML.Element: Sendable where Content: Sendable {}

// MARK: - Async Rendering

extension HTML.Element: AsyncRenderable where Content: AsyncRenderable {
    /// Async renders this HTML element with backpressure support.
    ///
    /// This implementation mirrors the sync `_render` but uses async writes
    /// to the stream, allowing suspension at strategic points.
    public static func _renderAsync<Stream: AsyncRenderingStreamProtocol>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let info = ElementRenderingInfo.forTag(Tag.self, isPrettyPrinting: isPrettyPrinting)

        let openTag = ElementRendering.buildOpenTag(info: info, context: &context)
        await stream.write(openTag)

        if let content = html.content {
            let saved = ElementRendering.prepareContentContext(info: info, context: &context)
            defer { ElementRendering.restoreContext(saved, context: &context) }
            await Content._renderAsync(content, into: stream, context: &context)
        }

        if let closeTag = ElementRendering.buildCloseTag(info: info, context: &context) {
            await stream.write(closeTag)
        }
    }
}
