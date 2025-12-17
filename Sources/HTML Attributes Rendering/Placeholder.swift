///
/// Placeholder.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the placeholder attribute on an element
    @discardableResult
    package func placeholder(
        _ value: Placeholder?
    ) -> HTML._Attributes<Self> {
        self.attribute(Placeholder.attribute, value?.description)
    }
}
