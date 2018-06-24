//
//  FlickrPhoto.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    var id: String?
    var title: String?
    
    // The following properties are used to determine the url for retrieving the image.
    
    var farm: Int = 0
    var secret: String?
    var server: String?
}

