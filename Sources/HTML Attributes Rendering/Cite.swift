//
//  Cite.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the cite attribute on an element
    @discardableResult
    package func cite(
        _ value: Cite?
    ) -> HTML._Attributes<Self> {
        self.attribute(Cite.attribute, value?.description)
    }
}
