//
//  Playsinline.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the playsinline attribute on an element
    @discardableResult
    package func playsinline(
        _ value: Playsinline?
    ) -> HTML._Attributes<Self> {
        self.attribute(Playsinline.attribute, value?.description)
    }
}
