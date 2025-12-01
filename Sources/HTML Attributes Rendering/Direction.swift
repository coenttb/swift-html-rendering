//
//  Direction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the direction attribute on an element
    @discardableResult
    package func direction(
        _ value: Direction?
    ) -> HTML._Attributes<Self> {
        self.attribute(Direction.attribute, value?.description)
    }
}
