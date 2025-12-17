//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_Obsolete.Param: WHATWG_HTML.View {
    public var body: some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { WHATWG_HTML.Empty() }
            .name(self.name)
            .value(self.value)
    }
}
