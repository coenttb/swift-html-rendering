///
/// Class.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    @discardableResult
    public func `class`(
        _ value: Class?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Class.attribute, value?.description)
    }
}

// extension WHATWG_HTML.View {
//    @discardableResult
//    public func `class`(
//        _ value: [Class?]
//    ) -> WHATWG_HTML._Attributes<Self> {
//        self.attribute(Class.attribute, Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
//
//    @discardableResult
//    public func `class`(
//        _ value: Class?...
//    ) -> WHATWG_HTML._Attributes<Self> {
//        self.attribute(Class.attribute, Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
// }
