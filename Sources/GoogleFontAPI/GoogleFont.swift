//
//  GoogleFont.swift
//  
//
//  Created by Simon Lee on 7/24/21.
//
import Foundation

public struct GoogleFontResponse: Codable {
    public let kind: String
    public let items: [GoogleFont]
}

public struct GoogleFont: Codable {
    public let family: String
    public let variants: [String]
    public let subsets: [String]
    public let version: String
    public let lastModified: String
    public let files: [String: URL]
    public let category: String
    public let kind: String

    public enum CodingKeys: String, CodingKey {
        case family = "family"
        case variants = "variants"
        case subsets = "subsets"
        case version = "version"
        case lastModified = "lastModified"
        case files = "files"
        case category = "category"
        case kind = "kind"
    }
}
