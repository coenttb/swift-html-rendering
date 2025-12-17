//
//  Fetchpriority.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the fetchpriority attribute on an element
    @discardableResult
    package func fetchPriority(
        _ value: FetchPriority?
    ) -> HTML._Attributes<Self> {
        self.attribute(FetchPriority.attribute, value?.description)
    }
}
