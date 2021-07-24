import Alamofire

public struct GoogleFontAPI {
    private let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func fetchAllFonts(completion: @escaping (Result<[GoogleFont], Error>) -> Void) {
        let parameters = ["key": apiKey]
        AF.request("https://www.googleapis.com/webfonts/v1/webfonts", parameters: parameters)
            .validate()
            .responseDecodable(of: GoogleFontResponse.self) { response in
                let fonts = response.result
                    .map({ $0.items })
                    .mapError({ $0 as Error })
                completion(fonts)
            }
    }

    public func download(font: GoogleFont, variant: String, completion: @escaping (Result<InstallableFont, Error>) -> Void) {
        
    }
}
