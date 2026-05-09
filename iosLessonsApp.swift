import SwiftUI
internal import CoreData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct iosLessonsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        
        WindowGroup {
            RootSessionView()
                .environmentObject(session)
            
        }
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
