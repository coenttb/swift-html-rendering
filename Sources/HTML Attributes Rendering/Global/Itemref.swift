///
/// Itemref.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the itemref attribute with a single element ID
    @discardableResult
    public func itemref(
        _ id: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, id)
    }

    /// Sets the itemref attribute with multiple element IDs
    @discardableResult
    public func itemref(
        _ ids: [String]
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, ids.joined(separator: " "))
    }

    /// Sets the itemref attribute with multiple element IDs as variadic parameters
    @discardableResult
    public func itemref(
        _ ids: String...
    ) -> WHATWG_HTML._Attributes<Self> {
        self.itemref(ids)
    }

    /// Sets the itemref attribute using an Itemref struct
    @discardableResult
    public func itemref(
        _ attribute: Itemref
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, attribute.description)
    }
}
