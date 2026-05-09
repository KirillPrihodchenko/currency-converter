import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AccountView: View {
    
    @State private var logoutButton: Bool = false
    @State private var logoutTrigger: Bool = false
    @State private var authUser: Bool = false
    @State private var alertMessage: AlertAttention = .signout
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: signed out..")
            logoutTrigger = true
            
        } catch {
            print("DEBUG: Error signing out")
        }
    }
  
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            authUser = true
        }
    }
    
    var body: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Button(){
                logoutButton = true
            } label: {
                Image(systemName: "arrow.left")
            }
            .alert(alertMessage.header,
                   isPresented: $logoutButton,
                    presenting: alertMessage) {alertAttention in
                
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .confirm) {
                    logout()
                }
                .background(.red)
                
            } message: {_ in
                Text(alertMessage.description)
            }
            .fullScreenCover(isPresented: $logoutTrigger) {
                LoginView()
            }
            .frame(maxWidth: 30, maxHeight: 30, alignment: .center)
            .font(.title2 .bold())
            .foregroundColor(.black)
            .background()
            .opacity(0.55)
            .cornerRadius(60)
            .position(x: 540, y: 30)
            
            VStack {
                Text("Welcome!")
                    .font(.largeTitle .bold())
                    .padding(.leading, -180)
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.top, 50)
            .colorInvert()
        }
        .onAppear { authenticateUser() }
    }
}

