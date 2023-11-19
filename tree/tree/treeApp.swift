//
//  treeApp.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

@main
struct treeApp: App {
    
    let manager = MQTTManager()

        init() {
       
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                }
                .onReceive(
                    // properly shutdown the coaty broker
                    NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
                ) { _ in
                }
        }
    }
}
