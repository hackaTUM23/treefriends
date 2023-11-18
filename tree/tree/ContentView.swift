//
//  ContentView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = Model.shared
    
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "tree.fill")
                }
                .environmentObject(model)
            
            TreeMap()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environmentObject(model)
        }
    }
}

#Preview {
    ContentView()
}
