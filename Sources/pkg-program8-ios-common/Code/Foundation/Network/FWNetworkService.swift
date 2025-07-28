//
//  FWNetworkService.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 28/07/25.
//

import Foundation
public final class FWNetworkService:FWLoggerDelegate{
    private let provider: NetworkProvider
    public private(set) var commonHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    public init(provider: NetworkProvider) {
        self.provider = provider
    }
    func setCommonHeaders(_ headers: [String: String]) {
        self.commonHeaders=headers
    }
    
//    public func requestPOST<T: Decodable>(
//        url: String,
//        body: Encodable,
//        additionalHeaders: [String: String]? = nil,
//        responseType: T.Type
//    ) async -> Result<T, NetworkErrorLog> {
//        guard let requestURL = URL(string: url) else {
//            return .failure(URLError(.badURL))
//        }
//        let mergedHeaders = commonHeaders.merging(additionalHeaders ?? [:]) { _, new in new }
//
//        do {
//            let encodedBody = try JSONEncoder().encode(AnyEncodable(body))
//            return await provider.requestResult(
//                url: requestURL,
//                method: .post,
//                headers: mergedHeaders,
//                body: encodedBody,
//                responseType: responseType
//            )
//        } catch {
//            return .failure(error)
//        }
//    }
    
    public func requestGET<T: Decodable>(
        url: String,
        params: [String: Encodable] = [:],
        additionalHeaders: [String: String]? = nil,
        responseType: T.Type
    ) async -> Result<T, NetworkErrorLog> {
        let mergedHeaders = commonHeaders.merging(additionalHeaders ?? [:]) { _, new in new }
        guard let requestURL = URL(string: url) else {
            return .failure(NetworkErrorLog(url: url, method: .get, headers: mergedHeaders, body: nil, responseData: nil, statusCode: nil, errorDescription: "Invalid URL")
            )
        }
        
        var finalURL = requestURL
        if !params.isEmpty {
            var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
            components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if let urlWithQuery = components?.url {
                finalURL = urlWithQuery
            }
        }

        return await provider.requestResult(
            url: finalURL,
            method: .get,
            headers: mergedHeaders,
            body: nil,
            responseType: responseType
        )
    }
    
    
}
struct AnyEncodable: Encodable {
    let value: Encodable

    init(_ value: Encodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
