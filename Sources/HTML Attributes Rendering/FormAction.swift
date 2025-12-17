//
//  FormAction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the formaction attribute on an element
    @discardableResult
    package func formAction(
        _ value: FormAction?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(FormAction.attribute, value?.description)
    }
}
