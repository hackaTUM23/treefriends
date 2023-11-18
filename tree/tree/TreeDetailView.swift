//
//  TreeDetailView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
import MapKit

struct TreeDetailView: View {
    @State private var lookAroundScene: MKLookAroundScene?
    var selectedResult: Tree
    
    var body: some View {
        VStack {
            LookAroundPreview(initialScene: lookAroundScene)
                .overlay(alignment: .bottomTrailing) {
                    HStack {
                        Text("\(selectedResult.id)")
                    }
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(18)
                }
                .onAppear {
                    getLookAroundScene()
                }
                .onChange(of: selectedResult) {
                    getLookAroundScene()
                }
        }
    }
    
    func getLookAroundScene() {
        lookAroundScene = nil
        
        Task {
            let request = MKLookAroundSceneRequest(coordinate: CLLocationCoordinate2D(latitude: selectedResult.location.lat, longitude: selectedResult.location.lon))
            lookAroundScene = try? await request.scene
        }
    }
}

//#Preview {
//    TreeDetailView(selectedResult: .constant(nil))
//}
