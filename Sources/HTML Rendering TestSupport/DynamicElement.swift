//
//  DynamicElement.swift
//  swift-html-rendering
//
//  Test support for creating HTML elements from string tag names.
//

import HTML_Renderable
import Rendering
import W3C_CSS_Shared
import WHATWG_HTML_Shared

// MARK: - Tag Function for Testing

/// Creates an HTML element with the specified tag name and content.
///
/// This function is provided for testing purposes only. In production code,
/// use the typed element functions like `div()`, `span()`, etc.
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: An HTML element with the specified tag and content.
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { Empty() }
) -> HTML.Element<T> {
    HTML.Element(tag: tagName, content: content)
}

// MARK: - String-based Inline Style for Testing

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
    ///
    /// This version supports explicit atRule/selector/pseudo parameters for testing.
    /// In production code, use the context-based API via CSS modifiers.
    public func inlineStyle(
        _ property: String,
        _ value: String,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.Styled<Self, TestProperty> {
        HTML.Styled(
            self,
            TestProperty(property, value),
            atRule: atRule,
            selector: selector,
            pseudo: pseudo
        )
    }
}

// MARK: - HTML.Tag callAsFunction for Testing

extension HTML.Tag {
    /// Creates an empty HTML element with this tag. For testing only.
    public func callAsFunction() -> HTML.Element<Empty> {
        HTML.Element(tag: self.rawValue) { Empty() }
    }

    /// Creates an HTML element with content. For testing only.
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element<T> {
        HTML.Element(tag: self.rawValue, content: content)
    }
}

// MARK: - HTML.Element callAsFunction for Testing

extension HTML.Element where Content == Empty {
    /// Creates a new HTML element with the same tag but different content. For testing only.
    ///
    /// This allows the pattern:
    /// ```swift
    /// let div = tag("div")  // Returns HTML.Element<Empty>
    /// let content = div { "Hello" }  // Returns HTML.Element<String>
    /// ```
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element<T> {
        HTML.Element<T>(tag: self.tagName, content: content)
    }
}

// extension HTML.Tag.Void {
//    /// Creates an HTML void element with this tag. For testing only.
//    public func callAsFunction() -> HTML.Element<Empty> {
//        HTML.Element(tag: self.rawValue) { Empty() }
//    }
// }
//
// extension HTML.Tag.Text {
//    /// Creates an HTML element with text content. For testing only.
//    public func callAsFunction(_ content: String = "") -> HTML.Element<HTML.Text> {
//        HTML.Element(tag: self.rawValue) { HTML.Text(content) }
//    }
//
//    /// Creates an HTML element with dynamic text content. For testing only.
//    public func callAsFunction(_ content: () -> String) -> HTML.Element<HTML.Text> {
//        HTML.Element(tag: self.rawValue) { HTML.Text(content()) }
//    }
// }
