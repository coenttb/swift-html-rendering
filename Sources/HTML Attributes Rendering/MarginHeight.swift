///
/// MarginHeight.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func marginHeight(
        _ value: MarginHeight?
    ) -> HTML._Attributes<Self> {
        self.attribute(MarginHeight.attribute, value?.description)
    }
}
