//
//  DynamicElement.swift
//  swift-html-rendering
//
//  Test support for creating HTML elements from string tag names.
//

import HTML_Renderable
import Renderable
import WHATWG_HTML_Shared

// MARK: - Dynamic Element for Testing

extension HTML {
    /// A dynamic HTML element for testing purposes.
    ///
    /// Unlike `HTML.Element<Tag, Content>` which requires a typed `WHATWG_HTML.Element`,
    /// this type allows creating elements from string tag names. Use this only for testing.
    public struct DynamicElement<Content: HTML.View>: HTML.View {
        public let tagName: String
        @HTML.Builder public let content: Content?

        public init(
            tag: String,
            @HTML.Builder content: () -> Content? = { Never?.none }
        ) {
            self.tagName = tag
            self.content = content()
        }

        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            let isPreElement = html.tagName == "pre"
            let htmlIsBlock = WHATWG_HTML.Flow(for: html.tagName) == .block

            if htmlIsBlock {
                buffer.append(contentsOf: context.configuration.newline)
                buffer.append(contentsOf: context.currentIndentation)
            }

            buffer.append(.ascii.lessThanSign)
            buffer.append(contentsOf: html.tagName.utf8)

            for (name, value) in context.attributes {
                buffer.append(.ascii.space)
                buffer.append(contentsOf: name.utf8)
                if !value.isEmpty {
                    buffer.append(.ascii.equalsSign)
                    buffer.append(.ascii.dquote)
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

            if let content = html.content {
                let oldAttributes = context.attributes
                let oldIndentation = context.currentIndentation
                defer {
                    context.attributes = oldAttributes
                    context.currentIndentation = oldIndentation
                }
                context.attributes.removeAll()
                if htmlIsBlock && !isPreElement {
                    context.currentIndentation += context.configuration.indentation
                }
                Content._render(content, into: &buffer, context: &context)
            }

            if !WHATWG_HTML.isVoid(for: html.tagName) {
                if htmlIsBlock && !isPreElement {
                    buffer.append(contentsOf: context.configuration.newline)
                    buffer.append(contentsOf: context.currentIndentation)
                }
                buffer.append(.ascii.lessThanSign)
                buffer.append(.ascii.slant)
                buffer.append(contentsOf: html.tagName.utf8)
                buffer.append(.ascii.greaterThanSign)
            }
        }

        public var body: Never {
            fatalError()
        }
    }
}

extension HTML.DynamicElement: Sendable where Content: Sendable {}

// MARK: - AsyncRenderable Conformance

extension HTML.DynamicElement: AsyncRenderable where Content: AsyncRenderable {
    public static func _renderAsync<Stream: AsyncRenderingStreamProtocol>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        let isPreElement = html.tagName == "pre"
        let htmlIsBlock = WHATWG_HTML.Flow(for: html.tagName) == .block

        var openTag: [UInt8] = []

        if htmlIsBlock {
            openTag.append(contentsOf: context.configuration.newline)
            openTag.append(contentsOf: context.currentIndentation)
        }

        openTag.append(.ascii.lessThanSign)
        openTag.append(contentsOf: html.tagName.utf8)

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

        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            await Content._renderAsync(content, into: stream, context: &context)
        }

        if !WHATWG_HTML.isVoid(for: html.tagName) {
            var closeTag: [UInt8] = []
            if htmlIsBlock && !isPreElement {
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

// MARK: - Tag Function for Testing

/// Creates an HTML element with the specified tag name and content.
///
/// This function is provided for testing purposes only. In production code,
/// use the typed element functions like `div()`, `span()`, etc.
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: A dynamic HTML element with the specified tag and content.
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { Empty() }
) -> HTML.DynamicElement<T> {
    HTML.DynamicElement(tag: tagName, content: content)
}

// MARK: - String-based Inline Style for Testing

import W3C_CSS_Shared

/// A simple string-based CSS property for testing.
///
/// This is a workaround to support string-based property/value for tests.
/// Since `Property.property` is static and we need dynamic names, we use
/// a custom `Declaration` initializer.
public struct TestProperty: Property, GlobalConvertible {
    public static var property: String { "" }
    public let name: String
    public let value: String

    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }

    public static func global(_ global: Global) -> TestProperty {
        TestProperty("", global.rawValue)
    }

    /// Returns just the value, since `Declaration.init` adds the property name
    public var description: String {
        value
    }

    /// Custom declaration that uses our dynamic name instead of the static property
    public var declaration: Declaration {
        Declaration(description: "\(name):\(value)")
    }
}

extension HTML.View {
    /// Applies a string-based inline style. For testing only.
    public func inlineStyle(
        _ property: String,
        _ value: String,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.InlineStyle<Self, TestProperty> {
        self.inlineStyle(TestProperty(property, value), atRule: atRule, selector: selector, pseudo: pseudo)
    }
}

// MARK: - HTML.Tag callAsFunction for Testing

extension HTML.Tag {
    /// Creates an empty HTML element with this tag. For testing only.
    public func callAsFunction() -> HTML.DynamicElement<Empty> {
        HTML.DynamicElement(tag: self.rawValue) { Empty() }
    }

    /// Creates an HTML element with content. For testing only.
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.DynamicElement<T> {
        HTML.DynamicElement(tag: self.rawValue, content: content)
    }
}

extension HTML.Tag.Void {
    /// Creates an HTML void element with this tag. For testing only.
    public func callAsFunction() -> HTML.DynamicElement<Empty> {
        HTML.DynamicElement(tag: self.rawValue) { Empty() }
    }
}

extension HTML.Tag.Text {
    /// Creates an HTML element with text content. For testing only.
    public func callAsFunction(_ content: String = "") -> HTML.DynamicElement<HTML.Text> {
        HTML.DynamicElement(tag: self.rawValue) { HTML.Text(content) }
    }

    /// Creates an HTML element with dynamic text content. For testing only.
    public func callAsFunction(_ content: () -> String) -> HTML.DynamicElement<HTML.Text> {
        HTML.DynamicElement(tag: self.rawValue) { HTML.Text(content()) }
    }
}
