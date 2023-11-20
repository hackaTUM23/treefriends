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
    @EnvironmentObject var model: Model
    
    @State private var selection: UUID?
    @State private var route: MKRoute?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.263090, longitude: 11.669253), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State var showSheet = false
    
    var isInteractive = true
    
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
//    var tree = Tree(id: UUID(), location: LatLon(lat: 48.152600, lon: 11.580371), moisture: 10, soilConductivity: 10)
    let trees: [Tree] = [
        Tree(id: UUID(), location: LatLon(lat:48.133884, lon: 11.576402), moisture: 9, soilConductivity: 301),
        Tree(id: UUID(), location: LatLon(lat: 48.133990, lon: 11.576275), moisture: 11, soilConductivity: 301),
        Tree(id: UUID(), location: LatLon(lat: 48.133737, lon: 11.576212), moisture: 8, soilConductivity: 301),
        Tree(id: UUID(), location: LatLon(lat: 48.134147, lon: 11.576452), moisture: 10, soilConductivity: 301),
        Tree(id: UUID(), location: LatLon(lat: 48.133021, lon: 11.576257), moisture: 30, soilConductivity: 301),
        Tree(id: UUID(), location: LatLon(lat: 48.133021, lon: 11.576257), moisture: 40, soilConductivity: 301)
    ]
   
    // Garching
    //    var tree = Tree(id: UUID(), location: LatLng(lat: 48.263082, lng: 11.669272), humidity: 10)
    
    var waterSource = WaterSource(id: UUID(), location: LatLon(lat: 48.264090, lon: 11.666800))
    
//    init() {
//        self.trees = [tree]
//    }
    
    init(isInteractive: Bool) {
        self.isInteractive = isInteractive
//        self.trees = [tree]
       
    }
    
    var body: some View {
        Map(initialPosition: .item(MKMapItem(placemark: .init(coordinate: trees[2].getCLLocationCoordinate2D() ?? startingPoint))), selection: $selection) {
            ForEach(trees){ tree in
                Marker("Tree", systemImage: "tree.fill", coordinate: tree.getCLLocationCoordinate2D()).tint(.orange)
            }
            
            Marker("Water Source", systemImage: "drop.fill", coordinate: waterSource.getCLLocationCoordinate2D()).tint(.blue)
            
            UserAnnotation()
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }.safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if selection != nil && isInteractive {
                        if let item = trees.first(where: { $0.id == selection }) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Tree").font(.title)
                                        if let userLocation =  locationManager.lastLocation {
                                            Text("\(Int(item.getCLLocation().distance(from: userLocation))) meter away from you")
                                        }
                                    }
                                    Spacer()
                                }.padding()
                                TreeDetailView(selectedResult: item)
                                    .frame(height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding([.top, .horizontal])
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "map")
                                        Text("Open in Maps").font(.headline)
                                    }.buttonStyle(.bordered).tint(.blue)
                                    Spacer()
                                    Button(action: {
                                        showSheet.toggle()
                                    }) {
                                        Image(systemName: "mappin")
                                        Text("Arrived").font(.headline)
                                    }.buttonStyle(.borderedProminent).tint(.green)
                                }.padding()
                            }
                        }
                    }
                }
                Spacer()
            }.animation(.default)
            .background(.thinMaterial)
        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = trees.first(where: { $0.id == selection }) else { return }
        }
        .onAppear {
            selection = trees[2].id
            getDirections()
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
        .sheet(isPresented: $showSheet) {
            WaterTreeView(isThirsty: true).padding()
        }
    }
    
    func getDirections() {
        self.route = nil
        
        // Create and configure the request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.lastLocation?.coordinate ?? startingPoint))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate:
//                                                                model.currentTask?.tree.getCLLocationCoordinate2D() ?? startingPoint
                                                               trees[2].getCLLocationCoordinate2D()
                                                              )
        )
        
        
        // Get the directions based on the request
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}


#Preview {
    TreeMap(isInteractive: true)
}
