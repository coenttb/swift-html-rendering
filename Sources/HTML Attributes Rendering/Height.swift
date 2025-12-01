///
/// Height.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the height attribute on an element
    @discardableResult
    package func height(
        _ value: Height?
    ) -> HTML._Attributes<Self> {
        self.attribute(Height.attribute, value?.description)
    }
}
