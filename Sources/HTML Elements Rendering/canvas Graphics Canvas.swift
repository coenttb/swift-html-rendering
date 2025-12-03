//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.Canvas {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element(for: Self.self, tag: Self.tag) { content() }
            .width(self.width)
            .height(self.height)
    }
}
