//
//  HTML.Styled.swift
//  swift-html-rendering
//
//  Applies CSS styles to HTML content via generated class names.
//

import Renderable
public import W3C_CSS_Shared

extension HTML {
    /// A wrapper that applies a CSS style to HTML content.
    ///
    /// `HTML.Styled` applies CSS styles to HTML elements by generating
    /// unique class names and collecting the associated styles in a stylesheet.
    ///
    /// ```swift
    /// div()
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Styles are collected in the render context and output as a `<style>` block.
    public struct Styled<Content> {
        /// The HTML content being styled.
        let content: Content
        
        /// The style to apply (nil if no style).
        let style: HTML.Style?
        
        /// Creates a styled HTML element from a pre-built style.
        ///
        /// - Parameters:
        ///   - content: The HTML content to style.
        ///   - style: The style to apply.
        public init(
            _ content: Content,
            style: HTML.Style?
        ) {
            self.content = content
            self.style = style
        }
    }
}

extension HTML.Styled {
    /// Creates a styled HTML element from a typed CSS property.
    ///
    /// - Parameters:
    ///   - content: The HTML content to style.
    ///   - property: The typed CSS property value.
    ///   - atRule: Optional at-rule (e.g., media query).
    ///   - selector: Optional selector prefix.
    ///   - pseudo: Optional pseudo-class or pseudo-element.
    public init<P: Property>(
        _ content: Content,
        _ property: P?,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) {
        self.content = content
        self.style = property.map {
            HTML.Style($0, atRule: atRule, selector: selector, pseudo: pseudo)
        }
    }
}

extension HTML.Styled: Renderable where Content: HTML.View {    
    public typealias Context = HTML.Context
    
    public typealias Output = UInt8
}

extension HTML.Styled: HTML.View where Content: HTML.View {
    /// Renders this styled HTML element into the provided buffer.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: HTML.Styled<Content>,
        into buffer: inout Buffer,
        context: inout HTML.Context
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
    public var body: Never { fatalError() }
}


extension HTML.Styled: Sendable where Content: Sendable {}

// MARK: - HTML.View Extension

extension HTML.View {
    /// Applies a typed CSS property to an HTML element.
    ///
    /// This method enables a type-safe, declarative approach to styling HTML elements
    /// directly in Swift code. It generates CSS classes and stylesheets automatically.
    ///
    /// ```swift
    /// div { "Hello" }
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Padding.px(10))
    /// ```
    ///
    /// - Parameters:
    ///   - property: The typed CSS property value.
    ///   - atRule: Optional at-rule to apply this style conditionally.
    ///   - selector: Optional selector prefix for more complex CSS selectors.
    ///   - pseudo: Optional pseudo-class or pseudo-element to apply.
    /// - Returns: An HTML element with the specified style applied.
    public func inlineStyle<P: Property>(
        _ property: P?,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.Styled<Self> {
        HTML.Styled(self, property, atRule: atRule, selector: selector, pseudo: pseudo)
    }

    /// Applies a typed CSS property with a media query.
    ///
    /// Convenience overload that accepts `HTML.AtRule.Media` directly.
    @_disfavoredOverload
    public func inlineStyle<P: Property>(
        _ property: P?,
        media: HTML.AtRule.Media?,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.Styled<Self> {
        HTML.Styled(self, property, atRule: media, selector: selector, pseudo: pseudo)
    }
}
