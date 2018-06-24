//
//  FlickrPhoto+Mapping.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

extension FlickrPhoto {
    
    static func entity(withDictionary dictionary: [AnyHashable: Any]) -> FlickrPhoto? {
        var entity = FlickrPhoto()
        
        if let id = dictionary["id"] as? String {
            entity.id = id
        }
        
        if let title = dictionary["title"] as? String {
            entity.title = title
        }
        
        if let farm = dictionary["farm"] as? NSNumber {
            entity.farm = farm.intValue
        }
        
        if let secret = dictionary["secret"] as? String {
            entity.secret = secret
        }
        
        if let server = dictionary["server"] as? String {
            entity.server = server
        }
        
        return entity
    }
}
