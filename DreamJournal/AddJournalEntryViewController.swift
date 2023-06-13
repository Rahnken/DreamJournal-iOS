//
//  AddJournalEntryViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-06-12.
//

import Foundation
import UIKit
import MobileCoreServices

class AddJournalEntryViewController : UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    // Create instance of UI Image Picker
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        // Declare the delegate for the image picker is our
        imagePicker.delegate = self
    }
    @IBAction func BackButtonPushed (_ sender: Any){
            dismiss(animated: true, completion: nil)
       
    }
    @IBAction func ConfirmButtonPushed (_ sender: Any){
            dismiss(animated: true, completion: nil)
       // TODO: Update this when we have a model for entries completed
    }
    
    
    @IBAction func chooseImgButtonPushed (_ sender: Any) {
        present(imagePicker,animated:true,completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        // TODO: Process the selected image here
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //TODO: Handle cancel event if needed
    }
    
    

}
