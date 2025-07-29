//
//  BaseNetworkProvider.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 29/07/25.
//

import Foundation


open class BaseNetworkProvider:NetworkProvider {
    public func performRequest<T>(url: URL, method: FWHttpMethod, headers: [String : String]?, body: Data?, responseType: T.Type) async -> Result<T, NetworkErrorLog> where T : Decodable {
        fatalError("Must override")
    }
    
    
    public required init(configuration: URLSessionConfiguration) {
       
    }

    public required init() {
        
    }
    static func defaultConfiguration() -> URLSessionConfiguration {
        let copy = URLSessionConfiguration.default
        return copy
    }
}
