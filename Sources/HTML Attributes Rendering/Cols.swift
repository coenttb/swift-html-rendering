//
//  Cols.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the cols attribute on an element
    @discardableResult
    package func cols(
        _ value: Cols?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Cols.attribute, value?.description)
    }
}
