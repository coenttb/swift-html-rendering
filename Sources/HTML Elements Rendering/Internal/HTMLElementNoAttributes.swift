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
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element(tag: Self.tag) { content() }
    }
}
