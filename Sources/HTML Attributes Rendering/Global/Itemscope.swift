///
/// Itemscope.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemscope attribute, creating a new microdata item
    public var itemscope: HTML._Attributes<Self> {
        self.attribute(Itemscope.attribute)
    }

    /// Sets the itemscope attribute using an Itemscope enum value
    @discardableResult
    public func itemscope(
        _ value: Itemscope?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
