//
//  AppService.swift
//  PaperApp
//
//  Created by Sothesom on 01/10/1403.
//

import Appwrite

enum RequestState {
    case success
    case error(_ message: String)
}
class AppService{
    let client  = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6766c69300257225bdc6")
        .setSelfSigned(true)
    
    let account: Account
    
    init(){
        account = Account(client)
    }
    
    func cearteUser(email: String, password: String) async throws -> RequestState {
        do {
            _ = try await account.create(userId: ID.unique(), email: email, password: password)
            return .success
        } catch {
            return .error(error.localizedDescription)
        }
    }
    
    func login(email: String, password: String) async throws -> RequestState {
        do {
            _ = try await account.createEmailPasswordSession(email: email, password: password)
            return .success
        } catch {
            return .error(error.localizedDescription)
        }
    }
    
    func logout() async throws -> RequestState {
        do {
            _ = try await account.deleteSession(sessionId: "currentSession")
            return .success
        } catch {
            return .error(error.localizedDescription)
        }
    }
}
