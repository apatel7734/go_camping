//
//  CampsiteDetailPhotoCell.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 12/21/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteDetailPhotoCell: UITableViewCell {
    
    var photos: [PlaceDetail.Photo]?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!

    override func awakeFromNib() {
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
        imageView.image = UIImage(named: "eee")
        
        return cell
    }
}