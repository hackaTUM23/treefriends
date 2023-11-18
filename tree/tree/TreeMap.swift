//
//  TreeMap.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
import MapKit

struct TreeMap: View {
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.263090, longitude: 11.669253), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State var showSheet = false
    private let startingPoint = CLLocationCoordinate2D(
        latitude: 48.233082,
        longitude: 11.649272
    )
    
    var tree = Tree(id: UUID(), location: LatLng(lat: 48.152600, lng: 11.580371), humidity: 10)
    
//    var tree = Tree(id: UUID(), location: LatLng(lat: 48.263082, lng: 11.669272), humidity: 10)
    
    var waterSource = CLLocationCoordinate2D(latitude: 48.264090, longitude: 11.666800)
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: tree.location.lat, longitude: tree.location.lng)
        ZStack {
            Map(selection: $selectedResult) {
                Annotation("Thirsty Tree", coordinate: coordinate) {
                    WaterTreeTreeView(isThirsty: true).frame(maxWidth: 100, maxHeight: 100)
                }
                Annotation("Water Source", coordinate: waterSource) {
                    Image(systemName: "drop.fill").resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue).frame(width: 50, height: 50)
                }
                
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

#Preview {
    TreeMap()
}
