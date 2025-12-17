///
/// Multiple.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Adds the multiple attribute to the element
    package var multiple: WHATWG_HTML._Attributes<Self> {
        self.attribute(Multiple.attribute)
    }

    /// Conditionally adds the multiple attribute to the element
    @WHATWG_HTML.Builder
    package func multiple(_ value: Multiple?) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
