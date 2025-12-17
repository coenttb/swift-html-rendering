///
/// Action.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add an action attribute to specify the URL for form submission
    @discardableResult
    public func action(
        _ value: Action?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Action.attribute, value?.description)
    }
}

// extension WHATWG_HTML.View {
//    /// Add an action attribute with a URL object
//    @discardableResult
//    public func action(
//        _ url: URL
//    ) -> WHATWG_HTML._Attributes<Self> {
//        self.action(.init(url))
//    }
// }
