///
/// MarginWidth.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func marginWidth(
        _ value: MarginWidth?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(MarginWidth.attribute, value?.description)
    }
}
