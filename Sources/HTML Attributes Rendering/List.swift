///
/// List.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the list attribute on an element
    @discardableResult
    package func list(
        _ value: List?
    ) -> HTML._Attributes<Self> {
        self.attribute(List.attribute, value?.description)
    }
}
