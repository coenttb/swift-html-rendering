//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.Frame {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element(for: Self.self) { content() }
            .src(self.src)
            .name(self.name)
            .noResize(self.noresize)
            .scrolling(self.scrolling)
            .marginHeight(self.marginheight)
            .marginWidth(self.marginwidth)
            .frameBorder(self.frameborder)
    }
}
