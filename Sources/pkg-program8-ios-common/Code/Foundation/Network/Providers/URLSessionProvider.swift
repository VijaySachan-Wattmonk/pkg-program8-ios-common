//
//  File.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 28/07/25.
//

import Foundation
final class URLSessionProvider:NetworkProvider{
    private let session: URLSession!
    init(configuration: URLSessionConfiguration){
        session = URLSession(configuration: configuration)
    }
    init (){
        session = URLSession(configuration:URLSessionProvider.defaultConfiguration())
    }
    
func request<T>(url: URL, method: FWHttpMethod, headers: [String : String]?, body: Data?, responseType: T.Type) async throws -> T where T : Decodable {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    var responseData: Data? = nil
    var statusCode: Int? = nil
    defer {
        logRequestAndResponse(url: url, method: method, headers: headers, body: body, responseData: responseData, statusCode: statusCode)
    }

    do {
        let (data, response) = try await session.data(for: request)
        responseData = data
        statusCode = (response as? HTTPURLResponse)?.statusCode

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        print("❌ Request failed with error: \(error)")
        throw error
    }
}
    
private func logRequestAndResponse(url: URL, method: FWHttpMethod, headers: [String: String]?, body: Data?, responseData: Data?, statusCode: Int?) {
    print("🕒 Timestamp: \(Date())")
    print("🌐 Request URL: \(url.absoluteString)")
    print("📤 HTTP Method: \(method.rawValue)")
    if let statusCode = statusCode {
        print("📶 HTTP Status Code: \(statusCode)")
    }
    if let headers = headers {
        print("📤 Headers: \(headers)")
    }
    if let body = body, let bodyString = String(data: body, encoding: .utf8) {
        print("📤 Body: \(bodyString)")
    }
    if let data = responseData, let responseString = String(data: data, encoding: .utf8) {
        print("📥 Response Data: \(responseString)")
    }
}
    
    
    
    
}
