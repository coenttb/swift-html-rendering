//
//  ShadowRootDelegatesFocus.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the shadowrootdelegatesfocus attribute on an element
    @discardableResult
    package func shadowRootDelegatesFocus(
        _ value: ShadowRootDelegatesFocus?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ShadowRootDelegatesFocus.attribute, value?.description)
    }
}
