//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func srcLang(
        _ value: SrcLang?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(SrcLang.attribute, value?.description)
    }
}
