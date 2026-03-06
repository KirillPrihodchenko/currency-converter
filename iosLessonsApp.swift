import SwiftUI
internal import CoreData

@main
struct iosLessonsApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationMenu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
