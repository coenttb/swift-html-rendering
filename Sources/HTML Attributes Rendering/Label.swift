//
//  Label.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the disablepictureinpicture attribute on an element
    @discardableResult
    @_disfavoredOverload
    package func label(
        _ value: HTML_Standard_Attributes.Label?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Label.attribute, value?.description)
    }
}
