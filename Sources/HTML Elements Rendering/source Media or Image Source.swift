//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering
extension Source: @retroactive Renderable {}
extension HTML_Standard_Elements.Source: HTML.View {
    public var body: some HTML.View {
        HTML.Element(tag: Self.tag) { HTML.Empty() }
            .type(self.type)
            .src(self.src)
            .srcset(self.srcset)
            .sizes(self.sizes)
            .media(self.media)
            .height(self.height)
            .width(self.width)
    }
}
