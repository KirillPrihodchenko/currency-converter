import Foundation
import SwiftUI

struct ResetPassword: View {
    
    @State private var resetEmailField: String = ""
    @State private var backToLoginPage: Bool = false
    @FocusState private var resetField: Bool
    
    private var fullFormIsValid: Bool {
        return !resetEmailField.isEmpty &&
               resetEmailField.contains("@")
    }
    
    private var changingButtonColor: Color {
        return fullFormIsValid ? Color.blue : Color.gray
    }
    
    var body: some View {
        ZStack {
            Image("background")
            
            VStack {
                Text("Reset Password")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Make sure you enter valid email")
                    .padding(.leading, 30)
            }
            .foregroundStyle(Color.white)
            .frame(alignment: .leadingFirstTextBaseline)
            .padding(.bottom, 720)
            .padding(.leading, -130)
     
                
            HStack {
                VStack(alignment: .center) {
                    
                    TextField("Enter email for reset", text: $resetEmailField)
                        .padding(.leading)
                        .keyboardType(.emailAddress)
                        .frame(width: 320, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 27)
                                .fill(.white)
                                .strokeBorder(resetField ? Color.blue : Color.clear, lineWidth: 2)
                        )
                        .foregroundStyle(Color.black)
                        .cornerRadius(50)
                        .padding(.top, 3)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                        .focused($resetField)
                        .padding(.bottom, 30)
                    
                    Button("Send an Email") {}
                        .frame(maxWidth: 250, maxHeight: 40)
                        .foregroundStyle(Color.white)
                        .background(changingButtonColor)
                        .cornerRadius(50)
                        
                    Button("Back to Login") {
                        backToLoginPage.toggle()
                    }
                    .frame(maxWidth: 250, maxHeight: 40)
                    .foregroundStyle(Color.black)
                    .background(.white)
                    .cornerRadius(50)
                    .padding(.top, 15)
                    .fullScreenCover(isPresented: $backToLoginPage) {
                        LoginView()
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 30)
            }
            .frame(maxWidth: 350)
            .background(.black.opacity(0.3))
            .cornerRadius(50)
        }
    }
}

#Preview {
    ResetPassword()
}
