//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add an href attribute to specify a hyperlink destination
    @discardableResult
    public func href(
        _ value: Href?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Href.attribute, value?.description)
    }
}
