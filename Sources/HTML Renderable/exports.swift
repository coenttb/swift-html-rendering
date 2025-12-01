//
//  exports.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

@_exported import OrderedCollections
@_exported import Renderable
@_exported import INCITS_4_1986

// Convenience typealiases for migration from pointfree-html
public typealias HTMLInlineStyle<Content: HTML.View> = HTML.InlineStyle<Content>
