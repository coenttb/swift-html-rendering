///
/// Dirname.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    @discardableResult
    package func dirname(
        _ value: Dirname?
    ) -> HTML._Attributes<Self> {
        self.attribute(Dirname.attribute, value?.description)
    }
}
