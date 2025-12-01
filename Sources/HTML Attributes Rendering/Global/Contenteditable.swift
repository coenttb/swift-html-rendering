///
/// Contenteditable.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    @discardableResult
    public func contenteditable(
        _ value: Contenteditable
    ) -> HTML._Attributes<Self> {
        self.attribute(Contenteditable.attribute, value.description)
    }

    public var contenteditable: HTML._Attributes<Self> {
        self.contenteditable(.true)
    }
}
