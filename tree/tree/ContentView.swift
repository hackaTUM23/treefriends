//
//  ContentView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "tree.fill")
                }
            
            TreeMap()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
}
