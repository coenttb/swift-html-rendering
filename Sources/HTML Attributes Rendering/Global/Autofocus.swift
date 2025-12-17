///
/// Autofocus.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    public var autofocus: WHATWG_HTML._Attributes<Self> {
        self.attribute(Autofocus.attribute)
    }
}

extension WHATWG_HTML.View {
    @discardableResult
    public func autofocus(
        _ value: Autofocus?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
