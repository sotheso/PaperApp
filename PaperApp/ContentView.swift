//
//  ContentView.swift
//  PaperApp
//
//  Created by Sothesom on 19/09/1403.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        VStack {
            LoginView(isLoggedIn: $isLoggedIn)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

