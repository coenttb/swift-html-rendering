//
//  Nomodule.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the nomodule attribute on an element
    @discardableResult
    package func nomodule(
        _ value: Nomodule?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
