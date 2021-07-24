//
//  File.swift
//  
//
//  Created by Simon Lee on 7/24/21.
//

import UIKit
import CoreText
import Alamofire

public class FontManager {
    enum FontManagerError: Error {
        case missingFontData
        case missingCGFont
        case cannotRegisterFont
        case missingPostScriptName
    }
    private var fontStore: [DownloadableFont: CGFont] = [:]

    public init() {

    }

    public func uiFont(
        for downloadbleFont: DownloadableFont,
        size: CGFloat,
        completion: @escaping ((Result<UIFont?, Error>) -> Void)
    ) {
        // check the store and try to create an UIFont
        if let cgFont = fontStore[downloadbleFont],
           let postScriptName = cgFont.postScriptName as String?,
           let uiFont = UIFont(name: postScriptName, size: size) {
            completion(.success(uiFont))
            return
        }

        // download and register
        download(font: downloadbleFont) { [weak self] result in
            guard let self = self else { return }

            completion(
                result
                    .flatMap(self.register(font:))
                    .map({ UIFont(name: $0, size: size) })
            )
        }
    }

    public func download(font: DownloadableFont, completion: @escaping (Result<CGFont, Error>) -> Void) {
        if let cgFont = fontStore[font] {
            completion(.success(cgFont))
            return
        }

        AF.download(font.downloadURL)
            .validate()
            .responseData { [weak self] response in
                switch response.result {
                case .success(let data):
                    if let provider = CGDataProvider(data: data as CFData),
                       let cgfont = CGFont(provider) {
                        self?.fontStore[font] = cgfont
                        completion(.success(cgfont))
                    } else {
                        completion(.failure(FontManagerError.missingCGFont))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        // TODO: Add request to a map to be cancelled later
    }

    public func register(font: CGFont) -> Result<String, Error> {

        var error: Unmanaged<CFError>?

        guard let postScriptName = font.postScriptName as String? else {
            CTFontManagerUnregisterGraphicsFont(font, nil)
            return .failure(FontManagerError.missingPostScriptName)
        }

        guard CTFontManagerRegisterGraphicsFont(font, &error) else {
            return .failure(FontManagerError.cannotRegisterFont)
        }

//        postScriptNameMapping[font.name] = postScriptName

        return .success(postScriptName)
    }
}
