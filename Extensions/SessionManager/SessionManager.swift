import Foundation
import Combine
import FirebaseAuth

class SessionManager: ObservableObject {
    
    @Published var isLoggerIn: Bool = false
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        handler = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggerIn = user != nil
            }
        }
    }
}
