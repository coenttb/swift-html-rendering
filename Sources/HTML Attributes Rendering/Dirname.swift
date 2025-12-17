///
/// Dirname.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    @discardableResult
    package func dirname(
        _ value: Dirname?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Dirname.attribute, value?.description)
    }
}
