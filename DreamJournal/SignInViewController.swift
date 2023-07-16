//
//  ViewController.swift
//  DreamJournal
//
//  Created by Jaivleen Kour on 2023-06-10.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var appleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        for credentialsView in [self.emailView , self.passwordView]
        {
            credentialsView?.layer.borderColor = UIColor.lightGray.cgColor
            credentialsView?.layer.borderWidth = 1
            credentialsView?.layer.cornerRadius = 10
            credentialsView?.clipsToBounds = true
        }
        
        for views in [self.loginView, self.googleView , self.facebookView , self.appleView]
        {
            views?.layer.borderColor = UIColor.clear.cgColor
            views?.layer.borderWidth = 1
            views?.layer.cornerRadius = 10
            views?.clipsToBounds = true
        }

    }

    @IBAction func LoginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "ToProfile", sender: nil)
        
        
        
    }
    
    @IBAction func forgotPassBtn(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in ", preferredStyle: UIAlertController.Style.alert)
                      refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                          print("Still using App")
                   }))
                   
                   refreshAlert.addAction(UIAlertAction(title: "Sign out", style: .default, handler: { (action: UIAlertAction!) in
                       print("Logged Out")
                       
                   }))
                   present(refreshAlert, animated: true, completion: nil)
    }
}

