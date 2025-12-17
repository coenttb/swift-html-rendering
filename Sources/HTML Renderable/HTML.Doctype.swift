//
//  WHATWG_HTML.Doctype.swift
//
//
//  Created by Point-Free, Inc
//

import Rendering
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// Represents the HTML doctype declaration.
    ///
    /// The `WHATWG_HTML.Doctype` struct provides a convenient way to add the HTML5 doctype
    /// declaration to an HTML document. This declaration is required for proper
    /// rendering and standards compliance in web browsers.
    ///
    /// Example:
    /// ```swift
    /// var body: some WHATWG_HTML.View {
    ///     WHATWG_HTML.Doctype()
    ///     html {
    ///         // HTML content...
    ///     }
    /// }
    /// ```
    ///
    /// - Note: In HTML5, the doctype is simplified to `<!doctype html>` compared
    ///   to the more complex doctypes in earlier HTML versions.
    public struct Doctype: WHATWG_HTML.View {
        /// Creates a new doctype declaration.
        public init() {}

        /// The body of the doctype declaration, which renders as raw WHATWG_HTML.
        public var body: some WHATWG_HTML.View {
            WHATWG_HTML.Raw([UInt8].html.tag.doctype)
        }
    }
}
