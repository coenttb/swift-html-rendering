//
//  Media.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the media attribute on an element
    @discardableResult
    package func media(
        _ value: Media?
    ) -> HTML._Attributes<Self> {
        self.attribute(Media.attribute, value?.description)
    }
}
