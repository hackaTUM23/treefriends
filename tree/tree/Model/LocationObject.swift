//
//  LocationObject.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
import MapKit

protocol LocationObject: Equatable, Identifiable, Decodable {
    var id: UUID { get }
    var location: LatLon {get}
}

extension LocationObject {
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.location.lat, longitude: self.location.lon)
    }
    
    func getCLLocation() -> CLLocation {
        return CLLocation(latitude: self.location.lat, longitude: self.location.lon)
    }
}

struct LatLon: Decodable, Equatable {
    let lat: Double
    let lon: Double
    
    // MARK: Codable methods.
    
    enum CodingKeys: String, CodingKey {
        case lat = "latitude"
        case lon = "longitude"
    }
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
    }
}

extension LatLon: CustomStringConvertible {
    var description: String {
        return "\(lat), \(lon)"
    }
}
