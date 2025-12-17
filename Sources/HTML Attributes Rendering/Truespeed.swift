//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Adds the truespeed attribute to the element
    package var truespeed: WHATWG_HTML._Attributes<Self> {
        self.attribute(Truespeed.attribute)
    }

    /// Conditionally adds the truespeed attribute to the element
    @WHATWG_HTML.Builder
    package func truespeed(
        _ value: Truespeed?
    ) -> some WHATWG_HTML.View {
        self.attribute(boolean: value)
    }
}
