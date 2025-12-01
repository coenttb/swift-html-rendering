///
/// Slot.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the slot attribute with a slot name
    @discardableResult
    public func slot(
        _ name: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Slot.attribute, name)
    }

    /// Sets the slot attribute using a Slot struct
    @discardableResult
    public func slot(
        _ attribute: Slot
    ) -> HTML._Attributes<Self> {
        self.attribute(Slot.attribute, attribute.description)
    }
}
