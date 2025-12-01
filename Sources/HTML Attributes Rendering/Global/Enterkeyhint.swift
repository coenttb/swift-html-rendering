///
/// Enterkeyhint.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the Enter key label/action hint for virtual keyboards
    @discardableResult
    public func enterkeyhint(
        _ value: Enterkeyhint
    ) -> HTML._Attributes<Self> {
        self.attribute(Enterkeyhint.attribute, value.description)
    }
}
