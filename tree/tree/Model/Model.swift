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
    
    @Published var hasNewTask: Bool = true
    
    @Published var points: Int = 20
    
}
