//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

// extension HTMLVoidElement where Self: HTML_Standard_Elements.HTMLElement & HTML.View {
//    public var body: HTML.Element.Tag<HTML.Empty> {
//        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
//    }
// }

// WORKAROUND because Input and BR fail to compile when called as BR(). With this function BR()() works
// TODO: Re-enable when WHATWG_HTML.VoidElement protocol is available
// extension WHATWG_HTML.VoidElement where Self: HTML_Standard_Elements.WHATWG_HTML.Element & HTML.View {
//     public func callAsFunction() -> some HTML.View {
//         self
//     }
// }
