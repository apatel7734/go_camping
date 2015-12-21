//
//  CampsiteDetailPhotoCell.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 12/21/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import Kingfisher

class CampsiteDetailPhotoCell: UITableViewCell {
    
    var photos: [PlaceDetail.Photo]?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!

    private var googleMapApi: GoogleMapApi!
    
    override func awakeFromNib() {
        googleMapApi = GoogleMapApi(apiController: ApiController())

        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    func configureCellWithPhoto(photos: [PlaceDetail.Photo]?) {
        self.photos = photos
        photoCollectionView.reloadData()
    }
}

extension CampsiteDetailPhotoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        if let stringUrl = googleMapApi.getPhotoUrlForReference(photos?[indexPath.row].photoRef, maxWidth: 200),
            let url = NSURL(string: stringUrl) {
            imageView.kf_setImageWithURL(url)
        }
        
        return cell
    }
}