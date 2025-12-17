///
/// Min.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the min attribute on an element
    @discardableResult
    package func min(
        _ value: Min?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Min.attribute, value?.description)
    }
}

// extension WHATWG_HTML.View {
//    /// Sets the min attribute with a date value and format
//    @discardableResult
//    package func min(
//        date: Date,
//        format: Min.DateFormat = .fullDate
//    ) -> WHATWG_HTML._Attributes<Self> {
//        self.min(Min(date: date, format: format))
//    }
// }
