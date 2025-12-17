///
/// Enterkeyhint.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the Enter key label/action hint for virtual keyboards
    @discardableResult
    public func enterkeyhint(
        _ value: Enterkeyhint
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Enterkeyhint.attribute, value.description)
    }
}
