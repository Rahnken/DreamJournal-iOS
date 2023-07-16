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
, UIPickerViewDelegate, UIPickerViewDataSource
{
    // Creating Category Dropdown
    let dropdownTextField = UITextField()
    let dropdownData = ["Option 1", "Option 2", "Option 3"]
    let pickerView = UIPickerView()
    
    // Create instance of UI Image Picker
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        // Declare the delegate for the image picker is our
        imagePicker.delegate = self
        
        // Set up the dropdown text field
        dropdownTextField.borderStyle = .roundedRect
        dropdownTextField.textAlignment = .center
        dropdownTextField.placeholder = "Select an option"
        view.addSubview(dropdownTextField)
        dropdownTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dropdownTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dropdownTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dropdownTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set up the picker view
        pickerView.delegate = self
        pickerView.dataSource = self
        dropdownTextField.inputView = pickerView
        
        // Add a toolbar with a done button to dismiss the pickerView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dropdownDoneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        dropdownTextField.inputAccessoryView = toolbar
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
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of components in the picker (in this case, a single column)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownData.count // Number of rows in the picker
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdownData[row] // Text to display for each row in the picker
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dropdownTextField.text = dropdownData[row] // Update the text field with the selected option
    }
    
    @objc func dropdownDoneButtonTapped() {
        dropdownTextField.resignFirstResponder() // Dismiss the pickerView
    }
    
    
    
}
