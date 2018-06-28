//
//  APIMock.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

@testable import UberFlickr

class APIMock: API {

    var result: FlickrPhotoSearchResult?
    var error: UberFlickr.Error?
    
    convenience init() {
        self.init(gateway: GatewayMock(), apiKey:"")
    }
    
    required init(gateway: Gateway, apiKey: APIKey) {
    }
    
    func searchPhotos(withText text: String, page: Int, perPageCount: Int, success: @escaping (FlickrPhotoSearchResult) -> Void, failure: @escaping (UberFlickr.Error) -> Void) {
        if let result = result {
            success(result)
        }
        
        if let error = error {
            failure(error)
        }
    }
}
