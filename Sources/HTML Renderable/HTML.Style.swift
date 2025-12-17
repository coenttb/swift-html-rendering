//
//  WHATWG_HTML.Style.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension WHATWG_HTML.Element {
    /// A CSS style declaration with optional scope modifiers.
    ///
    /// `WHATWG_HTML.Style` captures a CSS declaration and its context (at-rule, selector, pseudo).
    /// This is the unified representation for all styling operations.
    ///
    /// Create styles from typed CSS properties for compile-time safety:
    /// ```swift
    /// WHATWG_HTML.Style(Color.red)
    /// WHATWG_HTML.Style(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Or from raw declaration strings when needed:
    /// ```swift
    /// WHATWG_HTML.Style(declaration: "color:red")
    /// ```
    public struct Style: Hashable, Sendable {
        /// The CSS declaration string (e.g., "color:red")
        public let declaration: String

        /// Optional at-rule (e.g., @media query)
        public let atRule: WHATWG_HTML.AtRule?

        /// Optional CSS selector prefix
        public let selector: WHATWG_HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: WHATWG_HTML.Pseudo?

        /// Create a style from a typed CSS property.
        ///
        /// This is the primary API for creating styles with compile-time type safety.
        ///
        /// - Parameters:
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init<P: Property>(
            _ property: P,
            atRule: WHATWG_HTML.AtRule? = nil,
            selector: WHATWG_HTML.Selector? = nil,
            pseudo: WHATWG_HTML.Pseudo? = nil
        ) {
            self.declaration = property.declaration.description
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// Create a style from a raw declaration string.
        ///
        /// Use this when you need to bypass the typed property system.
        ///
        /// - Parameters:
        ///   - declaration: The CSS declaration string (e.g., "color:red").
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            declaration: String,
            atRule: WHATWG_HTML.AtRule? = nil,
            selector: WHATWG_HTML.Selector? = nil,
            pseudo: WHATWG_HTML.Pseudo? = nil
        ) {
            self.declaration = declaration
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// The CSS property name extracted from the declaration.
        ///
        /// For "color:red", returns "color".
        /// Used for generating descriptive class names.
        public var propertyName: String {
            if let colonIndex = declaration.firstIndex(of: ":") {
                return String(declaration[..<colonIndex])
            }
            return declaration
        }
    }
}
