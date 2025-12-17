///
/// Elementtiming.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    @discardableResult
    package func elementtiming(
        _ value: Elementtiming?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Elementtiming.attribute, value?.description)
    }

    /// Adds element timing with a categorized identifier
    @discardableResult
    package func elementtiming(
        category: Elementtiming.Category,
        name: String,
        separator: String = "-"
    ) -> WHATWG_HTML._Attributes<Self> {
        self.elementtiming(Elementtiming(category: category, name: name, separator: separator))
    }
}
