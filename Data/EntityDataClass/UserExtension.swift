public import Foundation
public import CoreData


public typealias UserCoreDataPropertiesSet = NSSet

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var email: String
    @NSManaged public var lastLogin: Date
    @NSManaged public var password: String
    @NSManaged public var updatedAt: Date
    @NSManaged public var username: String
    @NSManaged public var userId: NSSet?
    
    var userCreatedAt: Date {
        set { createdAt = newValue }
        get { createdAt ?? Date() }
    }
    
    var userUpdatedAt: Date {
        set { updatedAt = newValue }
        get { updatedAt ?? Date() }
    }
    
    var userLastLogin: Date {
        set { lastLogin = newValue }
        get { lastLogin ?? "nil" }
    }
    
    var userUsername: String {
        set { username = newValue }
        get { username ?? "nil" }
    }
    
    var userEmail: String {
        set { email = newValue }
        get { email ?? "nil" }
    }
    
    var userPassword: String {
        set { password = newValue }
        get { password ?? "nil" }
    }
}

extension User {

    @objc(addUserIdObject:)
    @NSManaged public func addToUserId(_ value: TransactionRecord)

    @objc(removeUserIdObject:)
    @NSManaged public func removeFromUserId(_ value: TransactionRecord)

    @objc(addUserId:)
    @NSManaged public func addToUserId(_ values: NSSet)

    @objc(removeUserId:)
    @NSManaged public func removeFromUserId(_ values: NSSet)

}
