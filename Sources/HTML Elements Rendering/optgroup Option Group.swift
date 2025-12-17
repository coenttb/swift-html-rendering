//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.OptionGroup {
    public func callAsFunction(
        @WHATWG_HTML.Builder _ content: () -> some WHATWG_HTML.View
    ) -> some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
            .disabled(self.disabled)
            .label(self.label)
    }
}
