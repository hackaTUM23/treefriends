//
//  TreeMap.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
import MapKit

struct TreeMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.263090, longitude: 11.669253), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    var tree = Tree(id: UUID(), location: LatLng(lat: 48.263082, lng: 11.669272), humidity: 10)
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: tree.location.lat, longitude: tree.location.lng)
        Map {
            Annotation("Thirsty Tree", coordinate: coordinate) {
                Image(systemName: "tree")
            }
        }
    }
}

#Preview {
    TreeMap()
}
