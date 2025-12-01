///
/// Autocapitalize.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    @discardableResult
    public func autocapitalize(
        _ value: Autocapitalize?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocapitalize.attribute, value?.description)
    }
}
