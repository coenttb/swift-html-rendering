//
//  Imagesizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the sizes attribute on an image element
    @discardableResult
    package func sizes(
        _ value: ImageSizes?
    ) -> HTML._Attributes<Self> {
        self.attribute(ImageSizes.attribute, value?.description)
    }
}
