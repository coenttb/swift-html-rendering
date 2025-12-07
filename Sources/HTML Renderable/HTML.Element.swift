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
    /// `HTML.Element` is a fundamental building block representing a standard HTML element
    /// with a tag name, attributes, and optional child content. This type handles the
    /// rendering of both opening and closing tags, attribute formatting, and proper
    /// indentation based on block vs. inline elements.
    ///
    /// Example using typed initializer:
    /// ```swift
    /// HTML.Element(for: WHATWG_HTML.Grouping.Div.self) {
    ///     p { "Hello, world!" }
    /// }
    /// ```
    ///
    /// Example using string initializer:
    /// ```swift
    /// HTML.Element(tag: "div") {
    ///     "Hello, world!"
    /// }
    /// ```
    ///
    /// This type is typically not used directly by library consumers, who would
    /// instead use the more convenient tag functions like `div`, `span`, `p`, etc.
    public struct Element<Content: HTML.View>: HTML.View {
        /// The HTML tag name for this element.
        public let tagName: String

        /// Whether this is a block-level element (for pretty-printing).
        let isBlock: Bool

        /// Whether this is a void element (no closing tag).
        let isVoid: Bool

        /// Whether this is a pre element (preserves whitespace).
        let isPreElement: Bool

        /// The optional content contained within this element.
        @HTML.Builder public let content: Content?

        // MARK: - Initializers

        /// Creates a new HTML element with a typed tag.
        ///
        /// This initializer captures tag metadata at construction time from the
        /// compile-time type, enabling type-safe element creation while storing
        /// the metadata as values for flexible rendering.
        ///
        /// - Parameters:
        ///   - tagType: The WHATWG HTML element type.
        ///   - content: A closure that returns the content of this element.
        public init<Tag: WHATWG_HTML.Element.`Protocol`>(
            for tagType: Tag.Type,
            @HTML.Builder content: () -> Content? = { Never?.none }
        ) {
            self.tagName = Tag.tag
            self.isBlock = !Tag.categories.contains(.phrasing)
            self.isVoid = Tag.content.model == .nothing
            self.isPreElement = Tag.tag == "pre"
            self.content = content()
        }

        /// Creates a new HTML element with a string tag name.
        ///
        /// Uses runtime lookup for tag metadata. Prefer the typed initializer
        /// when the tag is known at compile time.
        ///
        /// - Parameters:
        ///   - tag: The HTML tag name.
        ///   - content: A closure that returns the content of this element.
        public init(
            tag: String,
            @HTML.Builder content: () -> Content? = { Never?.none }
        ) {
            self.tagName = tag
            let categories = WHATWG_HTML.Element.Content.categories(for: tag)
            self.isBlock = !categories.contains(.phrasing)
            self.isVoid = WHATWG_HTML.Element.Content.model(for: tag) == .nothing
            self.isPreElement = tag == "pre"
            self.content = content()
        }

        // MARK: - Rendering

        /// Renders this HTML element into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            let isPrettyPrinting = !context.configuration.newline.isEmpty
            let htmlIsBlock = isPrettyPrinting && html.isBlock

            // Add newline and indentation for block elements
            if htmlIsBlock {
                buffer.append(contentsOf: context.configuration.newline)
                buffer.append(contentsOf: context.currentIndentation)
            }

            // Write opening tag
            buffer.append(.ascii.lessThanSign)
            buffer.append(contentsOf: html.tagName.utf8)

            // Add attributes - single-pass escaping without intermediate allocation
            for (name, value) in context.attributes {
                buffer.append(.ascii.space)
                buffer.append(contentsOf: name.utf8)
                if !value.isEmpty {
                    buffer.append(.ascii.equalsSign)
                    buffer.append(.ascii.dquote)

                    // Single-pass: iterate directly over UTF-8 view, escape as needed
                    for byte in value.utf8 {
                        switch byte {
                        case .ascii.dquote:
                            buffer.append(contentsOf: [UInt8].html.doubleQuotationMark)
                        case .ascii.apostrophe:
                            buffer.append(contentsOf: [UInt8].html.apostrophe)
                        case .ascii.ampersand:
                            buffer.append(contentsOf: [UInt8].html.ampersand)
                        case .ascii.lessThanSign:
                            buffer.append(contentsOf: [UInt8].html.lessThan)
                        case .ascii.greaterThanSign:
                            buffer.append(contentsOf: [UInt8].html.greaterThan)
                        default:
                            buffer.append(byte)
                        }
                    }

                    buffer.append(.ascii.dquote)
                }
            }
            buffer.append(.ascii.greaterThanSign)

            // Render content if present
            if let content = html.content {
                let oldAttributes = context.attributes
                let oldIndentation = context.currentIndentation
                defer {
                    context.attributes = oldAttributes
                    context.currentIndentation = oldIndentation
                }
                context.attributes.removeAll()
                if htmlIsBlock && !html.isPreElement {
                    context.currentIndentation += context.configuration.indentation
                }
                Content._render(content, into: &buffer, context: &context)
            }

            // Add closing tag unless it's a void element
            if !html.isVoid {
                if htmlIsBlock && !html.isPreElement {
                    buffer.append(contentsOf: context.configuration.newline)
                    buffer.append(contentsOf: context.currentIndentation)
                }
                buffer.append(.ascii.lessThanSign)
                buffer.append(.ascii.slant)
                buffer.append(contentsOf: html.tagName.utf8)
                buffer.append(.ascii.greaterThanSign)
            }
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
        let htmlIsBlock = isPrettyPrinting && html.isBlock

        // Build opening tag into local buffer, then write once
        var openTag: [UInt8] = []

        if htmlIsBlock {
            openTag.append(contentsOf: context.configuration.newline)
            openTag.append(contentsOf: context.currentIndentation)
        }

        openTag.append(.ascii.lessThanSign)
        openTag.append(contentsOf: html.tagName.utf8)

        // Add attributes
        for (name, value) in context.attributes {
            openTag.append(.ascii.space)
            openTag.append(contentsOf: name.utf8)
            if !value.isEmpty {
                openTag.append(.ascii.equalsSign)
                openTag.append(.ascii.dquote)

                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        openTag.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        openTag.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        openTag.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        openTag.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        openTag.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        openTag.append(byte)
                    }
                }

                openTag.append(.ascii.dquote)
            }
        }
        openTag.append(.ascii.greaterThanSign)

        await stream.write(openTag)

        // Render content if present
        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !html.isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            await Content._renderAsync(content, into: stream, context: &context)
        }

        // Add closing tag unless it's a void element
        if !html.isVoid {
            var closeTag: [UInt8] = []
            if htmlIsBlock && !html.isPreElement {
                closeTag.append(contentsOf: context.configuration.newline)
                closeTag.append(contentsOf: context.currentIndentation)
            }
            closeTag.append(.ascii.lessThanSign)
            closeTag.append(.ascii.slant)
            closeTag.append(contentsOf: html.tagName.utf8)
            closeTag.append(.ascii.greaterThanSign)

            await stream.write(closeTag)
        }
    }
}
