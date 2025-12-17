/////
///// Label.swift
///// swift-html
/////
///// Represents the HTML label element for form controls.
/////
///// Created by Coen ten Thije Boonkkamp on 04/04/2025.
/////
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Label {
    public func callAsFunction(
        @WHATWG_HTML.Builder _ content: () -> some WHATWG_HTML.View
    ) -> some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
            .for(self.for)
    }
}
