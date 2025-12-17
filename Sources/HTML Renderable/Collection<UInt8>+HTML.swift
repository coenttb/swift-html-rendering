//
//  RangeReplaceableCollection+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension Collection<UInt8> {
    public static var html: HTML.Type {
        HTML.self
    }
}
