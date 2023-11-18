//
//  WaterSource.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation

struct WaterSource: LocationObject {
    var id: UUID
    var location: LatLng
    
    static func == (lhs: WaterSource, rhs: WaterSource) -> Bool {
        return lhs.id == rhs.id
    }
}


