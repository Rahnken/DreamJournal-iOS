//
//  AddJournalEntryViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-06-12.
//

import Foundation
import UIKit
import CoreData

class AddJournalEntryViewController : UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var feelingsTextField: UITextField!
    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dream : DreamEntryTable?
    // Create instance of UI Image Picker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Declare the delegate for the image picker is our
        imagePicker.delegate = self
        
        if let dream = dream {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            
            titleTextField.text = dream.title
            descriptionTextView.text = dream.dream_description
            categoriesTextField.text = dream.category
            feelingsTextField.text = dream.feeling
            recurringSwitch.isOn = dream.recurringDream
            datePicker.date = dateFormatter.date(from: dream.date!)!
        }
       
    }
    
    @IBAction func BackButtonPushed (_ sender: Any){
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func ConfirmButtonPushed (_ sender: Any){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        let title:String = titleTextField.text ?? ""
        let dream_description:String = descriptionTextView.text ?? ""
        let category:String = categoriesTextField.text ?? ""
        let feeling:String = feelingsTextField.text ?? ""
        let reccuringDream:Bool = recurringSwitch.isOn
        let date:String = dateFormatter.string(from: datePicker.date)
       
        let context = appDelegate.persistentContainer.viewContext
        
        
        if let dream = dream {
            dream.title=title
            dream.dream_description=dream_description
            dream.category=category
            dream.feeling=feeling
            dream.recurringDream=reccuringDream
            dream.date=date
            dream.user_id=0
            dream.dream_id=1400
            
        } else{
            let newDream = DreamEntryTable(context: context)
            newDream.title=title
            newDream.dream_description=dream_description
            newDream.category=category
            newDream.feeling=feeling
            newDream.recurringDream=reccuringDream
            newDream.date=date
            newDream.user_id=0
            newDream.dream_id=1400
        }
        do {
            try context.save()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Failed to save data: \(error)")
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
