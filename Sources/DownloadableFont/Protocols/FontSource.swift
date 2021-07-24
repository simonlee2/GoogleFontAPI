//
//  File.swift
//  
//
//  Created by Simon Lee on 7/24/21.
//

import Foundation

public protocol FontSource {
    var fontList: DownloadableFontList? { get set }
    func fetchFontList(completion: @escaping () -> Void)
}
