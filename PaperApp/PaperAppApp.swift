//
//  PaperAppApp.swift
//  PaperApp
//
//  Created by Sothesom on 19/09/1403.
//

import SwiftUI
import Firebase


@main
struct PaperAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        FirebaseApp.configure()

        // تست اتصال به Firebase
        if let app = FirebaseApp.app() {
            print("Firebase is successfully configured: \(app.name)")
        } else {
            print("Firebase is NOT configured.")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
