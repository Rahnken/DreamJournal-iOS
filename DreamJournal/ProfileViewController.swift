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
    
    var user : UserTable?
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.text = user?.username
        firstNameTextfield.text = user?.firstName
        lastNameTextfield.text = user?.lastName
        phoneNumberTextfield.text = user?.phoneNumber
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
    
}
