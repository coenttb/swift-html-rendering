//
//  Color.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the color attribute on an element
    @discardableResult
    package func color(
        _ value: Color?
    ) -> HTML._Attributes<Self> {
        self.attribute(Color.attribute, value?.description)
    }
}
