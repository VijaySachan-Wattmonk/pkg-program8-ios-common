//
//  NetworkProvider.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 28/07/25.
//
import Foundation
public enum FWHttpMethod: String,Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
public protocol NetworkProvider:Sendable{
    func request<T: Decodable>(
        url: URL,
        method: FWHttpMethod,
        headers: [String: String]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T
}
extension NetworkProvider{
    static func defaultConfiguration()-> URLSessionConfiguration {
        let copy=URLSessionConfiguration.default
//        copy.timeoutIntervalForRequest = 30
//        copy.timeoutIntervalForResource = 60
        return copy
    }
}


