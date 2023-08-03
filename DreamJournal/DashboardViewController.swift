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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func OnViewAllClicked(_ sender: Any) {
        performSegue(withIdentifier: "ToListView", sender: user)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListView" {
            if let listVC = segue.destination as? DreamTableViewController ,let user = sender as? UserTable {
                    listVC.user = user
                }
            }
        }
    }

