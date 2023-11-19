//
//  ContentView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = Model.shared
    @State var step: Int = 2
    
    var body: some View {
        TabView {
            Home(step: $step)
                .tabItem {
                    Label("Home", systemImage: "tree.fill")
                }
                .environmentObject(model)
            
            TreeMap()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environmentObject(model)
        }.sheet(isPresented: $model.hasNewTask) {
            RequestView()
        }
    }
}

#Preview {
    ContentView()
}
