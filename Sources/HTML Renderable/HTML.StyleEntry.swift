//
//  HTML.StyleEntry.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 03/12/2025.
//

public import W3C_CSS_Shared

extension HTML {
    /// A type-erased style entry for rendering.
    ///
    /// `StyleEntry` captures the CSS declaration and contextual information
    /// (at-rule, selector, pseudo) needed for stylesheet generation.
    /// This is the rendering-pipeline format, created from typed `HTML.Style<P>`.
    public struct StyleEntry: Hashable, Sendable {
        /// The CSS declaration (property:value)
        public let declaration: Declaration

        /// Optional at-rule (e.g., media query)
        public let atRule: HTML.AtRule?

        /// Optional CSS selector
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: HTML.Pseudo?

        /// Create a style entry from a typed style
        public init<P: Property>(_ style: HTML.Style<P>) {
            self.declaration = style.declaration
            self.atRule = style.atRule
            self.selector = style.selector
            self.pseudo = style.pseudo
        }

        /// Create a style entry directly
        public init(
            declaration: Declaration,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = declaration
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// The CSS property name extracted from declaration
        public var propertyName: String {
            // Declaration format is "property:value"
            // Extract property name for class naming
            let desc = declaration.description
            if let colonIndex = desc.firstIndex(of: ":") {
                return String(desc[desc.startIndex..<colonIndex])
            }
            return desc
        }

        /// The full declaration string
        public var declarationString: String {
            declaration.description
        }
    }
}
