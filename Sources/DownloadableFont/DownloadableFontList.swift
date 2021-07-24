//
//  File.swift
//  
//
//  Created by Simon Lee on 7/24/21.
//

import Foundation

public struct DownloadableFontList {
    public let fontFamilies: [DownloadableFontFamily]
}

public struct DownloadableFontFamily {
    public let name: String
    public let variants: [DownloadableFont]
}

public struct DownloadableFont: Hashable {
    public let family: String
    public let variant: String
    public let downloadURL: URL
}
