///
/// Method.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add a method attribute to specify the HTTP method for form submission
    @discardableResult
    package func method(
        _ value: Method?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Method.attribute, value?.description)
    }
}
