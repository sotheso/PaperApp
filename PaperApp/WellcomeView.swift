//
//  LoginSignView.swift
//  PaperApp
//
//  Created by Sothesom on 01/10/1403.
//

import SwiftUI

enum ViewStack {
    case login
    case registration
}

struct WellcomeView: View {
    @StateObject private var viewModel = ViewModel(servise: AppService())

    @State private var presentNextView = false
    @State private var nexView: ViewStack = .login
    
    var body: some View {
        NavigationStack{
            VStack{
                Image("work-from-home")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .padding(.top, 24)
                
                Spacer()
                
                Text("Discover Your Dream Job")
                    .font(.system(size: 35, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("ColorBlue"))
                    .padding(.bottom, 8)
                
                Text("enumesav ...")
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 12){
                    Button{
                        nexView = .login
                        presentNextView.toggle()
                    } label: {
                        Text("Login")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 160, height: 60)
                    .background(Color("ColorBlue"))
                    .cornerRadius(12)
                    
                    Button {
                        nexView = .registration
                        presentNextView.toggle()
                    } label: {
                        Text("Register")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 160, height: 60)

                }
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $presentNextView) {
                switch nexView {
                case .login:
                    LoginView()
                        .environmentObject(viewModel)
                case .registration:
                    RegistrationView()
                        .environmentObject(viewModel)  // Add this line

                }
            }
        }
    }
}

#Preview {
    WellcomeView()
}
