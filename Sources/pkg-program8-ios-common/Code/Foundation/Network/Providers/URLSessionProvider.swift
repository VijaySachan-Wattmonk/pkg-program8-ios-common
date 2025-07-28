//
//  File.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 28/07/25.
//

import Foundation
final class URLSessionProvider:NetworkProvider,FWLoggerDelegate{
    struct NetworkLog: Error,FWLoggerDelegate {
        let url: URL
        let method: FWHttpMethod
        let headers: [String: String]?
        let body: Data?
        let responseData: Data?
        let statusCode: Int?
        let errorDescription: String?
        
        init(
            url: URL,
            method: FWHttpMethod,
            headers: [String: String]?,
            body: Data?,
            responseData: Data?,
            statusCode: Int?,
            errorDescription: String?
        ) {
            self.url = url
            self.method = method
            self.headers = headers
            self.body = body
            self.responseData = responseData
            self.statusCode = statusCode
            self.errorDescription = errorDescription
        }
        
        var requestBodyString: String {
            guard let body = body else { return "nil" }
            return String(data: body, encoding: .utf8) ?? "Non-UTF8 Data"
        }
        
        var responsePreviewString: String {
            guard let data = responseData else { return "nil" }
            return String(data: data.prefix(1000), encoding: .utf8) ?? "Non-UTF8 Data"
        }
        
        var headersString: String {
            headers?.map { "\($0.key): \($0.value)" }.joined(separator: ", ") ?? "nil"
        }
        
        func log() {
            let requestID = UUID().uuidString
            let timestamp = ISO8601DateFormatter().string(from: Date())
            mLog(msg: "🪪 Request ID: \(requestID)")
            mLog(msg: "🕒 Timestamp: \(timestamp)")
            mLog(msg: "🌐 URL: \(url.absoluteString)")
            mLog(msg: "📤 Method: \(method.rawValue)")

            if let statusCode = statusCode {
                mLog(msg: "📶 Status Code: \(statusCode)")
            }

            mLog(msg: "🧾 Headers: \(headersString)")
            mLog(msg: "📤 Request Body: \(requestBodyString)")
            mLog(msg: "📥 Response (preview): \(responsePreviewString)")

            if let errorDescription = errorDescription {
                mLog(msg: "❌ Error: \(errorDescription)")
            }

            mLog(msg: "✅ Request completed\n------------------------------")
        }
    }
    
    private let session: URLSession!
    init(configuration: URLSessionConfiguration){
        session = URLSession(configuration: configuration)
    }
    init (){
        session = URLSession(configuration:URLSessionProvider.defaultConfiguration())
    }
    
    func requestResult<T: Decodable>(
        url: URL,
        method: FWHttpMethod,
        headers: [String: String]?,
        body: Data?,
        responseType: T.Type
    ) async -> Result<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        var responseData: Data? = nil
        var statusCode: Int? = nil
        var errorDescription: String? = nil
        defer {
            let log = NetworkLog(
                url: url,
                method: method,
                headers: headers,
                body: body,
                responseData: responseData,
                statusCode: statusCode,
                errorDescription: errorDescription
            )
            log.log()
        }
        do {
            let (data, response) = try await session.data(for: request)
            responseData = data
            statusCode = (response as? HTTPURLResponse)?.statusCode
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return .failure(URLError(.badServerResponse))
            }
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            errorDescription = error.localizedDescription
            return .failure(NetworkLog(
                url: url,
                method: method,
                headers: headers,
                body: body,
                responseData: responseData,
                statusCode: statusCode,
                errorDescription: error.localizedDescription
            ))
        }
    }
    
}
