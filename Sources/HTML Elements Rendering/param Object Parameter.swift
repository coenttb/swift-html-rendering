//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering
extension Param: @retroactive Renderable {}
extension HTML_Standard_Elements.Param: HTML.View {
    public var body: some HTML.View {
        HTML.Element(tag: Self.tag) { HTML.Empty() }
            .name(self.name)
            .value(self.value)
    }
}
