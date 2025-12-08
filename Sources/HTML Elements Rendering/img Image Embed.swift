//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.Image: HTML.View {
    public var body: some HTML.View {
        HTML.Element(for: Self.self)
            .src(self.src)
            .alt(self.alt)
            .loading(self.loading)
    }
}
