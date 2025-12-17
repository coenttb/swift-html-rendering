///
/// Required.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Adds the required attribute to the element
    package var required: WHATWG_HTML._Attributes<Self> {
        self.attribute(Required.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @WHATWG_HTML.Builder
    package func required(
        _ value: Required?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
