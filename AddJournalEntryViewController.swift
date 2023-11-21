//
//  AddJournalEntryViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-06-12.
//

import Foundation
import UIKit
import CoreData
import Firebase

class AddJournalEntryViewController : UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var feelingsTextField: UITextField!
    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dream : DreamEntryTable?
    var user : UserTable?
    // Create instance of UI Image Picker
    let imagePicker = UIImagePickerController()
    
    var dreams: DreamEntry?
    var dreamViewController: DreamTableViewController?
    var dreamsUpdateCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Declare the delegate for the image picker is our
        imagePicker.delegate = self
        descriptionTextView.layer.borderWidth = 0.23
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let dream = dreams {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            titleTextField.text = dream.title
            descriptionTextView.text = dream.dream_description
            categoriesTextField.text = dream.category
            feelingsTextField.text = dream.feeling
            if dream.recurringDream == "true"{
                recurringSwitch.isOn = true
            }
            datePicker.date = dateFormatter.date(from: dream.date)!
            print("pick date",dream.date)
            navigationItem.title = "Edit your Dream"
        }
        else{
            navigationItem.title = "Add a New Dream"
            
        }
       
    }
    
    @IBAction func BackButtonPushed (_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func ConfirmButtonPushed (_ sender: Any){
    
            
        let dreamid = arc4random()
            let title:String = titleTextField.text ?? ""
            let dream_description:String = descriptionTextView.text ?? ""
            let category:String = categoriesTextField.text ?? ""
            let feeling:String = feelingsTextField.text ?? ""
        
            var recurring:String = ""
        if recurringSwitch.isOn {
            recurring = "true"
        }else{ recurring = "false"}
            
        let db = Firestore.firestore()
        
        if let dream = dreams {
            // Update existing dream
            guard let documentID = dream.documentID else {
                print("Document ID not available.")
                return
            }
            let dreamid: Int = dream.dream_id
            let dreamdate: String = dream.date
            print("dreamdate",dreamdate)
            let dreamRef = db.collection("dreams").document(documentID)
            dreamRef.updateData([
                "dream_id": dreamid,
                "title": title,
                "dream_description": dream_description,
                "category": category,
                "feeling": feeling,
                "recurringDream": recurring,
                "date": dreamdate,
                "imageURL": "",
                "user_id": 201
            ]) { [weak self] error in
                if let error = error {
                    print("Error updating dreams: \(error)")
                } else {
                    print("Dream updated successfully.")
                    self?.navigationController?.popViewController(animated: true)
                        self?.dreamsUpdateCallback?()
                    
                }
            }
        } else {
        // Add new dream
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "YYYY-MM-dd"
            let date2:String = dateFormatter2.string(from: datePicker.date)
        let newDream     = [
            
            "dream_id": dreamid,
            "title": title,
            "dream_description": dream_description,
            "category": category,
            "feeling": feeling,
            "recurringDream": recurring,
            "date": date2,
            "imageURL": "",
            "user_id": 201
        ] as [String : Any]

        var ref: DocumentReference? = nil
        ref = db.collection("dreams").addDocument(data: newDream) { [weak self] error in
            if let error = error {
                print("Error adding dream: \(error)")
            } else {
                print("Dream added successfully.")
                self?.navigationController?.popToRootViewController(animated: true)
                    self?.dreamsUpdateCallback?()
                
            }
        }
    }
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
