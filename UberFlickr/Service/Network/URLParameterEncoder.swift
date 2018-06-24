//
//  URLParameterEncoder.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters?)
}

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters?) {
        
        guard let url = urlRequest.url else { return }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), let params = parameters {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in params {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}

public enum NetworkError : String, Swift.Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
