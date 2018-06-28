//
//  API.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

typealias APIKey = String

protocol API {
    init(gateway: Gateway, apiKey: APIKey)
    func searchPhotos(withText text: String, page: Int, perPageCount: Int, success: @escaping (FlickrPhotoSearchResult) -> Void, failure: @escaping (Error) -> Void)
}

struct FlickrAPI : API {
    
    fileprivate let gateway: Gateway
    fileprivate let apiKey: APIKey
    
    init(gateway: Gateway, apiKey: APIKey) {
        self.gateway = gateway
        self.apiKey = apiKey
    }
    
    private func getParameters(forAPIMethod method: String, parameters: Parameters = [:]) -> Parameters {
        let params: Parameters = ["method": "flickr.\(method)", "api_key": self.apiKey, "format": "json", "nojsoncallback": "1"]
        let combinedParameters = (parameters.count > 0) ? params +| parameters : params
        return combinedParameters
    }
    
    
    func searchPhotos(withText text: String, page: Int, perPageCount: Int, success: @escaping (FlickrPhotoSearchResult) -> Void, failure: @escaping (Error) -> Void) {
        
        let parameters = getParameters(forAPIMethod: "photos.search", parameters: [
            "safe_search": "1",
            "text": text,
            "page": page,
            "per_page": perPageCount,
            ])
        
        let request = NetworkRequest(
            method: .GET,
            url: String(format: "https://api.flickr.com/services/rest/"), parameters: parameters
        )
        
        let _ = self.gateway.makeJSONRequest(request: request, success: {(json) in
            
            self.parse(json: json, success: success, failure: failure)
            
        }, failure: failure)
    }
    
    /// Parses response JSON to array of image to <count> URLs
    fileprivate func parse(json: [String: Any], success: (FlickrPhotoSearchResult) -> Void, failure: (Error) -> Void) {
        // get array of tracks
//        guard
//            let tracks = json["tracks"].array,
//            tracks.count >= count else
//        {
//            failure(Error.api(.notEnoughImages))
//            return
//        }
        
        if let photoSearchResult = FlickrPhotoSearchResult.entity(withDictionary: json) {
            success(photoSearchResult)
        } else {
            failure(Error.api(.noImage))
        }
    }
}
