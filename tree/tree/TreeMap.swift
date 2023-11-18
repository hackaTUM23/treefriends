//
//  TreeMap.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct TreeMap: View {
    @State private var selection: UUID?
    @State private var route: MKRoute?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.263090, longitude: 11.669253), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var showSheet = false
    
    private let startingPoint = CLLocationCoordinate2D(
        latitude: 48.233082,
        longitude: 11.649272
    )
    @StateObject var locationManager = LocationManager()

    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    // Munich
    var tree = Tree(id: UUID(), location: LatLng(lat: 48.152600, lng: 11.580371), humidity: 10)
    let trees: [Tree]
    
    // Garching
    //    var tree = Tree(id: UUID(), location: LatLng(lat: 48.263082, lng: 11.669272), humidity: 10)
    
    var waterSource = WaterSource(id: UUID(), location: LatLng(lat: 48.264090,lng: 11.666800))
    
    init() {
        self.trees = [tree]
    }
    
    var body: some View {
        Map(selection: $selection) {
            ForEach(trees){ tree in
                Marker("Tree", systemImage: "tree.fill", coordinate: CLLocationCoordinate2D(latitude: tree.location.lat, longitude: tree.location.lng)).tint(.orange)
            }
            
            Marker("Water Source", systemImage: "drop.fill", coordinate: CLLocationCoordinate2D(latitude: waterSource.location.lat, longitude: waterSource.location.lng)).tint(.blue)
            
            UserAnnotation()
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }.safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selection {
                        if let item = trees.first(where: { $0.id == selection }) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name).font(.title)
                                        Text("14 km away")
                                    }
                                    Spacer()
                                }.padding()
                                TreeDetailView(selectedResult: item)
                                    .frame(height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding([.top, .horizontal])
                                HStack {
                                    Button(action: {}) {
                                        Text("Open in Maps")
                                    }.buttonStyle(.borderedProminent)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = trees.first(where: { $0.id == selection }) else { return }
            
            
        }
        
        .onAppear {
            getDirections()
        }
        
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
    }
    
    func getDirections() {
        self.route = nil
        
        
        // Create and configure the request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.startingPoint))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tree.location.lat, longitude: tree.location.lng)))
        
        
        
        // Get the directions based on the request
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}

struct MyView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    var body: some View {
        VStack {
            Text("location status: \(locationManager.statusString)")
            HStack {
                Text("latitude: \(userLatitude)")
                Text("longitude: \(userLongitude)")
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}

#Preview {
    TreeMap()
}
