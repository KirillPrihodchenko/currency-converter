public import Foundation
public import CoreData


public typealias TransactionRecordCoreDataPropertiesSet = NSSet

extension TransactionRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionRecord> {
        return NSFetchRequest<TransactionRecord>(entityName: "TransactionRecord")
    }

    @NSManaged public var currencyFrom: String
    @NSManaged public var currencyTo: String
    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var result: NSDecimalNumber
    @NSManaged public var createdAt: Date
    @NSManaged public var status: String
    @NSManaged public var userId: User?
  
    var transactionCreatedAt: Date {
        set { createdAt = newValue }
        get { createdAt ?? Date() }
    }
    
    var transactionStatus: String {
        set { status = newValue }
        get { status ?? "nil" }
    }
}
