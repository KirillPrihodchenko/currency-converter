import Foundation
import SwiftUI
internal import CoreData

struct SignupView: View {
    
    @State private var signupEmailField: String = ""
    @State private var signupUsernameField: String = ""
    @State private var signupPasswordField: String = ""
    @State private var signupConfirmPasswordField: String = ""
    @State private var loginButtonClicked: Bool = false
    @State private var signupButtonClicked: Bool = false
    @FocusState private var signupEmailSelectedField: Bool
    @FocusState private var signupUsernmaeSelectedField: Bool
    @FocusState private var signupPasswordSelectedField: Bool
    @FocusState private var signupPasswordConfirmSelectedField: Bool
    private let userManagerVM: UserManager
    @State private var signupErrorAlert: Bool = false
    @State private var userAlreadyExists: CurrencyInputError = .userAlreadyExists
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        userManagerVM = UserManager(context: context)
    }
    
    private func resetFields() {
        signupEmailField = ""
        signupUsernameField = ""
        signupPasswordField = ""
        signupConfirmPasswordField = ""
    }
    
    private var fullFormIsValid: Bool {
        return !signupEmailField.isEmpty &&
               signupEmailField.contains("@") &&
               signupEmailField.count > 4 &&
               !signupPasswordField.isEmpty &&
               !signupConfirmPasswordField.isEmpty &&
               signupPasswordField.elementsEqual(signupConfirmPasswordField)
    }
    
    private var usernameFieldIsValid: Bool {
        return !signupUsernameField.isEmpty && signupUsernameField.count < 5
    }
    
    private var changingButtonColor: Color {
        return fullFormIsValid ? Color.blue : Color.gray
    }
    
    private var additionalEmailTextFieldWarning: String {
        while usernameFieldIsValid {
            return "Must be more than 4 characters."
        }
        return ""
    }

    var body: some View {
            ZStack {
                Image("background")
                VStack {
                    Text("Welcome!")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, -78)
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
                        Text("Sign Up")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                        
                        TextField("Email*", text: $signupEmailField)
                            .padding(.leading)
                            .keyboardType(.emailAddress)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(signupEmailSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .padding(.top, 3)
                            .clipShape(RoundedRectangle(cornerRadius: 17))
                            .focused($signupEmailSelectedField)
                        
                        TextField("Username*", text: $signupUsernameField)
                            .padding(.leading)
                            .keyboardType(.emailAddress)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(signupUsernmaeSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .padding(.top, 12)
                            .clipShape(RoundedRectangle(cornerRadius: 17))
                            .focused($signupUsernmaeSelectedField)
                        
                        Text(additionalEmailTextFieldWarning)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .padding(.leading, -40)
                        
                        SecureField("Password*", text: $signupPasswordField)
                            .padding(.leading)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(signupPasswordSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .padding(.top, 5)
                            .focused($signupPasswordSelectedField)
                            .textContentType(.oneTimeCode)
                            .padding(5)
                        
                        SecureField("Confirm password*", text: $signupConfirmPasswordField)
                            .padding(.leading)
                            .frame(width: 250, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 27)
                                    .fill(.white)
                                    .strokeBorder(signupPasswordConfirmSelectedField ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .foregroundStyle(Color.black)
                            .cornerRadius(50)
                            .focused($signupPasswordConfirmSelectedField)
                            .textContentType(.oneTimeCode)
                            .padding(10)
                        
                        Button("Sign up") {
                            
                            if userManagerVM.userWithEmailAlreadyExist(signupEmailField) {
                                signupErrorAlert.toggle()
                                
                            }
                            else {
                                userManagerVM.createUser(email: signupEmailField,
                                                         username: signupUsernameField,
                                                         password: signupPasswordField,
                                                         createdAt: Date())
                                signupButtonClicked.toggle()
                            }
                        }
                        .alert(userAlreadyExists.localizedDescription, isPresented: $signupErrorAlert) {
                            
                        } message: {
                            Text(userAlreadyExists.errorDescription)
                        }
                        .frame(maxWidth: 250, maxHeight: 40)
                        .foregroundStyle(Color.white)
                        .background(changingButtonColor)
                        .cornerRadius(50)
                        .padding(.top, 30)
                        .disabled(!fullFormIsValid)
                        .fullScreenCover(isPresented: $signupButtonClicked) {
                            LoginView()
                        }
                        
                        Button() {
                            
                        } label: {
                            HStack() {
                                Image("Google_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.8)
                                    .frame(width: 24, height: 24)
                                Text("Sign up via Google")
                                    .foregroundStyle(.black.opacity(0.8))
                                    .transition(.opacity)
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: 250, maxHeight: 40)
                        .background(Color.white)
                        .cornerRadius(50)
                        .padding(.top, 5)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 80)
                    
                }
                .frame(maxWidth: 350)
                .background(.black.opacity(0.3))
                .cornerRadius(50)
                
                HStack(alignment: .center) {
                    Text("Already have an account?")
                        .foregroundStyle(.white)
                        .font(.system(size: 15))
                    
                    Button("Log in") {
                        loginButtonClicked.toggle()
                    }
                    .fullScreenCover(isPresented: $loginButtonClicked) {
                        LoginView()
                    }
                }
                .font(.system(size: 15))
                .padding(.top, 450)
                
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
    SignupView()
}
