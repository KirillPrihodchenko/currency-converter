import Combine
import Foundation
import SwiftUI

struct RootSessionView: View {
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        
        if session.isLoggerIn {
            NavigationMenu()
        }
        else {
            LoginView()
        }
    }
}

