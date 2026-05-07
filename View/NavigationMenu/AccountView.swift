import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AccountView: View {
    
    @State private var logoutButton: Bool = false
    @State private var logoutTrigger: Bool = false
    @State private var alertMessage: AlertAttention = .signout
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: signed out..")
        } catch {
            print("DEBUG: Error signing out")
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
                   isPresented: $logoutTrigger,
                    presenting: alertMessage) {alertAttention in
                
                Button("Cancel", role: .cancel) { }
                Button("Confirm", role: .confirm) {
                    logout()
                }
                
            } message: {_ in
                Text(alertMessage.description)
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
    }
}
