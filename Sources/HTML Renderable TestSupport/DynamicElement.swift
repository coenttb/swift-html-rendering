//
//  DynamicElement.swift
//  swift-html-rendering
//
//  Test support for creating HTML elements from string tag names.
//

@_spi(Internal) import HTML_Renderable
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
            let isPrettyPrinting = !context.configuration.newline.isEmpty
            let info = ElementRenderingInfo.forTagName(html.tagName, isPrettyPrinting: isPrettyPrinting)

            ElementRendering.renderOpenTag(info: info, context: &context, into: &buffer)

            if let content = html.content {
                let saved = ElementRendering.prepareContentContext(info: info, context: &context)
                defer { ElementRendering.restoreContext(saved, context: &context) }
                Content._render(content, into: &buffer, context: &context)
            }

            ElementRendering.renderCloseTag(info: info, context: &context, into: &buffer)
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
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let info = ElementRenderingInfo.forTagName(html.tagName, isPrettyPrinting: isPrettyPrinting)

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
