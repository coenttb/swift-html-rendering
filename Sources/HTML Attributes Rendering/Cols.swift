//
//  Cols.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the cols attribute on an element
    @discardableResult
    package func cols(
        _ value: Cols?
    ) -> HTML._Attributes<Self> {
        self.attribute(Cols.attribute, value?.description)
    }
}
