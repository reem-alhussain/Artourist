//
//  MyEdits_VC+UICollectionView.swift
//  Artourist
//
//  Created by Reem on 20/07/2019.
//  Copyright © 2019 Reem. All rights reserved.
//

import Foundation
import UIKit

extension MyEdits_VC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo = self.fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoVC
        let photo = fetchedResultsController.object(at: indexPath)
        cell.imageView.image = UIImage(data: photo.image!)
        cell.activityIndicator.stop()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing{
            deletePhoto(at: indexPath)
        }else{
            performSegue(withIdentifier: "ShowEditMyImage", sender: indexPath)
        }
    }
    
}
