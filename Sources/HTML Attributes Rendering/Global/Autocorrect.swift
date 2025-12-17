///
/// Autocorrect.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocorrect(
        _ value: Autocorrect?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocorrect.attribute, value?.description)
    }
}
