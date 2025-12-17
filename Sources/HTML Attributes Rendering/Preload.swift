//
//  Preload.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the preload attribute on an element
    @discardableResult
    package func preload(
        _ value: Preload?
    ) -> HTML._Attributes<Self> {
        self.attribute(Preload.attribute, value?.description)
    }
}
