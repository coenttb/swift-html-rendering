///
/// Width.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the width attribute on an element
    @discardableResult
    package func width(
        _ value: Width?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Width.attribute, value?.description)
    }
}
