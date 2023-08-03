import Foundation
import CoreData

class UserEntity: NSManagedObject {

    @NSManaged var email: String?
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: String?

}

extension UserEntity {

    static func createUser(in context: NSManagedObjectContext,
                           email: String,
                           username: String,
                           password: String,
                           firstName: String,
                           lastName: String,
                           phoneNumber: String) -> UserEntity {

        let newUser = UserEntity(context: context)
        newUser.email = email
        newUser.username = username
        newUser.password = password
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.phoneNumber = phoneNumber

        return newUser
    }
}
