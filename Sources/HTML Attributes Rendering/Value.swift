///
/// Value.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the value attribute on an element
    @discardableResult
    package func value<Element: CustomStringConvertible>(
        _ value: Value<Element>?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Value<Element>.attribute, value?.description)
    }
}
