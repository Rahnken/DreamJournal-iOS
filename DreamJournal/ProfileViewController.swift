//
//  ProfileViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-06-11.
//

import Foundation
import UIKit


class ProfileViewController : UIViewController {
    
    @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    @IBOutlet weak var lastNameTextfield: UITextField!
    
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    
    
    
    var username :  String = ""
    var firstName : String = ""
    var lastName : String = ""
    var phoneNumber : String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.text = username
        firstNameTextfield.text = firstName
        lastNameTextfield.text = lastName
        phoneNumberTextfield.text = phoneNumber
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateButton(_ sender: Any) {
        // Retrieve the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }

        // Retrieve the managed object context
        let context = appDelegate.persistentContainer.viewContext

        // Save the changes in the context
        do {
            try context.save()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    
    @IBAction func addNewJournalButton(_ sender: Any) {
        
        
    }
    
    
    
}
