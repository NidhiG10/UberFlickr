//
//  FlickrPhotoSearchResult+Mapping.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

extension FlickrPhotoSearchResult {
    
    static func entity(withDictionary dictionary: [AnyHashable: Any]) -> FlickrPhotoSearchResult? {
        var entity = FlickrPhotoSearchResult()
        
        var photosInfo : [FlickrPhoto] = []
        if let photos = dictionary["photos"] as? [String: Any] {
            if let page = photos["page"] as? NSNumber {
                entity.page = page.intValue
            }
            
            if let pages = photos["pages"] as? NSNumber {
                entity.pages = pages.intValue
            }
            
            if let photo = photos["photo"] as? [[String: Any]] {
                for photoInfo in photo {
                    let flickrPhotoInfo = FlickrPhoto.entity(withDictionary: photoInfo)
                    photosInfo.append(flickrPhotoInfo!)
                }
            }
        }
        
        entity.photos = photosInfo
        return entity
    }
}
