internal import CoreData
import Foundation

class UserManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createUser(username: String,
                    email: String,
                    password: String,
                    createdAt: Date) -> User? {
        
        let user = User(context: context)
        user.username = username
        user.email = email
        user.password = password
        user.createdAt = createdAt
        
        do {
            try context.save()
            return user
        } catch let error {
            print("Fail to save user: \(error)")
            return nil
        }
    }
    
    func readUserOrAnonymous(_ username: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let safeUsername = !username.isEmpty ? username : "Anonymous"
        fetchRequest.predicate = NSPredicate(format: "username == %@", safeUsername)
        
        if !username.isEmpty {
            return try? context.fetch(fetchRequest).first
        }
        else {
            return createUser(username: "Anonymous", email: "", password: "", createdAt: Date())
        }
    }
    
    func readAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
}
