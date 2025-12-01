//
//  ControlsList.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the controlslist attribute on an element
    @discardableResult
    package func controlsList(
        _ value: ControlsList?
    ) -> HTML._Attributes<Self> {
        self.attribute(ControlsList.attribute, value?.description)
    }
}
