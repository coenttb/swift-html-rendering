//
//  Start.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the start attribute on an element
    @discardableResult
    package func start(
        _ value: Start?
    ) -> HTML._Attributes<Self> {
        self.attribute(Start.attribute, value?.description)
    }
}
