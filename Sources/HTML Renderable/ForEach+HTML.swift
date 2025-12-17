//
//  ForEach+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 17/12/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

// Extend the ForEach type from Rendering module to conform to HTML.View
// Note: ForEach is a top-level type exported from the Rendering module.
// Users can access it as ForEach<Content> directly.
extension ForEach: HTML.View where Content: HTML.View {}
