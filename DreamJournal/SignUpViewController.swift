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
    
    func saveUserDataToCoreData() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }

           let context = appDelegate.persistentContainer.viewContext
           let newUser = UserTable(context: context)
           newUser.email = emailTextField.text
           newUser.username = usernameTextfield.text
           newUser.password = passwordTextField.text
           newUser.firstName = firstNameTextField.text
           newUser.lastName = lastNameTextField.text
           newUser.phoneNumber = phoneNumberTextField.text

           do {
               try context.save()
               print("User data saved to Core Data successfully.")
           } catch {
               print("Failed to save user data to Core Data: \(error)")
           }
       }

//    func saveUserDataToCoreData() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "AppUser", in: context)!
//        let user = NSManagedObject(entity: entity, insertInto: context)
//
//        user.setValue(emailTextField.text ?? "", forKeyPath: "email")
//        user.setValue(usernameTextfield.text ?? "", forKeyPath: "username")
//        user.setValue(passwordTextField.text ?? "", forKeyPath: "password")
//        user.setValue(firstNameTextField.text ?? "", forKeyPath: "firstName")
//        user.setValue(lastNameTextField.text ?? "", forKeyPath: "lastName")
//        user.setValue(phoneNumberTextField.text ?? "", forKeyPath: "phoneNumber")
//
//        do {
//            try context.save()
//            print("User data saved to Core Data successfully.")
//        } catch let error as NSError {
//            print("Could not save user data. Error: \(error), \(error.userInfo)")
//        }
//    }

    
    @IBAction func CreateUser(_ sender: Any) {
        
        saveUserDataToCoreData()
//        saveUserDataToJSON()
        performSegue(withIdentifier: "toLogin", sender: nil)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ToProfile" {
//            if let profileVC = segue.destination as? ProfileViewController {
//                profileVC.username = usernameTextfield.text ?? ""
//                profileVC.firstName = firstNameTextField.text ?? ""
//                profileVC.lastName = lastNameTextField.text ?? ""
//                profileVC.phoneNumber = phoneNumberTextField.text ?? ""
//            }
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "toLogin" {
//                if let signInVC = segue.destination as? SignInViewController {
//                    // Pass the user credentials to SignInViewController
//                    signInVC.receivedUsername = usernameTextfield.text
//                    signInVC.receivedPassword = passwordTextField.text
//                }
//            } else if segue.identifier == "ToProfile" {
//                // ... Code to pass data to the profile view controller ...
//            }
//        }

    
    
}
