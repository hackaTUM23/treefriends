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
    @State var activeTab = 1
    @State var timer: Timer?
    
    
    
    var body: some View {
        TabView(selection: $activeTab) {
            Home(step: $step)
                .tabItem {
                    Label("Home", systemImage: "tree.fill")
                }
                .environmentObject(model)
                .tag(1)
            
            TreeMap(isInteractive: true)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environmentObject(model)
                .tag(2)
        }.onAppear(perform: {
            self.timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {_ in
                self.model.addDummyTask()
            })
        }).sheet(isPresented: $model.hasNewTask) {
            RequestView().environmentObject(model)
        }.onChange(of: model.userState, initial: false) {
            switch model.userState {
            case .OpenToWork:
                self.activeTab = 1
                self.step += 1
            case .Working:
                self.activeTab = 2
            }
        }
    }
}

#Preview {
    ContentView()
}
