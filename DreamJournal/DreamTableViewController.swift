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
                   let dream = dreams[indexPath.row]
                   addEditVC.dream = dream
                } else {
                    // Adding new movie
                    addEditVC.dream = nil
                }
            }
        }
    }
  
}
