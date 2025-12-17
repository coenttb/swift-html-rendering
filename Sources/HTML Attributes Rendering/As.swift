//
//  As.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the as attribute on an element
    @discardableResult
    package func `as`(
        _ value: As?
    ) -> HTML._Attributes<Self> {
        self.attribute(As.attribute, value?.rawValue)
    }
}
