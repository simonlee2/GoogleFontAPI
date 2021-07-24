//
//  GoogleFontSource.swift
//  
//
//  Created by Simon Lee on 7/24/21.
//

import Foundation
import GoogleFontAPI

public class GoogleFontSource: FontSource {
    private let api: GoogleFontAPI

    public var fontList: DownloadableFontList?

    public init(api: GoogleFontAPI) {
        self.api = api
    }

    public func fetchFontList(completion: @escaping () -> Void) {
        api.fetchAllFonts { [weak self] result in
            switch result {
            case .success(let fonts):
                self?.fontList = DownloadableFontList(googleFonts: fonts)
            case .failure(let error):
                debugPrint("Error: \(error)")
            }
        }
    }
}

extension DownloadableFontList {
    init(googleFonts: [GoogleFont]) {
        self.fontFamilies = googleFonts.map { font in
            let variants = font.files.map { variant, url in
                DownloadableFont(
                    family: font.family,
                    variant: variant,
                    downloadURL: url
                )
            }

            return DownloadableFontFamily(
                name: font.family,
                variants: variants
            )
        }
    }
}
