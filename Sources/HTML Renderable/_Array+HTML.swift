//
//  _Array+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

// Extend the _Array type from Rendering module to conform to WHATWG_HTML.View
// Note: _Array is a top-level type exported from the Rendering module.
// Users can access it as _Array<Content> directly, not through WHATWG_HTML._Array.
extension _Array: WHATWG_HTML.View where Element: WHATWG_HTML.View {}
