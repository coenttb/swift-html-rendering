///
/// For.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the for attribute on an element
    @discardableResult
    package func `for`(
        _ value: For?
    ) -> HTML._Attributes<Self> {
        self.attribute(For.attribute, value?.description)
    }
}
