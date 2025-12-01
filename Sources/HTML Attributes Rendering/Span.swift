//
//  Span.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the span attribute on an element
    @discardableResult
    package func span(
        _ value: Span?
    ) -> HTML._Attributes<Self> {
        self.attribute(Span.attribute, value?.description)
    }
}
