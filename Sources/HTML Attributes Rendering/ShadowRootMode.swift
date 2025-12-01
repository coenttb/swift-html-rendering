//
//  ShadowRootMode.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the shadowrootmode attribute on an element
    @discardableResult
    package func shadowRootMode(
        _ value: ShadowRootMode?
    ) -> HTML._Attributes<Self> {
        self.attribute(ShadowRootMode.attribute, value?.description)
    }
}
