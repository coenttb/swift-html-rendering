//
//  Optional+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Renderable

/// Allows optional values to be used as HTML elements.
///
/// This conformance allows for convenient handling of optional HTML content,
/// where `nil` values simply render nothing.
extension Optional: HTML.View where Wrapped: HTML.View {}
