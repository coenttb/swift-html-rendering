///
/// Checked.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Adds the checked attribute to the element
    package var checked: WHATWG_HTML._Attributes<Self> {
        self.attribute(Checked.attribute)
    }

    /// Conditionally adds the checked attribute to the element
    @WHATWG_HTML.Builder
    package func checked(_ value: Checked?) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
