//
//  Content.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the content attribute on an element
    @discardableResult
    package func content(
        _ value: HTML_Standard_Attributes.Content?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(HTML_Standard_Attributes.Content.attribute, value?.description)
    }
}
