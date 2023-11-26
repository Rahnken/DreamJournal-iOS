import UIKit

import FirebaseFirestore
import FirebaseFirestoreSwift

class DreamTableViewController: UITableViewController
{
    var dreamList:[DreamEntryTable]=[]
    var user:UserTable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDreamsFromFirestore()
    }
    func fetchDreamsFromFirestore() {
        let db = Firestore.firestore()
        db.collection("dreams").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            var fetchedDreams: [DreamEntryTable] = []
            
            for document in snapshot!.documents {
                let documentID = document.documentID
                var dreamData = document.data()
                
                // Process data as needed from the document snapshot
                // For instance, if your DreamEntryTable has properties like "title" and "description":
                let title = dreamData["title"] as? String ?? ""
                let description = dreamData["description"] as? String ?? ""
                var dream : DreamEntryTable?
                // Create a DreamEntryTable instance using the extracted data
                if let dream = dream {
                    dream.title = title
                    dream.dream_description = description
                }
                fetchedDreams.append(dream!)
            }
            
            DispatchQueue.main.async {
                self.dreamList = fetchedDreams
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dreamList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamEntry", for: indexPath) as! DreamTableViewCell
        let dream = dreamList[indexPath.row]
        
        cell.titleLabel?.text = dream.title?.capitalized
        cell.descriptionLabel?.text? = dream.dream_description!.capitalized
        cell.dateLabel?.text = dream.date

        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "AddEditDream", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddEditDream"
        {
            if let addEditVC = segue.destination as? AddJournalEntryViewController
            {
                if let indexPath = sender as? IndexPath
                {
                   // Editing existing movie
                   let dream = dreamList[indexPath.row]
                   addEditVC.dream = dream
                    addEditVC.user = user
                } else {
                    // Adding new movie
                    addEditVC.dream = nil
                    addEditVC.user = user
                }
            }
        }
    }
  
}
