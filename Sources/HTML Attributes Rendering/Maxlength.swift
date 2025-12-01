///
/// Maxlength.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func maxlength(
        _ value: Maxlength?
    ) -> HTML._Attributes<Self> {
        self.attribute(Maxlength.attribute, value?.description)
    }
}
