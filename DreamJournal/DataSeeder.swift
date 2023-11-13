//
import Foundation
import UIKit
import CoreData

// TODO: Fix this to set up default data

func seedDreamData() {
    guard let url = Bundle.main.url(forResource: "dreams", withExtension: "json") else {
        print("JSON file not found.")
        return
    }
    
    guard let data = try? Data(contentsOf: url) else {
        print("Failed to read JSON file.")
        return
    }
    
    guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
        print("Failed to parse JSON.")
        return
    }
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        print("AppDelegate not found.")
        return
    }
    
    let context = appDelegate.persistentContainer.viewContext
    
    for jsonObject in jsonArray {
        let dream = DreamEntryTable(context: context)
        
        dream.dream_id = jsonObject["dream_id"] as? Int16 ?? 0
        dream.title = jsonObject["title"] as? String
        dream.category = jsonObject["category"] as? String
        dream.date = jsonObject["date"] as? String
        dream.feeling = jsonObject["feeling"] as? String
        dream.imageURL = jsonObject["imageURL"] as? String
        dream.dream_description = jsonObject["dream_description"] as? String
        dream.user_id = jsonObject["user_id"] as? Int16 ?? 0
        dream.recurringDream = jsonObject["recurringDream"] as? Bool ?? false
        
        
        // Save the context after each dream is created
        do {
            try context.save()
        } catch {
            print("Failed to save dream: \(error)")
        }
    }
    print("Dream Data seeded successfully.")
}
func seedUserData() {
    guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
        print("JSON file not found.")
        return
    }
    
    guard let data = try? Data(contentsOf: url) else {
        print("Failed to read JSON file.")
        return
    }
    
    guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
        print("Failed to parse JSON.")
        return
    }
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        print("AppDelegate not found.")
        return
    }
    
    let context = appDelegate.persistentContainer.viewContext
    
    for jsonObject in jsonArray {
        let user = UserTable(context: context)
        
        user.user_id = jsonObject["user_id"] as? Int16 ?? 0
        user.firstName = jsonObject["firstname"] as? String
        user.lastName = jsonObject["lastname"] as? String
        user.password = jsonObject["password"] as? String
        user.username = jsonObject["username"] as? String
        user.email = jsonObject["email"] as? String
        user.phoneNumber = jsonObject["phone_number"] as? String
      
        // Save the context after each dream is created
        do {
            try context.save()
        } catch {
            print("Failed to save User: \(error)")
        }
    }
    print("User Data seeded successfully.")
}

func deleteDreamData() {
    let persistentContainer = NSPersistentContainer(name: "DreamJournal")
    persistentContainer.loadPersistentStores { _, error in
        guard error == nil else {
            print("Failed to load persistent stores: \(error!)")
            return
        }
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DreamEntryTable")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All data deleted successfully.")
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }
}
func deleteUserData() {
    let persistentContainer = NSPersistentContainer(name: "DreamJournal")
    persistentContainer.loadPersistentStores { _, error in
        guard error == nil else {
            print("Failed to load persistent stores: \(error!)")
            return
        }
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All data deleted successfully.")
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }
}


