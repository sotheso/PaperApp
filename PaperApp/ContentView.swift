//
//  ContentView.swift
//  PaperApp
//
//  Created by Sothesom on 19/09/1403.
//

import SwiftUI
//
//struct ContentView: View {
//    @AppStorage("isLoggedIn") private var isLoggedIn = false
//    
//    var body: some View {
//        VStack {
//            test(isLoggedIn: $isLoggedIn)
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @EnvironmentObject var viewModel: ViewModel  // Add this line
    
    var body: some View {
        VStack {
            test(isLoggedIn: $isLoggedIn)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel(servise: AppService()))
}

