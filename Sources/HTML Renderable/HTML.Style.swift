//
//  HTML.Style.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

extension HTML {
    /// Represents a CSS style with its property, value, and selectors.
    ///
    /// Used for tracking CSS styles applied to HTML elements. This type is used
    /// by `HTML.InlineStyle` and can be extracted for PDF rendering or other
    /// processing that needs access to computed CSS properties.
    public struct Style: Hashable, Sendable {
        /// The CSS property name (e.g., "color", "font-size", "margin")
        public let property: String

        /// The CSS property value (e.g., "red", "16px", "1rem")
        public let value: String

        /// Optional at-rule (e.g., media query)
        public let atRule: HTML.AtRule?

        /// Optional CSS selector
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: HTML.Pseudo?

        /// Create a new CSS style.
        public init(
            property: String,
            value: String,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.property = property
            self.value = value
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}
