//
//  FlickrPhotoManager.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 26/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class FlickrPhotoManager {
    static let sharedInstance = FlickrPhotoManager()

    private let memoryCache = NSCache<NSString, UIImage>()
    let gateway: Gateway

    private init() {
        let gateway: Gateway = NetworkProvider(session: URLSession(configuration: .default))
        self.gateway = gateway
    }
    
    func cachedImage(for photo: FlickrPhoto) -> UIImage? {
        guard let photoId = photo.id else {
            return nil
        }
        return memoryCache.object(forKey: NSString(string: photoId))
    }

    private func path(for photo: FlickrPhoto) -> String {
        return "https://farm\(photo.farm).static.flickr.com/\(String(describing: photo.server ?? ""))/\(String(describing: photo.id ?? ""))_\(String(describing: photo.secret ?? ""))_n.jpg"
    }
    
    func getImage(for photo: FlickrPhoto, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
        
        if let chachedImage = cachedImage(for: photo) {
            success(chachedImage)
            return
        }
        
        let path = self.path(for: photo)
        let request = NetworkRequest(
            method: .GET,
            url: path, parameters: nil)
        
        let _ = self.gateway.makeRequest(request: request, success: {(data) in
            
            guard let image = UIImage(data: data) else {
                failure(Error.api(.invalidImageData))
                return
            }
            
            if let photoId = photo.id {
                self.memoryCache.setObject(image, forKey: NSString(string: photoId))
            }
            
            success(image)
        }, failure: failure)
        
    }
    
}
