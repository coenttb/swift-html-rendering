//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {
    /// Add an href attribute to specify a hyperlink destination
    @discardableResult
    public func href(
        _ value: Href?
    ) -> HTML._Attributes<Self> {
        self.attribute(Href.attribute, value?.description)
    }
}
