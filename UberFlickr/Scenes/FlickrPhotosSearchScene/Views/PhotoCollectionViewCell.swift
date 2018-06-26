//
//  PhotoCollectionViewCell.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configureCell(with photoInfo: FlickrPhoto) {
        FlickrPhotoManager.sharedInstance.getImage(for: photoInfo, success: {(image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }) { (error) in
            
        }
    }
}
