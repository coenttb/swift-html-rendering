//
//  ObjectData.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the data attribute on an object element
    @discardableResult
    package func data(
        _ value: ObjectData?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(ObjectData.attribute, value?.description)
    }
}
