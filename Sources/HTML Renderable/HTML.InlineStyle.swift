//
//  HTML.InlineStyle.swift
//
//
//  Created by Point-Free, Inc
//

import OrderedCollections
import Renderable
public import W3C_CSS_Shared

extension HTML {
    /// A wrapper that applies a typed CSS style to an HTML element.
    ///
    /// `HTML.InlineStyle` applies CSS styles to HTML elements by generating
    /// unique class names and collecting the associated styles in a stylesheet.
    /// This approach allows for efficient CSS generation and prevents duplication
    /// of styles across multiple elements.
    ///
    /// The style is captured as a type-erased `StyleEntry` at construction time,
    /// enabling both typed CSS property usage and efficient rendering.
    public struct InlineStyle<Content: HTML.View>: HTML.View {
        /// The HTML content being styled.
        private let content: Content

        /// The type-erased style entry to apply.
        private let styleEntry: HTML.StyleEntry?

        /// Creates a new styled HTML element with a typed CSS property.
        ///
        /// - Parameters:
        ///   - content: The HTML element to style.
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init<P: Property>(
            content: Content,
            property: P?,
            atRule: HTML.AtRule?,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo?
        ) {
            self.content = content
            self.styleEntry = property.map {
                HTML.StyleEntry(
                    declaration: $0.declaration,
                    atRule: atRule,
                    selector: selector,
                    pseudo: pseudo
                )
            }
        }

        /// Creates a new styled HTML element with a pre-built style entry.
        ///
        /// - Parameters:
        ///   - content: The HTML element to style.
        ///   - styleEntry: The type-erased style entry to apply.
        public init(
            content: Content,
            styleEntry: HTML.StyleEntry?
        ) {
            self.content = content
            self.styleEntry = styleEntry
        }

        // Helper function to build CSS selector
        private static func buildSelector(className: String, entry: HTML.StyleEntry) -> String {
            var totalLength = 1 + className.count
            if let pre = entry.selector?.rawValue {
                totalLength += pre.count + 1
            }
            if let pseudo = entry.pseudo?.rawValue {
                totalLength += pseudo.count
            }

            var selector = ""
            selector.reserveCapacity(totalLength)

            if let pre = entry.selector?.rawValue {
                selector.append(pre)
                selector.append(" ")
            }

            selector.append(".")
            selector.append(className)

            if let pseudo = entry.pseudo?.rawValue {
                selector.append(pseudo)
            }

            return selector
        }

        /// Renders this styled HTML element into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: HTML.InlineStyle<Content>,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            let previousClass = context.attributes["class"]
            defer { context.attributes["class"] = previousClass }

            // Collect all style entries from nested elements
            var allEntries: [HTML.StyleEntry] = []
            allEntries.reserveCapacity(8)
            var coreContent: any HTML.View = html

            // Flatten style chain (traverses outer-to-inner)
            while let styledElement = coreContent as? any HTMLInlineStyleProtocol {
                allEntries.append(contentsOf: styledElement.extractStyleEntries())
                coreContent = styledElement.extractContent()
            }

            // Reverse to get original application order (inner-to-outer = first applied first)
            allEntries.reverse()

            guard !allEntries.isEmpty else {
                coreContent.render(into: &buffer, context: &context)
                return
            }

            // Generate class names using context-local sequential naming
            let classNames = context.classNames(for: allEntries)
            var classComponents: [String] = []
            classComponents.reserveCapacity(classNames.count)

            for (entry, className) in zip(allEntries, classNames) {
                let selector = buildSelector(className: className, entry: entry)

                // Add to stylesheet if not present
                let key = HTML.StyleKey(entry.atRule, selector)
                if context.styles[key] == nil {
                    context.styles[key] = entry.declarationString
                }

                classComponents.append(className)
            }

            // Apply class names
            if let existingClass = context.attributes["class"] {
                let totalLength = existingClass.count + 1 + classComponents.reduce(0) { $0 + $1.count } + (classComponents.count - 1)
                var result = ""
                result.reserveCapacity(totalLength)
                result.append(existingClass)
                result.append(" ")
                for (index, className) in classComponents.enumerated() {
                    if index > 0 {
                        result.append(" ")
                    }
                    result.append(className)
                }
                context.attributes["class"] = result
            } else {
                let totalLength = classComponents.reduce(0) { $0 + $1.count } + (classComponents.count - 1)
                var result = ""
                result.reserveCapacity(totalLength)
                for (index, className) in classComponents.enumerated() {
                    if index > 0 {
                        result.append(" ")
                    }
                    result.append(className)
                }
                context.attributes["class"] = result
            }

            coreContent.render(into: &buffer, context: &context)
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never { fatalError() }
    }
}

extension HTML.InlineStyle: Sendable where Content: Sendable {}

// Make HTML.InlineStyle conform to the protocol
extension HTML.InlineStyle: HTMLInlineStyleProtocol {
    public func extractStyleEntries() -> [HTML.StyleEntry] {
        guard let styleEntry = styleEntry else { return [] }
        return [styleEntry]
    }

    public func extractContent() -> any HTML.View {
        return content
    }
}

/// Extension to add inline styling capabilities to all HTML elements.
extension HTML.View {
    /// Applies a typed CSS property to an HTML element.
    ///
    /// This method enables a type-safe, declarative approach to styling HTML elements
    /// directly in Swift code. It generates CSS classes and stylesheets automatically.
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
    ) -> HTML.InlineStyle<Self> {
        HTML.InlineStyle(
            content: self,
            property: property,
            atRule: atRule,
            selector: selector,
            pseudo: pseudo
        )
    }

    @_disfavoredOverload
    public func inlineStyle<P: Property>(
        _ property: P?,
        media: HTML.AtRule.Media? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.InlineStyle<Self> {
        HTML.InlineStyle(
            content: self,
            property: property,
            atRule: media,
            selector: selector,
            pseudo: pseudo
        )
    }
}
