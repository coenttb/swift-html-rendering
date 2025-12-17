//
//  WHATWG_HTML.Styled.swift
//  swift-html-rendering
//
//  Applies CSS styles to HTML content via generated class names.
//

import Rendering
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// A wrapper that applies a CSS style to HTML content.
    ///
    /// `WHATWG_HTML.Styled` applies CSS styles to HTML elements by generating
    /// unique class names and collecting the associated styles in a stylesheet.
    ///
    /// ```swift
    /// div()
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Styles are collected in the render context and output as a `<style>` block.
    /// The `P` generic preserves the typed property for PDF rendering.
    public struct Styled<Content, P: Property> {
        /// The HTML content being styled.
        public let content: Content

        /// The typed CSS property (nil if no style).
        public let property: P?

        /// The style metadata for HTML rendering.
        public let style: WHATWG_HTML.Element.Style?

        /// Optional at-rule (e.g., media query).
        public let atRule: WHATWG_HTML.AtRule?

        /// Optional CSS selector prefix.
        public let selector: WHATWG_HTML.Selector?

        /// Optional pseudo-class or pseudo-element.
        public let pseudo: WHATWG_HTML.Pseudo?

        /// Creates a styled HTML element from a typed CSS property.
        ///
        /// - Parameters:
        ///   - content: The HTML content to style.
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            _ content: Content,
            _ property: P?,
            atRule: WHATWG_HTML.AtRule? = nil,
            selector: WHATWG_HTML.Selector? = nil,
            pseudo: WHATWG_HTML.Pseudo? = nil
        ) {
            self.content = content
            self.property = property
            self.style = property.map {
                WHATWG_HTML.Element.Style($0, atRule: atRule, selector: selector, pseudo: pseudo)
            }
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}



extension WHATWG_HTML.Styled: Renderable where Content: WHATWG_HTML.View {
    public typealias Context = WHATWG_HTML.Context

    public typealias Output = UInt8
}

extension WHATWG_HTML.Styled: WHATWG_HTML.View where Content: WHATWG_HTML.View {
    /// Renders this styled HTML element into the provided buffer.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: WHATWG_HTML.Styled<Content, P>,
        into buffer: inout Buffer,
        context: inout WHATWG_HTML.Context
    ) where Buffer.Element == UInt8 {
        // Push style to context, get class name
        if let style = html.style {
            let className = context.pushStyle(style)
            // Append to existing class or set new
            if let existing = context.attributes["class"] {
                context.attributes["class"] = existing + " " + className
            } else {
                context.attributes["class"] = className
            }
        }
        // Render content with static dispatch
        Content._render(html.content, into: &buffer, context: &context)
    }

    /// This type uses direct rendering and doesn't have a body.
    public var body: Never { fatalError("body should not be called") }
}

extension WHATWG_HTML.Styled: Sendable where Content: Sendable, P: Sendable {}

// MARK: - WHATWG_HTML.View Extension

extension WHATWG_HTML.View {
    /// Applies a typed CSS property to an HTML element.
    ///
    /// This method enables a type-safe, declarative approach to styling HTML elements
    /// directly in Swift code. It generates CSS classes and stylesheets automatically.
    ///
    /// The at-rule, selector, and pseudo values are read from the current
    /// `WHATWG_HTML.Element.Style.Context` TaskLocal, allowing context-based styling:
    ///
    /// ```swift
    /// // Basic usage
    /// div { "Hello" }
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Padding.px(10))
    ///
    /// // With context (via CSS modifiers)
    /// div.css.dark { $0.color(.white) }
    /// button.css.hover { $0.backgroundColor(.blue) }
    /// ```
    ///
    /// - Parameter property: The typed CSS property value.
    /// - Returns: An HTML element with the specified style applied.
    public func inlineStyle<P: Property>(
        _ property: P?
    ) -> WHATWG_HTML.Styled<Self, P> {
        let ctx = WHATWG_HTML.Element.Style.Context.current
        return WHATWG_HTML.Styled(
            self,
            property,
            atRule: ctx.atRule,
            selector: ctx.selector,
            pseudo: ctx.pseudo
        )
    }
}
