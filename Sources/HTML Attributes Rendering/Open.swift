//
//  Open.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the open attribute on an element
    @discardableResult
    package func open(
        _ value: Open?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
