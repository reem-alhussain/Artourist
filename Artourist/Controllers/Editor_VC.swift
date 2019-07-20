//
//  Editor_VC.swift
//  Artourist
//
//  Created by Reem on 20/07/2019.
//  Copyright © 2019 Reem. All rights reserved.
//

import UIKit
import iOSPhotoEditor
import CoreData

class Editor_VC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var saveToMyEditsBtn: UIButton!
    
    // MARK: - Variables
    var image: UIImage?
    var currentEditedPhoto : EditedPhoto?
    var dataController:DataController!
    let fav = UIColor(red: 251.0/255.0, green: 179.0/255.0, blue: 42.0/255.0, alpha: 1.0)

    
    // MARK: _ VC Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            imageView.image = image
        }
        if currentEditedPhoto != nil {
            saveToMyEditsBtn.tintColor = fav
        } 
    }
    
    
    // MARK: - Actions
    @IBAction func editImage(_ sender: Any) {
        editPhoto()
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let controller = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func saveToMyEdits(_ sender: Any) {
        if currentEditedPhoto == nil {
            addPhotoToMyEdits()
        }
        else{
            deletePhotoFromMyEdits()
        }
    }
    
    
    
    // MARK: - Core Data Functions
    func addPhotoToMyEdits() {
        do{
            let pho = EditedPhoto(context: dataController.viewContext)
            pho.image = image!.pngData()
            currentEditedPhoto = pho
            try dataController.viewContext.save()
            saveToMyEditsBtn.tintColor = fav
        }catch{
            print(error)
        }
    }
    
    func deletePhotoFromMyEdits() {
        if let currentEditedPhoto = currentEditedPhoto {
        dataController.viewContext.delete(currentEditedPhoto)
        try? dataController.viewContext.save()
            saveToMyEditsBtn.tintColor = .gray
            self.currentEditedPhoto = nil
        }
    }
    
    
}
