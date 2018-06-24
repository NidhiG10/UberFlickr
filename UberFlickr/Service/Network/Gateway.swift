//
//  Gateway.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

protocol NetworkCancelable {
    func cancel()
}
extension URLSessionDataTask: NetworkCancelable { }

protocol Gateway {
    init(session: URLSession)
    
    func makeRequest(request: NetworkRequest, success: ((Data) -> Void)?, failure: ((Error) -> Void)?) -> NetworkCancelable?
}

extension Gateway {
    init(session: URLSession) {
        self.init(session: session)
    }
}

class NetworkProvider: Gateway {
    
    let session: URLSession
    
    required init(session: URLSession) {
        self.session = session
    }
    
    func makeRequest(request: NetworkRequest, success: ((Data) -> Void)?, failure: ((Error) -> Void)?) -> NetworkCancelable? {
        let request = request.buildURLRequest()
        let task = self.session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let description = error?.localizedDescription {
                    // Next step would be to provide custom, more friendly messages for the most common errors.
                    failure?(Error.gateway(.network(description: description)))
                } else {
                    failure?(Error.gateway(.unknown))
                }
                return
            }
            
            success?(data)
        }
        task.resume()
        return task
    }
}
