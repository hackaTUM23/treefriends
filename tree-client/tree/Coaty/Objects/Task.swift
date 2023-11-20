//
//  Tree.swift
//  Tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
import MapKit

struct Tree: Decodable, Equatable, LocationObject {
    let id: UUID
    let location: LatLon
    let moisture: Int
    let soilConductivity: Int
}

final class TreeTask: Identifiable, Equatable {
    static func == (lhs: TreeTask, rhs: TreeTask) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Class registration.
    

    
    // MARK: - Properties.
    let id: UUID
    let tree: Tree
    let waterSources: [WaterSource]
    let status: Bool
    
    // MARK: - Initializers.
    
    init(id: UUID, tree: Tree, waterSources: [WaterSource], status: Bool) {
        self.id = id
        self.tree = tree
        self.waterSources = waterSources
        self.status = status

    }
    
    // MARK: Codable methods.
    
    enum CodingKeys: String, CodingKey {
        case id
        case tree
        case waterSources = "water_sources"
        case status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.tree = try container.decode(Tree.self, forKey: .tree)
        self.waterSources = try container.decode([WaterSource].self, forKey: .waterSources)
        self.status = try container.decode(Bool.self, forKey: .status)
    }
    
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.location, forKey: .location)
//        try container.encode(self.humidity, forKey: .humidity)
//    }
    
}
