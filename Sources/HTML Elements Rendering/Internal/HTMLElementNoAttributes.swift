//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

protocol HTMLElementNoAttributes: HTML_Standard_Elements.HTMLElement {}

extension HTMLElementNoAttributes {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Self, Content> {
        HTML.Element(for: Self.self, tag: Self.tag) { content() }
    }
}
