//
//  Ping.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the ping attribute on an element
    @discardableResult
    package func ping(
        _ value: Ping?
    ) -> HTML._Attributes<Self> {
        self.attribute(Ping.attribute, value?.description)
    }
}
