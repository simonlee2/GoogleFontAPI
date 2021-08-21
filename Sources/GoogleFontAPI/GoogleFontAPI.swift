import Alamofire
import Combine

public struct GoogleFontAPI {
    private let apiKey: String
    private let apiHost: String

    private var params: [String: String] {
        ["key": apiKey]
    }

    public init(apiKey: String, apiHost: String = "https://www.googleapis.com/webfonts/v1/webfonts") {
        self.apiKey = apiKey
        self.apiHost = apiHost
    }

    public func fetchAllFonts(completion: @escaping (Result<[GoogleFont], AFError>) -> Void) {
        AF.request(apiHost, parameters: params)
            .validate()
            .responseDecodable(of: GoogleFontResponse.self) { response in
                let fonts = response.result
                    .map({ $0.items })
                completion(fonts)
            }
    }

    public func fetchAllFonts() -> AnyPublisher<[GoogleFont], AFError> {
        AF.request(apiHost, parameters: params)
            .validate()
            .publishDecodable(type: [GoogleFont].self)
            .value()
            .eraseToAnyPublisher()
    }

    @available(iOS 15, *)
    public func allFont() async throws -> [GoogleFont] {
        try await withCheckedThrowingContinuation { continuation in
            fetchAllFonts(completion: { continuation.resume(with: $0) })
        }
    }

    public func download(font: GoogleFont, variant: String, completion: @escaping (Result<InstallableFont, Error>) -> Void) {
        
    }
}
