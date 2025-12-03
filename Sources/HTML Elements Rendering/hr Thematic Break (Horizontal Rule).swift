//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension ThematicBreak: @retroactive Renderable {}
extension HTML_Standard_Elements.ThematicBreak: HTML.View {
    public var body: HTML.Element<Self, HTML.Empty> {
        HTML.Element(for: Self.self, tag: Self.tag) { HTML.Empty() }
    }
}
