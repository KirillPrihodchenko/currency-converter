internal import CoreData
import Foundation

class UserManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createUser(email: String,
                    username: String,
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
    
    func resetPassword(for user: User, newPassword: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@")
        user.password = newPassword
        
    }
    
    func readUserOrAnonymous(_ username: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let safeUsername = !username.isEmpty ? username : "Anonymous"
        fetchRequest.predicate = NSPredicate(format: "username == %@", safeUsername)
        
        if !username.isEmpty {
            return try? context.fetch(fetchRequest).first
        }
        else {
            return createUser(email: "", username: "Anonymous", password: "", createdAt: Date())
        }
    }
    
    func readAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    func readUserByCredentials(_ identifier: String, _ password: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let identifierPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                NSPredicate(format: "email == %@", identifier),
                NSPredicate(format: "username == %@", identifier)
            ])
        let passwordPredicate = NSPredicate(format: "password == %@", password)
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                identifierPredicate,
                passwordPredicate
        ])
        return try? context.fetch(fetchRequest).first
    }
    
    func userWithEmailAlreadyExist(_ email: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        return (try? context.fetch(fetchRequest).first) != nil
    }
    
    func userWithUsernameAlreadyExist(_ username: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        return (try? context.fetch(fetchRequest).first) != nil
    }
}
