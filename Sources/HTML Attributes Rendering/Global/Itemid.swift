///
/// Itemid.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the itemid attribute with a global identifier
    @discardableResult
    public func itemid(
        _ identifier: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemid.attribute, Itemid(identifier).description)
    }

    /// Sets the itemid attribute using an Itemid struct
    @discardableResult
    public func itemid(
        _ value: Itemid
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemid.attribute, value.description)
    }
}
