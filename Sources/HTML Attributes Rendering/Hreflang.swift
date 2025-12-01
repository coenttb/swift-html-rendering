//
//  Hreflang.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the hreflang attribute on an element
    @discardableResult
    package func hreflang(
        _ value: Hreflang?
    ) -> HTML._Attributes<Self> {
        self.attribute(Hreflang.attribute, value?.description)
    }
}
