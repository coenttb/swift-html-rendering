//
//  Poster.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the poster attribute on an element
    @discardableResult
    package func poster(
        _ value: Poster?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Poster.attribute, value?.description)
    }
}
