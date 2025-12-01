//
//  HTML.InlineStyle.Protocol.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import Renderable

// Protocol to enable type erasure for HTML.InlineStyle
protocol HTMLInlineStyleProtocol {
    func extractStyles() -> [HTML.Style]
    func extractContent() -> any HTML.View
}
