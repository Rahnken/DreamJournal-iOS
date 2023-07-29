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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func saveUserDataToJSON() {
        
           let userData: [String: String] = [
            "email": emailTextField.text ?? "",
            "username": usernameTextfield.text ?? "",
            "password": passwordTextField.text ?? "",
            "firstName": firstNameTextField.text ?? "",
            "lastName": lastNameTextField.text ?? "",
            "phoneNumber": phoneNumberTextField.text ?? ""
        ]
           
           if let fileURL = Bundle.main.url(forResource: "users", withExtension: "json") {
               do {
                   // Read the existing JSON data from the file
                   let jsonData = try Data(contentsOf: fileURL)
                   
                   // Deserialize the JSON data into an array of dictionaries
                   var jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]] ?? []
                   
                   jsonArray.append(userData)
                   
                   let updatedJsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
                   
                   try updatedJsonData.write(to: fileURL)
                   
                   print("User data saved to 'users.json' successfully.")
               } catch {
                   print("Error writing to 'users.json': \(error)")
               }
           } else {
               print("Failed to get URL for 'users.json' in the main bundle.")
           }
       }

    
    @IBAction func CreateUser(_ sender: Any) {
        
        saveUserDataToJSON()
        performSegue(withIdentifier: "toLogin", sender: nil)
        
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
