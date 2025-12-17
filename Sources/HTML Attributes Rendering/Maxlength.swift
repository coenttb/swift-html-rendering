///
/// Maxlength.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func maxlength(
        _ value: Maxlength?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Maxlength.attribute, value?.description)
    }
}
