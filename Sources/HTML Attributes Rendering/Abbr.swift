//
//  ColSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the colspan attribute on an element
    @discardableResult
    package func abbr(
        _ value: Abbr?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Abbr.attribute, value?.description)
    }
}
