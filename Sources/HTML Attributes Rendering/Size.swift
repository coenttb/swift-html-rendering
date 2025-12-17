///
/// Size.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the size attribute on an element
    @discardableResult
    package func size(
        _ value: Size?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Size.attribute, value?.description)
    }
}
