import Foundation
import SwiftUI


struct LoginView: View {
    
    @State private var loginEmailField: String = ""
    @State private var loginPasswordField: String = ""
    @State private var loginClicked: Bool = false
    @State private var signupClicked: Bool = false
    @FocusState private var loginEmailSelectedField: Bool
    @FocusState private var loginPasswordSelectedField: Bool
    
    private var chatMessageIsValid: Bool {
        return !loginEmailField.isEmpty && loginEmailField.count > 4
    }
    
    private var emailFieldIsValid: Bool {
        return !loginEmailField.isEmpty && loginEmailField.count <= 4
    }
    
    private var changingButtonColor: Color {
        return chatMessageIsValid ? Color.blue : Color.gray
    }
    
    private var additionalTextFieldWarning: String {
        while emailFieldIsValid {
            return "Must be more than 4 characters."
        }
        return ""
    }
    
    var body: some View {
            ZStack {
                Image("background")
                VStack {
                    Text("Welcome back!")
                        .font(.largeTitle)
                        .bold()
                    Text("enjoy your time <3")
                        .font(.title3)
                        .padding(.leading, -78)
                }
                .foregroundStyle(Color.white)
                .frame(alignment: .leadingFirstTextBaseline)
                .padding(.bottom, 720)
                .padding(.leading, -100)
                
                
                HStack() {
                    VStack(alignment: .center) {
                        Text("Log In")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                        
                        TextField("Username or Email*", text: $loginEmailField)
                            .padding(.leading)
                            .keyboardType(.emailAddress)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(loginEmailSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .padding(.top, 5)
                            .clipShape(RoundedRectangle(cornerRadius: 17))
                            .focused($loginEmailSelectedField)
                        
                        Text(additionalTextFieldWarning)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .padding(.leading, -40)
                        
                        SecureField("Password*", text: $loginPasswordField)
                            .padding(.leading)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(loginPasswordSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .padding(.top, 5)
                            .focused($loginPasswordSelectedField)
                            .padding(5)
                        
                        HStack() {
                            Text("Forget your password?")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .transition(.opacity)
                            Button("Reset") {
                                
                            }.font(.system(size: 14))
                        }
                        .padding(.leading, -55)
                        
                        Button("Log In") {
                            
                            loginClicked.toggle()
                            
                        }
                        .frame(maxWidth: 250, maxHeight: 40)
                        .foregroundStyle(Color.white)
                        .background(changingButtonColor)
                        .cornerRadius(50)
                        .padding(.top, 30)
                        .disabled(!chatMessageIsValid)
                        
                        Button() {
                            
                        } label: {
                            HStack() {
                                Image("Google_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.8)
                                    .frame(width: 24, height: 24)
                                Text("Login via Google")
                                    .foregroundStyle(.black.opacity(0.8))
                                    .transition(.opacity)
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: 250, maxHeight: 40)
                        .background(Color.white)
                        .cornerRadius(50)
                        .padding(.top, 5)
                        
                        Button("Log In as Guest") { }
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundStyle(Color.white)
                            .background(.blue)
                            .cornerRadius(50)
                            .padding(.top, 5)
                        
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 130)
                    
                }
                .frame(maxWidth: 350)
                .background(.black.opacity(0.3))
                .cornerRadius(50)
                
                HStack(alignment: .center) {
                    Text("Still don't have an account?")
                        .foregroundStyle(.white)
                        .font(.system(size: 15))
                    
                    Button("Sign Up") {
                        signupClicked.toggle()
                    }
                    .fullScreenCover(isPresented: $signupClicked) {
                        SignupView()
                    }
                }
                .font(.system(size: 15))
                .padding(.top, 350)
                
                Button() {
                    
                } label: {
                    HStack(alignment: .bottom) {
                        Link(destination: URL(string:"https://www.linkedin.com/in/kyrylo-prykhodchenko-a748b2243/")!) {
                            Image("linkedin_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.white)
                                .background(.blue)
                            Text("Author")
                                .foregroundStyle(.white)
                                .font(.system(size: 15))
                        }
                    }
                }
                .frame(maxWidth: 80, maxHeight: 22)
                .background(.black.opacity(0.3))
                .cornerRadius(50)
                .padding(.top, 755)
                .padding(.leading, 280)
        }
    }
}

#Preview {
    
    LoginView()
}
