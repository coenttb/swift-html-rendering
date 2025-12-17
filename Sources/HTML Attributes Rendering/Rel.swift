///
/// Rel.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the rel attribute on an element
    @discardableResult
    package func rel(
        _ value: Rel?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Rel.attribute, value?.description)
    }
}

// extension WHATWG_HTML.View {
//    /// Sets the rel attribute with multiple link type values
//    @discardableResult
//    package func rel(
//        _ values: Rel.LinkType...
//    ) -> WHATWG_HTML._Attributes<Self> {
//        self.rel(Rel(values))
//    }
// }
