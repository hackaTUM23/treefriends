//
//  ContentView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

struct ContentView: View {
    @State var step: Int = 2
    
    var body: some View {
        TabView {
            Home(step: $step)
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
