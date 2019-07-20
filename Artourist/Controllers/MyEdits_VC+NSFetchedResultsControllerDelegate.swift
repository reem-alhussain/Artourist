//
//  MyEdits_VC+NSFetchedResultsControllerDelegate.swift
//  Artourist
//
//  Created by Reem on 20/07/2019.
//  Copyright © 2019 Reem. All rights reserved.
//

import Foundation
import CoreData

extension MyEdits_VC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.collectionView.reloadData()
    }
}
