//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.ContentDivision {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    )
        -> some HTML.View {
        HTML.Element(tag: Self.tag) { content() }
    }
}
