import UIKit
//import CoreData
import FirebaseFirestore
import FirebaseFirestoreSwift

class DreamTableViewController: UITableViewController
{
//    var dreams:[DreamEntryTable]=[]
    var user:UserTable?
    
    
    var dreamList: [DreamEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // fetchData()
        fetchDreamsFromFirestore()
    }
    func fetchDreamsFromFirestore() {
        let db = Firestore.firestore()
        db.collection("dreams").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }

            var fetchedDreams: [DreamEntry] = []

            for document in snapshot!.documents {
                let data = document.data()

                do {
                    var dream = try Firestore.Decoder().decode(DreamEntry.self, from: data)
                    dream.documentID = document.documentID // Set the documentID
                    fetchedDreams.append(dream)
                } catch {
                    print("Error decoding movie data: \(error)")
                }
            }

            DispatchQueue.main.async {
                self.dreamList = fetchedDreams
                self.tableView.reloadData()
            }
        }
    }
 /*   func fetchData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
                
        let context = appDelegate.persistentContainer.viewContext
                
        let fetchRequest: NSFetchRequest<DreamEntryTable> = DreamEntryTable.fetchRequest()
        let user_id = user?.user_id ?? 0
        print(user?.username! ?? "User Passed Incorrectly, Using default value")
        print(user_id)
        let filterPredicate = NSPredicate(format: "user_id == %@", argumentArray: [user_id])
                
        fetchRequest.predicate = filterPredicate
        do {
                dreams = try context.fetch(fetchRequest)
                tableView.reloadData()
        } catch {
                    print("Failed to fetch data: \(error)")
                }
        }
*/
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return dreams.count
        return dreamList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamEntry", for: indexPath) as! DreamTableViewCell
       // let dream = dreams[indexPath.row]
        let dream = dreamList[indexPath.row]
        cell.titleLabel?.text = dream.title.capitalized
        cell.descriptionLabel?.text = dream.dream_description.capitalized
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
                   addEditVC.dreams = dream
                   // addEditVC.user = user
                } else {
                    // Adding new movie
                    addEditVC.dreams = nil
                  //  addEditVC.user = user
                }
                addEditVC.dreamsUpdateCallback = { [weak self] in
                    self?.fetchDreamsFromFirestore()
                }
            }
        }
    }
  
}
