//
//  Sizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the sizes attribute on an element
    @discardableResult
    package func sizes(
        _ value: Sizes?
    ) -> HTML._Attributes<Self> {
        self.attribute(Sizes.attribute, value?.description)
    }
}
