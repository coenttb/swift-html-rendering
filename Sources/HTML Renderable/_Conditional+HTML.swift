//
//  _Conditional+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

// Extend the _Conditional type from Rendering module to conform to WHATWG_HTML.View
// Note: _Conditional is a top-level type exported from the Rendering module.
// Users can access it as _Conditional<First, Second> directly, not through WHATWG_HTML._Conditional.
extension _Conditional: WHATWG_HTML.View where First: WHATWG_HTML.View, Second: WHATWG_HTML.View {}
