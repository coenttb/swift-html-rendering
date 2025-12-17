///
/// Popover.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the popover attribute as a boolean (equivalent to popover="auto")
    @discardableResult
    public func popover() -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Popover.attribute, "")
    }

    /// Sets the popover attribute with a specific type
    @discardableResult
    public func popover(
        _ type: Popover
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Popover.attribute, type.description)
    }

    /// Sets the popover attribute with a value
    @discardableResult
    public func popover(
        _ value: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Popover.attribute, value)
    }
}

extension WHATWG_HTML.View {
    /// Sets the popovertarget attribute with the ID of the target popover
    @discardableResult
    public func popovertarget(
        _ id: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, id)
    }

    /// Sets the popovertarget attribute using a PopoverTarget struct
    @discardableResult
    public func popovertarget(
        _ attribute: PopoverTarget?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, attribute?.description)
    }
}

extension WHATWG_HTML.View {
    /// Sets the popovertargetaction attribute with an action
    @discardableResult
    public func popovertargetaction(
        _ action: PopoverTargetAction?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(PopoverTargetAction.attribute, action?.description)
    }
}
