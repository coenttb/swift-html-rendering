//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering
extension Link: @retroactive Renderable {}
extension HTML_Standard_Elements.Link: HTML.View {
    public var body: some HTML.View {
        HTML.Element(tag: Self.tag) { HTML.Empty() }
            .`as`(self.`as`)
            .blocking(self.blocking)
            .crossorigin(self.crossorigin)
            .disabled(self.disabled)
            .fetchPriority(self.fetchpriority)
            .href(self.href)
            .hreflang(self.hreflang)
            .sizes(self.imagesizes)
            .srcset(self.imagesrcset)
            .integrity(self.integrity)
            .media(self.media)
            .referrerPolicy(self.referrerpolicy)
            .rel(self.rel)
            .sizes(self.sizes)
            .title(self.title)
            .type(self.type)
    }
}
