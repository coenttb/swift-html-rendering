//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Frame {
    public func callAsFunction(
        @WHATWG_HTML.Builder _ content: () -> some WHATWG_HTML.View
    ) -> some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .name(self.name)
            .noResize(self.noresize)
            .scrolling(self.scrolling)
            .marginHeight(self.marginheight)
            .marginWidth(self.marginwidth)
            .frameBorder(self.frameborder)
    }
}
