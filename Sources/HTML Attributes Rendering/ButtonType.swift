//
//  ButtonType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the type attribute on a button element
    @discardableResult
    package func type(
        _ value: ButtonType?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ButtonType.attribute, value?.rawValue)
    }
}
