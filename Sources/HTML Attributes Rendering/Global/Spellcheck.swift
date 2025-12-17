///
/// Spellcheck.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the spellcheck attribute using a Spellcheck enum value
    @discardableResult
    package func spellcheck(
        _ attribute: Spellcheck?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Spellcheck.attribute, attribute?.description)
    }
}
