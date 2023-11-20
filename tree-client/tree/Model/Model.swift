//
//  Model.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation

class Model: ObservableObject {
    static let shared: Model = Model()
    
    private init() {}
    
    @Published var userState: UserState = .OpenToWork
    
    @Published var tasks: [TreeTask] = []
    
    @Published var currentTask: TreeTask? = nil
    
    @Published var hasNewTask: Bool = false
    
    @Published var points: Int = 20
    
    func addDummyTask() {
        self.hasNewTask = true
        self.tasks =
           [ TreeTask(id: UUID(),
                     tree: Tree(id: UUID(),
                    location: LatLon(lat: 48.152600, lon: 11.580371), moisture: 10, soilConductivity: 10),
                     waterSources: [WaterSource(id: UUID(), location: LatLon(lat: 48.264090, lon: 11.666800))],
                     status: false)]
    }
    
}
