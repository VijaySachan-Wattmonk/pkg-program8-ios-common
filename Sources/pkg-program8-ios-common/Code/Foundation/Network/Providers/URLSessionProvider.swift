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
        return T.self as! T
    }
    
    
    
    
}
