//
//  Nomodule.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the nomodule attribute on an element
    @discardableResult
    package func nomodule(
        _ value: Nomodule?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
