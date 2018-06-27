//
//  PhotoCollectionViewCell.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class FlickrPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    private var photoId : String?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configureCell(with photoInfo: FlickrPhoto) {
        photoId = photoInfo.id ?? ""
        
        FlickrPhotoManager.sharedInstance.getImage(for: photoInfo, success: {[weak self] (image) in
            DispatchQueue.main.async {
                guard self?.photoId == photoInfo.id else {
                    return
                }
                
                self?.imageView.image = image
            }
        }) { (error) in
            
        }
    }
}
