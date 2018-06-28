//
//  GatewayMock.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

@testable import UberFlickr

class GatewayMock: Gateway {
    var responseData: Data?
    var responseError: UberFlickr.Error?
    var responseJSON: [String: Any]?
    
    func makeRequest(request: NetworkRequest, success: ((Data) -> Void)?, failure: ((UberFlickr.Error) -> Void)?) -> NetworkCancelable? {
        
        if let data = responseData {
            success?(data)
        }
        
        if let error = responseError {
            failure?(error)
        }
        
        return nil
    }
    
    func makeJSONRequest(request: NetworkRequest, success: (([String: Any]) -> Void)?, failure: ((UberFlickr.Error) -> Void)?) -> NetworkCancelable? {
        if let json = responseJSON {
            success?(json)
        }
        
        if let error = responseError {
            failure?(error)
        }
        
        return nil
    }
    
    convenience init() {
        self.init(session: URLSessionMock())
    }
    
    required init(session: URLSession) {
        
    }
    
}
