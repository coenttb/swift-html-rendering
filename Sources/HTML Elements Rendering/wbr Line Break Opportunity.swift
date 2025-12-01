//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension LineBreakOpportunity: @retroactive Renderable {}
extension HTML_Standard_Elements.LineBreakOpportunity: HTML.View {
    public var body: HTML.Element<HTML.Empty> {
        HTML.Element(tag: Self.tag) { HTML.Empty() }
    }
}
