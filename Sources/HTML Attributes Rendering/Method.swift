///
/// Method.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Add a method attribute to specify the HTTP method for form submission
    @discardableResult
    package func method(
        _ value: Method?
    ) -> HTML._Attributes<Self> {
        self.attribute(Method.attribute, value?.description)
    }
}
