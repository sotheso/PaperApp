//
//  CategoryView.swift
//  PaperApp
//
//  Created by Sothesom on 20/09/1403.
//

import SwiftUI


struct CategoryView: View {
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    
    @State private var activeTab: CategoryMod = .All
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack(spacing: 0){
                    CustomTabBar(activeTab: $activeTab)
                }
            }
            .navigationTitle("Category View")
            .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .automatic))
        }
        
    }
}
struct CustomTabBar: View {
    @Binding var activeTab: CategoryMod
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        GeometryReader { _ in
            HStack(spacing: 8) {
                HStack(spacing: activeTab == .All ? -15 : 8) {
                    // استفاده از allCases به جای CaseIterable
                    ForEach(CategoryMod.allCases.filter({ $0 != .All}), id: \.rawValue) { tab in
                        ResizevleTabButton(tab)
                    }
                }
                if activeTab == .All{
                    ResizevleTabButton(.All)
                        .transition(.offset(x:200))
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: 50)
    }

// کلید های دسته بندی ها
    @ViewBuilder
    func ResizevleTabButton(_ tab: CategoryMod) -> some View {
        HStack(spacing: 8) {
            Image(systemName: tab.symbolImage)
                .opacity(activeTab != tab ? 1 : 0)
            // For animation
                .overlay {
                    Image(systemName: tab.symbolImage)
                        .symbolVariant(.fill)
                        .opacity(activeTab == tab ? 1 : 0)
                }

            if activeTab == tab {
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(tab == .All ? schemeColor : activeTab == tab ? .white : .gray)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: activeTab == tab ? .infinity: nil)
        .padding(.horizontal, activeTab == tab ? 10 : 20)
        .background {
            Rectangle()
                .fill(activeTab == tab ? tab.color : .gray.opacity(0.16))
        }
        .clipShape(.rect(cornerRadius: 20, style: .continuous))
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.background)
                .padding(activeTab == .All && tab != .All ? -3 : 3)
        }
        .contentShape(.rect)
        .onTapGesture {
            guard tab != .All else { return }
            withAnimation(.bouncy){
                if activeTab == tab {
                    activeTab = .All
                } else {
                    activeTab = tab
                }
            }
        }
    }
    var schemeColor: Color {
        scheme == .dark ? .black : .white
    }
}

#Preview {
    CategoryView()
}
