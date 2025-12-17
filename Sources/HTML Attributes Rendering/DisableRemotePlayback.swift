//
//  DisableRemotePlayback.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func disableRemotePlayback(
        _ value: DisableRemotePlayback?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(DisableRemotePlayback.attribute, value?.description)
    }
}
