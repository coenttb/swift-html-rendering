///
/// Readonly.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Adds the readonly attribute to the element
    package var readonly: WHATWG_HTML._Attributes<Self> {
        self.attribute(Readonly.attribute)
    }

    /// Conditionally adds the readonly attribute to the element
    @WHATWG_HTML.Builder
    package func readonly(
        _ value: Readonly?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
