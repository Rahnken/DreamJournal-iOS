//
//  SignUpVC.swift
//  DreamJournalApp
//
//  Created by Ravi  on 2023-06-10.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    @IBOutlet weak var appleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let googleImg = UIImage(named: "Google.png")
//        googleBtn.setImage(googleImg, for: .normal)
        
        //googleBtn.setImage(UIImage(named: "Google"), for: .normal)
    //facebookBtn.setImage(UIImage(named: "Facebook"), for: .normal)
       // appleBtn.setImage(UIImage(named: "Apple"), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
}
