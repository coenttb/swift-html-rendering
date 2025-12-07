//
//  ElementRendering.swift
//  swift-html-rendering
//
//  Shared rendering logic for HTML elements.
//  Used by both HTML.Element (typed) and HTML.DynamicElement (dynamic).
//

import INCITS_4_1986
import OrderedCollections
import Renderable
public import WHATWG_HTML_Shared

// MARK: - Element Rendering Info

/// Captures element metadata needed for rendering decisions.
///
/// This struct abstracts the difference between compile-time typed elements
/// and runtime dynamic elements, enabling shared rendering logic.
@_spi(Internal)
public struct ElementRenderingInfo: Sendable {
    let tagName: String
    let isBlock: Bool
    let isVoid: Bool
    let isPreElement: Bool

    init(
        tagName: String,
        isBlock: Bool,
        isVoid: Bool,
        isPreElement: Bool
    ) {
        self.tagName = tagName
        self.isBlock = isBlock
        self.isVoid = isVoid
        self.isPreElement = isPreElement
    }

    /// Creates rendering info for a compile-time typed element.
    public static func forTag<Tag: WHATWG_HTML.Element.`Protocol`>(
        _: Tag.Type,
        isPrettyPrinting: Bool
    ) -> ElementRenderingInfo {
        ElementRenderingInfo(
            tagName: Tag.tag,
            isBlock: isPrettyPrinting && !Tag.categories.contains(.phrasing),
            isVoid: Tag.content.model == .nothing,
            isPreElement: Tag.tag == "pre"
        )
    }

    /// Creates rendering info for a dynamic string-based element.
    ///
    /// Uses WHATWG_HTML runtime lookup for element properties.
    public static func forTagName(
        _ tagName: String,
        isPrettyPrinting: Bool
    ) -> ElementRenderingInfo {
        let categories = WHATWG_HTML.Element.Content.categories(for: tagName)
        return ElementRenderingInfo(
            tagName: tagName,
            isBlock: isPrettyPrinting && !categories.contains(.phrasing),
            isVoid: WHATWG_HTML.Element.Content.model(for: tagName) == .nothing,
            isPreElement: tagName == "pre"
        )
    }
}

// MARK: - Saved Context

/// Saved rendering context state for restoration after content rendering.
@_spi(Internal)
public struct SavedContext: Sendable {
    let attributes: OrderedDictionary<String, String>
    let indentation: [UInt8]

    init(attributes: OrderedDictionary<String, String>, indentation: [UInt8]) {
        self.attributes = attributes
        self.indentation = indentation
    }
}

// MARK: - Element Rendering Functions

/// Shared rendering logic for HTML elements.
///
/// This enum provides static functions that handle the common rendering
/// operations, eliminating code duplication between typed and dynamic elements.
@_spi(Internal)
public enum ElementRendering {

    // MARK: - Sync Rendering

    /// Renders the opening tag with attributes into a buffer.
    public static func renderOpenTag<Buffer: RangeReplaceableCollection<UInt8>>(
        info: ElementRenderingInfo,
        context: inout HTML.Context,
        into buffer: inout Buffer
    ) {
        // Add newline and indentation for block elements
        if info.isBlock {
            buffer.append(contentsOf: context.configuration.newline)
            buffer.append(contentsOf: context.currentIndentation)
        }

        // Write opening tag
        buffer.append(.ascii.lessThanSign)
        buffer.append(contentsOf: info.tagName.utf8)

        // Add attributes - single-pass escaping without intermediate allocation
        for (name, value) in context.attributes {
            buffer.append(.ascii.space)
            buffer.append(contentsOf: name.utf8)
            if !value.isEmpty {
                buffer.append(.ascii.equalsSign)
                buffer.append(.ascii.dquote)

                // Single-pass: iterate directly over UTF-8 view, escape as needed
                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        buffer.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        buffer.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        buffer.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        buffer.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        buffer.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        buffer.append(byte)
                    }
                }

                buffer.append(.ascii.dquote)
            }
        }
        buffer.append(.ascii.greaterThanSign)
    }

    /// Renders the closing tag into a buffer.
    public static func renderCloseTag<Buffer: RangeReplaceableCollection<UInt8>>(
        info: ElementRenderingInfo,
        context: inout HTML.Context,
        into buffer: inout Buffer
    ) {
        // Void elements don't have closing tags
        guard !info.isVoid else { return }

        if info.isBlock && !info.isPreElement {
            buffer.append(contentsOf: context.configuration.newline)
            buffer.append(contentsOf: context.currentIndentation)
        }

        buffer.append(.ascii.lessThanSign)
        buffer.append(.ascii.slant)
        buffer.append(contentsOf: info.tagName.utf8)
        buffer.append(.ascii.greaterThanSign)
    }

    /// Saves current context state and prepares for content rendering.
    public static func prepareContentContext(
        info: ElementRenderingInfo,
        context: inout HTML.Context
    ) -> SavedContext {
        let saved = SavedContext(
            attributes: context.attributes,
            indentation: context.currentIndentation
        )
        context.attributes.removeAll()
        if info.isBlock && !info.isPreElement {
            context.currentIndentation += context.configuration.indentation
        }
        return saved
    }

    /// Restores context state after content rendering.
    public static func restoreContext(
        _ saved: SavedContext,
        context: inout HTML.Context
    ) {
        context.attributes = saved.attributes
        context.currentIndentation = saved.indentation
    }

    // MARK: - Async Rendering Helpers

    /// Builds the opening tag bytes for async streaming.
    ///
    /// Returns a byte array that can be written to an async stream.
    public static func buildOpenTag(
        info: ElementRenderingInfo,
        context: inout HTML.Context
    ) -> [UInt8] {
        var openTag: [UInt8] = []

        if info.isBlock {
            openTag.append(contentsOf: context.configuration.newline)
            openTag.append(contentsOf: context.currentIndentation)
        }

        openTag.append(.ascii.lessThanSign)
        openTag.append(contentsOf: info.tagName.utf8)

        // Add attributes
        for (name, value) in context.attributes {
            openTag.append(.ascii.space)
            openTag.append(contentsOf: name.utf8)
            if !value.isEmpty {
                openTag.append(.ascii.equalsSign)
                openTag.append(.ascii.dquote)

                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        openTag.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        openTag.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        openTag.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        openTag.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        openTag.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        openTag.append(byte)
                    }
                }

                openTag.append(.ascii.dquote)
            }
        }
        openTag.append(.ascii.greaterThanSign)

        return openTag
    }

    /// Builds the closing tag bytes for async streaming.
    ///
    /// Returns nil for void elements, otherwise returns the closing tag bytes.
    public static func buildCloseTag(
        info: ElementRenderingInfo,
        context: inout HTML.Context
    ) -> [UInt8]? {
        guard !info.isVoid else { return nil }

        var closeTag: [UInt8] = []
        if info.isBlock && !info.isPreElement {
            closeTag.append(contentsOf: context.configuration.newline)
            closeTag.append(contentsOf: context.currentIndentation)
        }
        closeTag.append(.ascii.lessThanSign)
        closeTag.append(.ascii.slant)
        closeTag.append(contentsOf: info.tagName.utf8)
        closeTag.append(.ascii.greaterThanSign)

        return closeTag
    }
}
