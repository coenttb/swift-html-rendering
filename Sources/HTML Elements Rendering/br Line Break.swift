//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.BR: WHATWG_HTML.View {
    public var body: WHATWG_HTML.Element.Tag<WHATWG_HTML.Empty> {
        WHATWG_HTML.Element.Tag(for: Self.self) { WHATWG_HTML.Empty() }
    }
}
