//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering

// extension HTMLVoidElement where Self: HTML_Standard_Elements.HTMLElement & HTML.View {
//    public var body: HTML.Element<HTML.Empty> {
//        HTML.Element(tag: Self.tag) { HTML.Empty() }
//    }
// }

// WORKAROUND because Input and BR fail to compile when called as BR(). With this function BR()() works
extension HTMLVoidElement where Self: HTML_Standard_Elements.HTMLElement & HTML.View {
    public func callAsFunction() -> some HTML.View {
        self
    }
}
