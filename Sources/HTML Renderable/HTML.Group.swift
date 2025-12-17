//
//  Group+WHATWG_HTML.swift
//
//
//  Created by Point-Free, Inc
//

public import Rendering
public import WHATWG_HTML_Shared

public typealias RenderingGroup = Group

/// A container that groups multiple HTML elements together without adding a wrapper element.
///
/// `Group` allows you to group a collection of HTML elements together
/// without introducing an additional HTML element in the rendered output.
/// This is useful for creating reusable components that contain multiple
/// elements but don't need a container element.
///
/// Example:
/// ```swift
/// func navigation() -> some WHATWG_HTML.View {
///     Group {
///         a().href("/home") { "Home" }
///         a().href("/about") { "About" }
///         a().href("/contact") { "Contact" }
///     }
/// }
///
/// var body: some WHATWG_HTML.View {
///     nav {
///         navigation()
///     }
/// }
/// ```
///
/// This would render as:
/// ```html
/// <nav>
///     <a href="/home">Home</a>
///     <a href="/about">About</a>
///     <a href="/contact">Contact</a>
/// </nav>
/// ```

extension WHATWG_HTML {
    public typealias Group = RenderingGroup
}

extension WHATWG_HTML.Group: WHATWG_HTML.View where Content: WHATWG_HTML.View {}
