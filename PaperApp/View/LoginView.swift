//
//  LoginView.swift
//  PaperApp
//
//  Created by Sothesom on 01/10/1403.
//

import SwiftUI

enum FocusedField {
    case email
    case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var emailText = ""
    @State private var passwordText = ""

    @FocusState private var focusedField: FocusedField?
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    
    @State private var showSheet = false

    // بررسی پر بودن ایمیل و رمز عبور for bottom Sign in
    var canProceed: Bool {
//        isValidEmail && isValidPassword
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText)
    }

    var body: some View {
        NavigationStack{
            if viewModel.isLoading {
                ProgressView()
            }
            VStack{
                Text("Login here")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("ColorBlue"))
                    .padding(.bottom)
                Text("Wellcom im my app ....\n aasfdf fgasfg sdf")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 80)
                
                
                EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                
                
                PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword,validatePassword: Validator.validatePassword, errorText: "Your password is not valid", placehorder: "Password")
                
                
                HStack{
                    Spacer()
                    Button{
                        
                    } label: {
                        Text("Forget password")
                            .foregroundColor(Color("ColorBlue"))
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                    .padding(.vertical)
                }
                
                
                Button{
                    Task {
                        try? await viewModel.login(email: emailText, password: passwordText)
                    }
                }label: {
                    Text("Sign in")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("ColorBlue"))
                .cornerRadius(12)
                .padding(.horizontal)
                .opacity(canProceed ? 1.0 : 0.5)
                .disabled(!canProceed)
                
                
                Button{
                    showSheet.toggle()
                }label: {
                    Text("Create new account")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("ColorGray"))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                
                .cornerRadius(12)
                .padding([.horizontal, .vertical])
                
                
                BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
            }
            .opacity(viewModel.isLoading ? 0.5 : 1.0)
        }
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("Ok") {
                isValidEmail = false
                isValidPassword = false
                emailText = ""
                passwordText = ""
            }
        } message: {
            Text(viewModel.alterMasseg)
        }
        .sheet(isPresented: $showSheet) {
            RegistrationView()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ViewModel(servise: AppService())) 
}


struct BottomView: View {
    var googleAction: () -> Void
    var facebookAction: () -> Void
    var appleAction: () -> Void

    
    
    var body: some View {
        VStack{
            Text("Or continue with")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("ColorBlue"))
                .padding(.bottom)
            
            HStack{
                Button{
                    googleAction()
                } label: {
                    Image("google-logo")
                }
                .iconButtonStyle
                
                Button{
                    facebookAction()
                } label: {
                    Image("facebook-logo")
                }
                .iconButtonStyle
                
                Button{
                    appleAction()
                } label: {
                    Image("apple-logo")
                }
                .iconButtonStyle
            }
        }
    }
}

extension View {
    var iconButtonStyle: some View {
        self
            .padding()
            .background(Color("ColorLightGray"))
            .cornerRadius(8)
    }
}


struct EmailTextField: View {
    @Binding var emailText: String
    @Binding var isValidEmail: Bool
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack{
            TextField("Email", text: $emailText)
                .focused($focusedField, equals: .email)
                .padding()
                .background(Color("ColorBlue2"))
                .cornerRadius(12)
                .background{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke( !isValidEmail ? .red : focusedField == .email ?  Color("ColorBlue"): .white, lineWidth: 3)
                }
                .padding(.horizontal)
                .onChange(of: emailText){ newValue in
                    isValidEmail = Validator.validateEmail(newValue)
                }
                .padding(.bottom, isValidEmail ? 16 : 0)

            
            if !isValidEmail {
                HStack{
                    Text("your email is not Valid")
                        .foregroundColor(.red)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
            }
        }
    }
}


struct PasswordTextField :View {
    @Binding var passwordText: String
    @Binding var isValidPassword: Bool
    let validatePassword: (String) -> Bool
    let errorText: String
    let placehorder: String
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        SecureField(placehorder, text: $passwordText)
            .focused($focusedField, equals: .password)
            .padding()
            .background(Color("ColorBlue2"))
            .cornerRadius(12)
            .background{
                RoundedRectangle(cornerRadius: 12)
                    .stroke( !isValidPassword ? .red : focusedField == .password ?  Color("ColorBlue"): .white, lineWidth: 3)
            }
            .padding(.horizontal)
            .onChange(of: passwordText){ newValue in
                isValidPassword = validatePassword(newValue)
            }
        
        if !isValidPassword {
            HStack{
                Text(errorText)
                    .foregroundColor(.red)
                    .padding(.leading)
                Spacer()
            }
        }
    }
}
