//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering
extension Track: @retroactive Renderable {}
extension HTML_Standard_Elements.Track: HTML.View {
    public var body: some HTML.View {
        HTML.Element(for: Self.self, tag: Self.tag) { HTML.Empty() }
            .default(self.default)
            .kind(self.kind)
            .label(self.label)
            .src(self.src)
            .srcLang(self.srclang)
    }
}
