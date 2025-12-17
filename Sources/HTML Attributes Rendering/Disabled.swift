///
/// Disabled.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Adds the disabled attribute to the element
    package var disabled: WHATWG_HTML._Attributes<Self> {
        self.attribute(Disabled.attribute)
    }

    /// Conditionally adds the disabled attribute to the element
    @WHATWG_HTML.Builder
    package func disabled(_ value: Disabled?) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
