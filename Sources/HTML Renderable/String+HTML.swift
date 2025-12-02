//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import Renderable

extension String: @retroactive Renderable {}
extension String: HTML.View {
    public var body: HTML.Text {
        HTML.Text(self)
    }
}
