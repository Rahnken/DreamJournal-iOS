//
//  DashboardViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-08-03.
//

import UIKit
import CoreData

class DashboardViewController : UIViewController{
    
    var user : UserTable?
    
    var username:String = ""
    var firstname:String = ""
    var lastname:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user ?? "User didn't pass")
        print(username)
        print(firstname)
        print(lastname)
        
    }
    
    
    
}
