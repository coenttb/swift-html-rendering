//
//  Async.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the async attribute on an element
    @discardableResult
    package func async(
        _ value: Async?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
