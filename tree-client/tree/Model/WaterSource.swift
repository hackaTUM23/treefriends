//
//  WaterSource.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation

struct WaterSource: LocationObject, Decodable {
    var id: UUID
    var location: LatLon
    
    static func == (lhs: WaterSource, rhs: WaterSource) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: Codable methods.
    
    enum CodingKeys: String, CodingKey {
        case id
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.location = try container.decode(LatLon.self, forKey: .location)
    }
    
    init(id: UUID, location: LatLon) {
        self.id = id
        self.location = location
    }
}


