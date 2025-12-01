//
//  ObjectForm.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the form attribute on an object element
    @discardableResult
    package func form(
        _ value: Form.ID?
    ) -> HTML._Attributes<Self> {
        self.attribute("form", value?.description)
    }
}
