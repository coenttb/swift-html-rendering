//
//  Optional+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

/// Allows optional values to be used as HTML elements.
///
/// This conformance allows for convenient handling of optional HTML content,
/// where `nil` values simply render nothing.
extension Optional: WHATWG_HTML.View where Wrapped: WHATWG_HTML.View {}
