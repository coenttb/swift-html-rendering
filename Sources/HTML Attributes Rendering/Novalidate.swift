///
/// Novalidate.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add the novalidate attribute to disable browser validation for a form
    package var novalidate: WHATWG_HTML._Attributes<Self> {
        self.attribute(Novalidate.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @WHATWG_HTML.Builder
    package func novalidate(
        _ value: Novalidate?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
