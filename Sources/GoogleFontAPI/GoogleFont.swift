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
    public let files: [String: URL]

    public enum CodingKeys: String, CodingKey {
        case family = "family"
        case variants = "variants"
        case files = "files"
    }
}

public protocol InstallableFont {
    var postScriptName: String { get }
    var fontData: Data { get }
}
