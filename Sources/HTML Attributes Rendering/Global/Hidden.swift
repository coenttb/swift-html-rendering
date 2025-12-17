///
/// Hidden.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the hidden attribute with a specific value
    @discardableResult
    public func hidden(
        _ hidden: Hidden
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }

    /// Sets the hidden attribute without a value (equivalent to hidden="")
    @discardableResult
    public func hidden() -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }
}
