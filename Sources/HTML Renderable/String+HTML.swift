//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import Rendering

extension String: @retroactive Renderable {
    public typealias Content = HTML.Text
    public typealias Context = HTML.Context
    public typealias Output = UInt8
}

extension String: HTML.View {
    public var body: HTML.Text {
        HTML.Text(self)
    }
}
