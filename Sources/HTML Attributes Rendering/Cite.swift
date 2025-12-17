//
//  Cite.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the cite attribute on an element
    @discardableResult
    package func cite(
        _ value: HTML_Standard_Attributes.Cite?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Cite.attribute, value?.description)
    }
}
