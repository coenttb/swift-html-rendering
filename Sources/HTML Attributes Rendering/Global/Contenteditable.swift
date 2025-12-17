///
/// Contenteditable.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    @discardableResult
    public func contenteditable(
        _ value: Contenteditable
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Contenteditable.attribute, value.description)
    }

    public var contenteditable: WHATWG_HTML._Attributes<Self> {
        self.contenteditable(.true)
    }
}
