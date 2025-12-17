///
/// Max.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the max attribute on an element
    @discardableResult
    package func max(
        _ value: Max?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Max.attribute, value?.description)
    }

    //    /// Sets the max attribute with a date value and format
    //    @discardableResult
    //    package func max(
    //        date: Date,
    //        format: Max.DateFormat = .fullDate
    //    ) -> WHATWG_HTML._Attributes<Self> {
    //        self.max(Max(date: date, format: format))
    //    }
}
