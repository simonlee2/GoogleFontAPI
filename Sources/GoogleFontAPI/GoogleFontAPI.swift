import Alamofire

public struct GoogleFontAPI {
    public func fetchAllFonts(completion: @escaping (Result<[GoogleFont], Error>) -> Void) {
        let parameters = ["key": GoogleFontAPIKey]
        AF.request("https://www.googleapis.com/webfonts/v1/webfonts", parameters: parameters)
            .validate()
            .responseDecodable(of: GoogleFontResponse.self) { response in
                let fonts = response.result
                    .map({ $0.items })
                    .mapError({ $0 as Error })
                completion(fonts)
            }
    }
}
