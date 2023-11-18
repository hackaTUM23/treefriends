//
//  Tree.swift
//  Tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
import CoatySwift

struct LatLng: Codable, Equatable {
    let lat: Double
    let lng: Double
}

extension LatLng: CustomStringConvertible {
    var description: String {
        return "\(lat), \(lng)"
    }
}

final class Tree: CoatyObject, Identifiable {
    // MARK: - Class registration.
    
    override class var objectType: String {
        return register(objectType: "hello.coaty.Tree", with: self)
    }
    
    // MARK: - Properties.
    let id: UUID
    let location: LatLng
    let humidity: Int
    
    // MARK: - Initializers.
    
    init(id: UUID, location: LatLng, humidity: Int) {
        self.id = id
        self.location = location
        self.humidity = humidity
        super.init(coreType: .CoatyObject,
                   objectType: Tree.objectType,
                   objectId: .init(),
                   name: "Tree")
    }
    
    // MARK: Codable methods.
    
    enum CodingKeys: String, CodingKey {
        case id
        case location
        case humidity
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.location = try container.decode(LatLng.self, forKey: .location)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.humidity, forKey: .humidity)
    }
}
