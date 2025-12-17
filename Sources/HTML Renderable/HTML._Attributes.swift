//
//  WHATWG_HTML._Attributes.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import OrderedCollections
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// A wrapper that applies attributes to an HTML element.
    ///
    /// `WHATWG_HTML._Attributes` is used to attach HTML attributes to elements in
    /// a type-safe, chainable manner. It manages the collection of attributes
    /// and their rendering into the final HTML output.
    ///
    /// You typically don't create this type directly but use the `attribute`
    /// method and its convenience wrappers (like `href`, `src`, etc.) on HTML elements.
    ///
    /// Example:
    /// ```swift
    /// a { "Visit our site" }
    ///     .href("https://example.com")
    ///     .attribute("target", "_blank")
    /// ```
    public struct _Attributes<Content: WHATWG_HTML.View>: WHATWG_HTML.View {
        /// The HTML content to which attributes are being applied.
        public let content: Content

        /// The collection of attributes to apply.
        public var attributes: OrderedDictionary<String, String>

        /// Adds an additional attribute to this element.
        ///
        /// This method allows for chaining multiple attributes on a single element.
        ///
        /// Example:
        /// ```swift
        /// img()
        ///     .src("image.jpg")
        ///     .attribute("loading", "lazy")
        ///     .attribute("width", "300")
        /// ```
        ///
        /// - Parameters:
        ///   - name: The name of the attribute.
        ///   - value: The optional value of the attribute.
        /// - Returns: An HTML element with both the original and new attributes applied.
        public func attribute(_ name: String, _ value: String? = "") -> WHATWG_HTML._Attributes<Content> {
            var copy = self
            copy.attributes[name] = value
            return copy
        }

        /// Renders this HTML element with attributes into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout WHATWG_HTML.Context
        ) where Buffer.Element == UInt8 {
            let previousValue = context.attributes
            defer { context.attributes = previousValue }
            context.attributes.merge(html.attributes, uniquingKeysWith: { $1 })
            Content._render(html.content, into: &buffer, context: &context)
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never { fatalError("body should not be called") }
    }
}

// MARK: - Sendable

extension WHATWG_HTML._Attributes: Sendable where Content: Sendable {}

// MARK: - Async Rendering

extension WHATWG_HTML._Attributes: AsyncRenderable where Content: AsyncRenderable {
    /// Async renders this HTML element with attributes.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout WHATWG_HTML.Context
    ) async {
        let previousValue = context.attributes
        defer { context.attributes = previousValue }
        context.attributes.merge(html.attributes, uniquingKeysWith: { $1 })
        await Content._renderAsync(html.content, into: stream, context: &context)
    }
}
