//
//  TreeDetailView.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
import MapKit

struct TreeDetailView: View {
    @State var lookAroundScene: MKLookAroundScene?
    @Binding var selectedResult: MKMapItem?
    
    var body: some View {
        VStack {
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", image: "eye.slash")
            }
            Spacer()
            Button(action: {}) {
                Text("Open in Maps")
                
            }.buttonStyle(.borderedProminent)
        }
    }
    
    func fetchPreview() {
        if let selectedResult {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: selectedResult)
                lookAroundScene = try? await request.scene
            }
        }
    }
}

//#Preview {
//    TreeDetailView(, selectedResult: .constant())
//}
