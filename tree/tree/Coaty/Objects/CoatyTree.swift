//
//  CoatyTree.swift
//  tree
//
//  Created by Nikolai Madlener on 19.11.23.
//

import Foundation
import CoatySwift

final class CoatyTree: CoatyObject, Identifiable, Equatable {
    static func == (lhs: CoatyTree, rhs: CoatyTree) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Class registration.
    
    override class var objectType: String {
        return register(objectType: "hello.coaty.Tree", with: self)
    }
    
    // MARK: - Properties.
    let id: UUID
    let location: LatLon
    let moisture: Int
    let soilConductivity: Int
    
    // MARK: - Initializers.
    
    init(id: UUID, location: LatLon, moisture: Int, soilConductivity: Int) {
        self.id = id
        self.location = location
        self.moisture = moisture
        self.soilConductivity = soilConductivity
        super.init(coreType: .CoatyObject,
                   objectType: TreeTask.objectType,
                   objectId: .init(),
                   name: "Tree")
    }
    
    // MARK: Codable methods.
    
    enum CodingKeys: String, CodingKey {
        case id
        case location
        case moisture
        case soilConductivity
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.location = try container.decode(LatLon.self, forKey: .location)
        self.moisture = try container.decode(Int.self, forKey: .moisture)
        self.soilConductivity = try container.decode(Int.self, forKey: .soilConductivity)
        try super.init(from: decoder)
    }
}
    
