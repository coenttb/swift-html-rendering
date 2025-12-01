//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func srcLang(
        _ value: SrcLang?
    ) -> HTML._Attributes<Self> {
        self.attribute(SrcLang.attribute, value?.description)
    }
}
