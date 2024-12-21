//
//  RegistrationView.swift
//  PaperApp
//
//  Created by Sothesom on 01/10/1403.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var confirmPasswordText = ""

    @FocusState private var focusedField: FocusedField?
    
    @State private var isValidEmail = true
    @State private var isConfirmValidEmail = true
    
    @State private var isValidPassword = true
    @State private var isConfirmPasswordValid = true

    @State private var showSheet = false
    // بررسی پر بودن ایمیل و رمز عبور for bottom Sign in
    var canProceed: Bool {
//        isValidEmail && isValidPassword
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText) &&
        validateConfirm(confirmPasswordText)
    }

    var body: some View {
        NavigationStack{
            ZStack{
                if viewModel.isLoading {
                    ProgressView()
                }
                
                VStack{
                    Text("Create Accout")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("ColorBlue"))
                        .padding(.bottom)
                        .padding(.top, 48)
                    Text("Wellcom im my app ....\n aasfdf fgasfg sdf")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 80)
                    
                    
                    EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                    
                    
                    PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword,validatePassword: Validator.validatePassword, errorText: "Your password is not mathing", placehorder: "Password")
                    
                    PasswordTextField(passwordText: $confirmPasswordText, isValidPassword: $isConfirmPasswordValid, validatePassword: validateConfirm, errorText: "Your password is not mathing", placehorder: "Confirm password")
                        .padding(.top)
                    Spacer()
                    
                    Button{
                        Task{
                            do {
                            try? await viewModel.createUser(email: emailText, password: passwordText)
                            if !viewModel.hasError{
                                dismiss()
                            }
                        } catch {
                                print("Error: \(error)")
                            }
                        }
                    } label: {
                        Text("Sign up")
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
                        Text("Alredy have an account")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("ColorGray"))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    
                    .cornerRadius(12)
                    .padding([.horizontal, .vertical])
                    
                    
                    BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
                    
                    Spacer()
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
            }
        }
        .alert(viewModel.hasError ? "Error" : "Succes", isPresented: $viewModel.showAlert){
            if viewModel.hasError{
                Button("Try Again"){}
            } else {
                Button("Ok") {
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alterMasseg)
        }
        .sheet(isPresented: $showSheet) {
            LoginView()
        }
    }
    
    func validateConfirm(_ password: String) -> Bool {
        passwordText == password
    }
}

#Preview {
    RegistrationView()
        .environmentObject(ViewModel(servise: AppService()))
}


///https://www.youtube.com/watch?v=bSAgWUvI9mM
