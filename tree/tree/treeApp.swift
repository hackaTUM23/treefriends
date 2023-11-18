//
//  treeApp.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI

@main
struct treeApp: App {
    @StateObject var delegate = CoatyDelegate()

        init() {
            UserDefaults.standard.set("broker.hivemq.com", forKey: "brokerHost")
            UserDefaults.standard.set(1883, forKey: "brokerPort")
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    self.delegate.launchContainer()
                }
                .onReceive(
                    // properly shutdown the coaty broker
                    NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
                ) { _ in
                    self.delegate.shutdownContainer()
                }
        }
    }
}
