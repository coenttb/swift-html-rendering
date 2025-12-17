//
//  Imagesizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the sizes attribute on an image element
    @discardableResult
    package func sizes(
        _ value: ImageSizes?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ImageSizes.attribute, value?.description)
    }
}
