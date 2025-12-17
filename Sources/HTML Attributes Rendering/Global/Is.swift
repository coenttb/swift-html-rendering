///
/// Is.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the is attribute to extend a standard HTML element with custom behavior
    @discardableResult
    public func `is`(
        _ value: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Is.attribute, Is(value).description)
    }

    /// Sets the is attribute using an Is struct
    @discardableResult
    public func `is`(
        _ value: Is
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Is.attribute, value.description)
    }
}
