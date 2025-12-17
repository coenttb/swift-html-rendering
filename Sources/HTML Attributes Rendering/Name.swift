///
/// Name.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: Name?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Name.attribute, value?.description)
    }
}

extension WHATWG_HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: MetaName?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(MetaName.attribute, value?.description)
    }
}
