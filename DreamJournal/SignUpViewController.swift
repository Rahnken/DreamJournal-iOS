//
//  SignUpVC.swift
//  DreamJournalApp
//
//  Created by Supreet on 2023-07-16.


import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var dreams : [DreamEntryTable] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CreateUser(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
        
    }
    
    
    @IBAction func CreateUser(_ sender: Any) {
        
        performSegue(withIdentifier: "ToProfile", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToProfile" {
            if let profileVC = segue.destination as? ProfileViewController {
                profileVC.username = usernameTextfield.text ?? ""
                profileVC.firstName = firstNameTextField.text ?? ""
                profileVC.lastName = lastNameTextField.text ?? ""
                profileVC.phoneNumber = phoneNumberTextField.text ?? ""
            }
        }
    }

    
    
}
