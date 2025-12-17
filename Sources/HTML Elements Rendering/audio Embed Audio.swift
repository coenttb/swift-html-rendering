//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Audio {
    public func callAsFunction(
        @WHATWG_HTML.Builder _ content: () -> some WHATWG_HTML.View
    ) -> some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .controls(self.controls)
            .autoplay(self.autoplay)
            .loop(self.loop)
            .muted(self.muted)
            //            .preload(self.preload)
            .crossorigin(self.crossorigin)
            //            .controlslist(self.controlslist)
            .disableRemotePlayback(self.disableremoteplayback)
    }
}
