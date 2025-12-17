//
//  ReferrerPolicy.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the referrerpolicy attribute on an element
    @discardableResult
    package func referrerPolicy(
        _ value: ReferrerPolicy?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ReferrerPolicy.attribute, value?.description)
    }
}
