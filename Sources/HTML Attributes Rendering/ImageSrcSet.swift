//
//  ImageSrcSet.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the srcset attribute on an image element
    @discardableResult
    package func srcset(
        _ value: ImageSrcSet?
    ) -> HTML._Attributes<Self> {
        self.attribute(ImageSrcSet.attribute, value?.description)
    }
}
