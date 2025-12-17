//
//  ListType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the type attribute on a list element
    @discardableResult
    package func type(
        _ value: ListType?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ListType.attribute, value?.description)
    }
}
