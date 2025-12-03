//
//  HTML.Style.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import W3C_CSS_Shared

extension HTML {
    /// A typed CSS style preserving the original property value.
    ///
    /// `HTML.Style` carries a typed CSS property value from the W3C CSS library.
    /// This enables type-safe CSS styling with compile-time guarantees.
    ///
    /// For browser output, use `.declaration` which produces the CSS string.
    /// For PDF rendering, extract `.property` for direct typed conversion.
    public struct Style<P: Property>: Hashable, Sendable {
        /// The typed CSS property value
        public let property: P

        /// Optional at-rule (e.g., media query)
        public let atRule: HTML.AtRule?

        /// Optional CSS selector
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: HTML.Pseudo?

        /// Create a new typed CSS style.
        public init(
            _ property: P,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.property = property
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// The CSS property name (e.g., "color", "font-size", "margin")
        public var propertyName: String { P.property }

        /// The CSS property value as a string
        public var value: String { property.description }

        /// The CSS declaration (property:value) for browser output
        public var declaration: Declaration { property.declaration }
    }
}
