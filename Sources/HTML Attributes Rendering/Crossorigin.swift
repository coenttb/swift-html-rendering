///
/// Crossorigin.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    @discardableResult
    package func crossorigin(
        _ value: Crossorigin?
    ) -> HTML._Attributes<Self> {
        self.attribute(Crossorigin.attribute, value?.description)
    }

    //    @discardableResult
    //    package func crossorigin(
    //        _ policy: CrosPolicy
    //    ) -> HTML._Attributes<Self> {
    //        self.crossorigin(Crossorigin(policy))
    //    }
}
