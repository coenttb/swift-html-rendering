//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import HTML_Renderable
import Rendering_TestSupport
public import WHATWG_HTML_Shared

extension Snapshotting where Value: WHATWG_HTML.DocumentProtocol, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: WHATWG_HTML.Context.Configuration = .pretty
    ) -> Self {
        Snapshotting<String, String>.lines.pullback { value in
            WHATWG_HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}

extension Snapshotting where Value: WHATWG_HTML.View, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: WHATWG_HTML.Context.Configuration = .pretty
    ) -> Self {
        Snapshotting<String, String>.lines.pullback { value in
            WHATWG_HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}
