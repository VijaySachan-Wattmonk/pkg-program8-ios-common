//
//  FWNetworkService.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 28/07/25.
//

import Foundation
public final class NetworkService:FWLoggerDelegate{
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
    
    public func request<T: Decodable>(
        method: FWHttpMethod,
        params: [String: Encodable],
        url: String,
        additionalHeaders: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        let mergedHeaders = commonHeaders.merging(additionalHeaders ?? [:]) { _, new in new }
        var finalURL = requestURL
        var body: Data? = nil
        switch method {
        case .get:
            if !params.isEmpty {
                var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
                components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                if let urlWithQuery = components?.url {
                    finalURL = urlWithQuery
                }
            }
        case .post:
            let encoded = try JSONEncoder().encode(EncodableDictionary(params))
            body = encoded
        default:
            throw FWError(message: "Method : \(method.rawValue) is not supported")
        }

        return try await provider.request(
            url: finalURL,
            method: method,
            headers: mergedHeaders,
            body: body,
            responseType: responseType
        )
    }
    
    
}

struct EncodableDictionary: Encodable {
    let dictionary: [String: Encodable]

    init(_ dictionary: [String: Encodable]) {
        self.dictionary = dictionary
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (key, value) in dictionary {
            let codingKey = DynamicCodingKeys(stringValue: key)!
            try container.encode(AnyEncodable(value), forKey: codingKey)
        }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int? { nil }
        init?(intValue: Int) { nil }
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
