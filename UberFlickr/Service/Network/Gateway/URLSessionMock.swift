//
//  URLSessionMock.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

class URLSessionTaskMock: URLSessionDataTask {
    var completion: (() -> Void)?
    
    override func resume() {
    }
    
    override func cancel() {
    }
}


class URLSessionMock: URLSession {
    var data: Data?
    var errorResponse: Swift.Error?
    
    override init() {
        data = nil
        super.init()
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = URLSessionTaskMock()
        completionHandler(self.data, nil, self.errorResponse)
        
        return mockDataTask
    }
}
