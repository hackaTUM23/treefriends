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
    @State private var selectedResult: MKMapItem?
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
    
    var tree = Tree(id: UUID(), location: LatLng(lat: 48.152600, lng: 11.580371), humidity: 10)
        
//    var tree = Tree(id: UUID(), location: LatLng(lat: 48.263082, lng: 11.669272), humidity: 10)
    
    var waterSource = CLLocationCoordinate2D(latitude: 48.264090, longitude: 11.666800)
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: tree.location.lat, longitude: tree.location.lng)
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                Annotation("Thirsty Tree", coordinate: coordinate) {
                    WaterTreeTreeView(isThirsty: .constant(true)).frame(maxWidth: 100, maxHeight: 100)
                }.tag(1)
                Annotation("Water Source", coordinate: waterSource) {
                    Image(systemName: "drop.fill").resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue).frame(width: 50, height: 50)
                }.tag(2)
                UserAnnotation()
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            .onChange(of: selectedResult) {
                print("X")
                getDirections()
                showSheet = true
            }
            .onAppear {
                self.selectedResult = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
            }
            .sheet(isPresented: $showSheet) {
                TreeDetailView(selectedResult: self.$selectedResult).presentationDetents([.height(400)])
            }
            VStack {
                Text("location status: \(locationManager.statusString)")
                HStack {
                    Text("latitude: \(userLatitude)")
                    Text("longitude: \(userLongitude)")
                }
            }
//            LocationButton(.shareMyCurrentLocation) {
//                locationManager.requestLocation()
//            }
//            Text("\((locationManager.location ?? .init()).latitude)")
        }
    }
    
    func getDirections() {
        self.route = nil
        
        // Check if there is a selected result
        guard let selectedResult else { return }
        
        // Create and configure the request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.startingPoint))
        request.destination = self.selectedResult
        
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
