///
/// Nonce.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the nonce attribute using a Nonce struct
    @discardableResult
    public func nonce(
        _ attribute: Nonce?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Nonce.attribute, attribute?.description)
    }
}

// extension WHATWG_HTML.View {
//    /// Sets the nonce attribute with a newly generated secure nonce
//    @discardableResult
//    public func nonce() -> WHATWG_HTML._Attributes<Self> {
//        self.nonce(Nonce.generate())
//    }
// }
