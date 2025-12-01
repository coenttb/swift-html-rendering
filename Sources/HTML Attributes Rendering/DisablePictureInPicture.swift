//
//  DisablePictureInPicture.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the disablepictureinpicture attribute on an element
    @discardableResult
    package func disablePictureInPicture(
        _ value: DisablePictureInPicture?
    ) -> HTML._Attributes<Self> {
        self.attribute(DisablePictureInPicture.attribute, value?.description)
    }
}
