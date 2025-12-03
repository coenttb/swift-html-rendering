//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

extension HTML_Standard_Elements.Anchor {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element(for: Self.self) { content() }
            .attributionSrc(self.attributionsrc)
            .download(self.download)
            .href(self.href)
            .hreflang(self.hreflang)
            .ping(self.ping)
            .referrerPolicy(self.referrerpolicy)
            .rel(self.rel)
            .target(self.target)
    }
}
