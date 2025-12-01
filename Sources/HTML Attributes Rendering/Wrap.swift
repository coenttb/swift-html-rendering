//
//  Wrap.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the wrap attribute on an element
    @discardableResult
    package func wrap(
        _ value: TextareaWrap?
    ) -> HTML._Attributes<Self> {
        self.attribute(TextareaWrap.attribute, value?.description)
    }
}
