//
//  NetworkRequest.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

struct NetworkRequest {
    //MARK: - HTTP Methods
    enum Method: String {
        case GET        = "GET"
        case PUT        = "PUT"
        case PATCH      = "PATCH"
        case POST       = "POST"
        case DELETE     = "DELETE"
    }
    
    let method: NetworkRequest.Method
    let url: String
    let parameters: Parameters?
    
    func buildURLRequest() -> URLRequest {
        var request = URLRequest(url:URL(string: self.url)!)
        request.httpMethod = self.method.rawValue
        URLParameterEncoder().encode(urlRequest: &request, with: parameters)
        return request
    }
    
}
