///
/// FrameBorder.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func frameBorder(
        _ value: FrameBorder?
    ) -> HTML._Attributes<Self> {
        self.attribute(FrameBorder.attribute, value?.description)
    }
}
