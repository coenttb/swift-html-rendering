//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Body {
    public func callAsFunction<Content: WHATWG_HTML.View>(
        @WHATWG_HTML.Builder _ content: () -> Content
    ) -> WHATWG_HTML.Element.Tag<Content> {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
    }
}
