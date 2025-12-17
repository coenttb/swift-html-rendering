//
//  ObjectForm.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the form attribute on an object element
    @discardableResult
    package func form(
        _ value: HTML_Standard_Attributes.Form.ID?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute("form", value?.description)
    }
}
