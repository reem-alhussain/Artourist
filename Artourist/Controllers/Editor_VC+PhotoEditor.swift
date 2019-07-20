//
//  Editor_VC+PhotoEditor.swift
//  Artourist
//
//  Created by Reem on 20/07/2019.
//  Copyright © 2019 Reem. All rights reserved.
//

import Foundation
import iOSPhotoEditor

extension Editor_VC: PhotoEditorDelegate {
    
    func editPhoto(){
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.photoEditorDelegate = self
        photoEditor.image = image
        
        for i in 0...48 {
            photoEditor.stickers.append(UIImage(named: i.description )!)
        }
        
        photoEditor.hiddenControls = [.share]
        
        present(photoEditor, animated: true, completion: nil)
    }
    
    func doneEditing(image: UIImage) {
        imageView.image = image
        self.image = image
        if currentEditedPhoto != nil {
            deletePhotoFromMyEdits()
            addPhotoToMyEdits()
        }
    }
    
    func canceledEditing() {
        print("Canceled")
    }
}
