//
//  TabView.swift
//  PaperApp
//
//  Created by Sothesom on 24/09/1403.
//

import SwiftUI

struct TabsView: View {
    @State private var activeTab : TabMod = .home
    
    var body: some View {
        if #available(iOS 18, *) {
            TabView(selection: $activeTab) {
                Tab.init(value: .home){
                    
                }
            }
        }
    }
}

#Preview {
    TabsView()
}
