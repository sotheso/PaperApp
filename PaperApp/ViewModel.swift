//
//  ViewModel.swift
//  PaperApp
//
//  Created by Sothesom on 01/10/1403.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    private let servise: AppService
    @Published var showAlert = false
    @Published var alterMasseg: String = ""
    @Published var hasError = false
    @Published var isLoading = false
    @Published var isLoggedIn = false

    
    init(servise: AppService, showAlert: Bool = false) {
        self.servise = servise
    }
    
    
    func createUser(email: String, password: String) async throws {
        isLoading = true
        let status = try await servise.cearteUser(email: email, password: password)
        
        switch status {
            
        case .success:
            isLoading = false
            alterMasseg = "You account has been created successfully!"
            showAlert.toggle()
        case .error(let message):
            isLoading = false
            hasError = true
            alterMasseg = message
            showAlert.toggle()
        }
    }
    
    func login(email: String, password: String) async throws {
        isLoading = true
        let status = try await servise.login(email: email, password: password)
        
        switch status {
            
        case .success:
            isLoading = false
            isLoggedIn = true
        case .error(let message):
            isLoading = false
            hasError = true
            alterMasseg = message
            showAlert.toggle()
        }
    }
    
    func logout() async throws {
        isLoading = true
        let status = try await servise.logout()
        
        switch status {
            
        case .success:
            isLoading = false
            isLoggedIn = false
        case .error(let message):
            isLoading = false
            hasError = true
            alterMasseg = message
            showAlert.toggle()
        }
    }
    
}
