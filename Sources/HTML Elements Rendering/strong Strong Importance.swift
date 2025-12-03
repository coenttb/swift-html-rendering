//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.StrongImportance {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Self, Content> {
        HTML.Element(for: Self.self, tag: Self.tag) { content() }
    }
}
