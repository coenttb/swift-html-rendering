//
//  HTML.InlineStyle.Protocol.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import Renderable

/// Protocol to enable extraction of styles and content from HTML.InlineStyle wrappers.
///
/// This protocol enables type-safe style extraction for PDF rendering and other
/// use cases that need access to the CSS properties applied to HTML elements.
public protocol HTMLInlineStyleProtocol: HTML.View {
    /// Extract the CSS styles applied to this element.
    func extractStyles() -> [HTML.Style]

    /// Extract the wrapped HTML content.
    func extractContent() -> any HTML.View
}
