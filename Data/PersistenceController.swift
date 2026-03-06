internal import CoreData
import Foundation
import Combine

class PersistenceController: ObservableObject {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    @Published var savedEntities: [TransactionRecord] = []
    
    init() {
        container = NSPersistentContainer(name: "CurrencyTransferExplorer")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading container: \(error), \(error.userInfo)")
            }
            else {
                print("Persistence container loaded successfully")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
}
