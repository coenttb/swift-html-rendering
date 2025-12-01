//
//  Controls.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the controls attribute on an element
    @discardableResult
    package func controls(
        _ value: Controls?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
