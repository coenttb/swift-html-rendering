///
/// Virtualkeyboardpolicy.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the virtualkeyboardpolicy attribute with a policy value
    @discardableResult
    public func virtualkeyboardpolicy(
        _ policy: Virtualkeyboardpolicy
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Virtualkeyboardpolicy.attribute, policy.description)
    }

    /// Sets the virtualkeyboardpolicy attribute to auto
    @discardableResult
    public func autoKeyboard() -> WHATWG_HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.auto)
    }

    /// Sets the virtualkeyboardpolicy attribute to manual
    @discardableResult
    public func manualKeyboard() -> WHATWG_HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.manual)
    }
}
