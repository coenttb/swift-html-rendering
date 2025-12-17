///
/// Inert.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the inert attribute, making the element and all its descendants non-interactive
    public var inert: WHATWG_HTML._Attributes<Self> {
        self.attribute(Inert.attribute)
    }

    /// Conditionally adds the disabled attribute to the element
    @WHATWG_HTML.Builder
    package func inert(_ value: Inert?) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
