//
//  tag.swift
//  swift-html-rendering
//
//  SPI-exposed function for creating HTML elements from string tag names.
//

public import WHATWG_HTML_Shared

// MARK: - Tag Function (SPI)

/// Creates an HTML element with the specified tag name and content.
///
/// This function allows creating HTML elements dynamically from string tag names.
/// It's exposed via SPI because in most cases you should prefer the typed element
/// functions like `div()`, `span()`, etc. for better type safety.
///
/// The function is generic over `Output`, allowing reuse for different render targets
/// (e.g., `UInt8` for HTML bytes, or layout operations for PDF).
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: An HTML element with the specified tag and content.
///
/// - Note: Import with `@_spi(DynamicHTML) import HTML_Renderable` to access this function.
@_spi(DynamicHTML)
@inlinable
public func tag<T: HTML.View<Output>, Output: HTML.RenderOutput>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T
) -> HTML.Element.Tag<T, Output> {
    HTML.Element.Tag(tag: tagName, content: content)
}

/// Creates an empty HTML element with the specified tag name (UInt8 output).
///
/// This is a convenience overload for creating void elements when rendering to bytes.
///
/// - Parameter tagName: The name of the HTML tag.
/// - Returns: An HTML element with the specified tag and no content.
@_spi(DynamicHTML)
@inlinable
public func tag(_ tagName: String) -> HTML.Element.Tag<Empty, UInt8> {
    HTML.Element.Tag(tag: tagName) { Empty() }
}
