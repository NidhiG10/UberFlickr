//
//  FlickrPhotoLoaderCell.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 27/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class FlickrPhotoLoaderCell: UICollectionViewCell {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
            
            activityIndicator.isHidden = !isAnimating
        }
    }
}
