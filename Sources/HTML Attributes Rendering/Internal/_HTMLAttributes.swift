//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    @WHATWG_HTML.Builder
    package func attribute(
        _ value: String,
        _ condition: @autoclosure () -> Bool?
    ) -> some WHATWG_HTML.View {
        let conditionResult = condition()
        if conditionResult == true {
            self.attribute(value, "")
        } else {
            self.attribute("", String?.none)
        }
    }

    @WHATWG_HTML.Builder
    package func attribute<Attribute: WHATWG_HTML.BooleanAttribute>(
        boolean value: Attribute?
    ) -> some WHATWG_HTML.View {
        self.attribute(Attribute.attribute, value == true)
    }
}

extension WHATWG_HTML._Attributes {
    package func attribute(
        _ name: String,
        _ value: (some CustomStringConvertible)? = ""
    ) -> WHATWG_HTML._Attributes<Content> {
        self.attribute(name, value?.description)
    }
}
