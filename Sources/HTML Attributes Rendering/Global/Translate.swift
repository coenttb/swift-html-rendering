///
/// Translate.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the translate attribute using a Translate enum value
    @discardableResult
    public func translate(
        _ attribute: Translate
    ) -> HTML._Attributes<Self> {
        self.attribute(Translate.attribute, attribute.description)
    }
}
