//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func download(
        _ value: Download?
    ) -> HTML._Attributes<Self> {
        self.attribute(Download.attribute, value?.description)
    }
}
