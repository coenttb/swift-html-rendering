//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension String: @retroactive Renderable {
    public typealias Content = WHATWG_HTML.Text
    public typealias Context = WHATWG_HTML.Context
    public typealias Output = UInt8
}

extension String: WHATWG_HTML.View {
    public var body: WHATWG_HTML.Text {
        WHATWG_HTML.Text(self)
    }
}
