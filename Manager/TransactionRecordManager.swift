import Foundation
internal import CoreData

class TransactionRecordManager {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createTransactionRecord(currencyFrom: String,
                                 currencyTo: String,
                                 amount: Decimal,
                                 result: Decimal,
                                 user: User,
                                 status: String,
                                 createdAt: Date) -> TransactionRecord? {
        
        let transactionRecord = TransactionRecord(context: context)
        
        transactionRecord.currencyFrom = currencyFrom
        transactionRecord.currencyTo = currencyTo
        transactionRecord.amount = amount as NSDecimalNumber
        transactionRecord.result = result as NSDecimalNumber
        transactionRecord.userId = user
        transactionRecord.status = status
        transactionRecord.createdAt = createdAt
        
        do {
            try context.save()
            print("Save successful")
            return transactionRecord
        } catch let error {
            
            print("Fail to save transaction: \(error)")
            return nil
        }
    }
    
    func readAllTransactionRecords() -> [TransactionRecord] {
        
        let fetchRequest: NSFetchRequest<TransactionRecord> = TransactionRecord.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
}
