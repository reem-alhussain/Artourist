//
//  MyEdits_VC.swift
//  Artourist
//
//  Created by Reem on 20/07/2019.
//  Copyright © 2019 Reem. All rights reserved.
//

import UIKit
import CoreData

class MyEdits_VC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: - Variables
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<EditedPhoto>!

    
    // MARK: - VC Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        updateFlowLayout(view.frame.size)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateFlowLayout(size)
    }
    
    
    // MARK: - Core Data Functions
    func deletePhoto(at indexPath: IndexPath) { 
        dataController.viewContext.delete(fetchedResultsController.object(at: indexPath))
        try? dataController.viewContext.save()
    }
    
    fileprivate func setupFetchedResultsController() {
        
        let fetchRequest:NSFetchRequest<EditedPhoto> = EditedPhoto.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    // MARK: - UI
    private func updateFlowLayout(_ withSize: CGSize) {
        
        let landscape = withSize.width > withSize.height
        
        let space: CGFloat = landscape ? 5 : 3
        let items: CGFloat = landscape ? 2 : 3
        
        let dimension = (withSize.width - ((items + 1) * space)) / items
        
        collectionViewFlowLayout?.minimumInteritemSpacing = space
        collectionViewFlowLayout?.minimumLineSpacing = space
        collectionViewFlowLayout?.itemSize = CGSize(width: dimension, height: dimension)
        collectionViewFlowLayout?.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEditMyImage"
        {
            let dest = segue.destination as! Editor_VC
            let index =  sender as! IndexPath
            dest.dataController = dataController
            dest.image = UIImage(data: fetchedResultsController.object(at: index).image!)
            dest.currentEditedPhoto = fetchedResultsController.object(at: index)
        }
    }

}

