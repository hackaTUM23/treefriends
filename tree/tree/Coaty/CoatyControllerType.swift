//
//  CoatyControllerType.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
import CoatySwift

enum CoatyControllerType: String, CaseIterable {
//    case taskControllerPublish = "TaskControllerPublish"
    case taskControllerObserve = "TaskControllerObserve"
    case sensorControllerObserve = "SensorControllerObserve"
}

extension CoatyControllerType {
    func getControllerType() -> Controller.Type {
        switch self {
        case .taskControllerObserve:
            return TaskControllerObserve.self
        case .sensorControllerObserve:
            return SensorControllerObserve.self
        }
    }
}
