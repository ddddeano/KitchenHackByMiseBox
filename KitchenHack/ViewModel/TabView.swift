//
//  TabView.swift
//  KitchenHack
//
//  Created by Daniel Watson on 25/02/2021.
//

import SwiftUI
import Combine

class TabsViewModel: ObservableObject {
    @Published var selectedTab = "Ingredients"
}
struct TabsView: View {
    
    @StateObject var VM = TabsViewModel()
    
    var body: some View {
        TabView(selection: $VM.selectedTab) {
            IngredientsView()
                .tabItem{
                    Label("Ingredients", systemImage: "square.and.pencil")
                }.tag("Ingredients")
            SuppliersView()
                .tabItem{
                    Label("Suppliers", systemImage: "pencil")
                }.tag("Suppliers")
            PurchasesView()
                .tabItem{
                    Label("Purchases", systemImage: "wifi")
                }.tag("Purchases")
        }
    }
}
