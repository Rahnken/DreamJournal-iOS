//
//  DreamTableViewController.swift
//  DreamJournal
//
//  Created by Eric Donnelly on 2023-07-16.
//

import UIKit
import CoreData

class DreamTableViewController: UITableViewController
{
    var dreams:[DreamEntryTable]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func fetchData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
                
        let context = appDelegate.persistentContainer.viewContext
                
        let fetchRequest: NSFetchRequest<DreamEntryTable> = DreamEntryTable.fetchRequest()
        let user_id = 0
        let filterPredicate = NSPredicate(format: "user_id == %@", argumentArray: [user_id])
                
        fetchRequest.predicate = filterPredicate
        do {
                dreams = try context.fetch(fetchRequest)
                tableView.reloadData()
        } catch {
                    print("Failed to fetch data: \(error)")
                }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dreams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamEntry", for: indexPath) as! DreamTableViewCell
        let dream = dreams[indexPath.row]
        
        cell.titleLabel?.text = dream.title
        cell.descriptionLabel?.text = dream.dream_description
        cell.dateLabel?.text = dream.date

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

  

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
