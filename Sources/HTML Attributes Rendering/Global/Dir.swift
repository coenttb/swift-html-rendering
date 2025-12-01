///
/// Dir.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the text direction for an HTML element
    @discardableResult
    public func dir(
        _ value: Dir
    ) -> HTML._Attributes<Self> {
        self.attribute(Dir.attribute, value.description)
    }
}
