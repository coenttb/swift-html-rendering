///
/// Itemtype.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the itemtype attribute with a vocabulary URL
    @discardableResult
    public func itemtype(
        _ value: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, value)
    }

    /// Sets the itemtype attribute with multiple vocabulary URLs
    @discardableResult
    public func itemtype(
        _ values: [String]
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, values.joined(separator: " "))
    }

    /// Sets the itemtype attribute with multiple vocabulary URLs as variadic parameters
    @discardableResult
    public func itemtype(
        _ values: String...
    ) -> WHATWG_HTML._Attributes<Self> {
        self.itemtype(values)
    }

    /// Sets the itemtype attribute using an Itemtype struct
    @discardableResult
    public func itemtype(
        _ attribute: Itemtype
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, attribute.description)
    }

    /// Sets the itemtype attribute with a schema.org type
    @discardableResult
    public func itemtype(
        schemaOrg type: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.itemtype(Itemtype(schemaOrg: type))
    }
}
