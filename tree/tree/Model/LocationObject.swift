//
//  LocationObject.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
protocol LocationObject: Equatable, Identifiable {
    var id: UUID { get }
    var location: LatLng {get}
    
    
}

struct LatLng: Codable, Equatable {
    let lat: Double
    let lng: Double
}

extension LatLng: CustomStringConvertible {
    var description: String {
        return "\(lat), \(lng)"
    }
}
