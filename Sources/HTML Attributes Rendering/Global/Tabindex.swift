///
/// Tabindex.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the tabindex attribute with an integer value
    @discardableResult
    public func tabindex(
        _ value: Int
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, String(value))
    }

    /// Sets the tabindex attribute using a Tabindex struct
    @discardableResult
    public func tabindex(
        _ attribute: Tabindex
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, attribute.description)
    }

    /// Makes the element not focusable via keyboard but focusable programmatically
    @discardableResult
    public func notTabbable() -> WHATWG_HTML._Attributes<Self> {
        self.tabindex(Tabindex.notTabbable)
    }

    /// Makes the element focusable in the natural document order
    @discardableResult
    public func tabbableInDocumentOrder() -> WHATWG_HTML._Attributes<Self> {
        self.tabindex(Tabindex.inDocumentOrder)
    }
}
