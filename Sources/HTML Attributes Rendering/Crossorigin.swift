///
/// Crossorigin.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    @discardableResult
    package func crossorigin(
        _ value: Crossorigin?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Crossorigin.attribute, value?.description)
    }

    //    @discardableResult
    //    package func crossorigin(
    //        _ policy: CrosPolicy
    //    ) -> WHATWG_HTML._Attributes<Self> {
    //        self.crossorigin(Crossorigin(policy))
    //    }
}
