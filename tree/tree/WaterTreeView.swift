//
//  WaterTreeView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI

struct WaterTreeDetails: View {
    let estimatedLiters = 20
    let humidity = 60
    let soilHealth = 50
    
    var body: some View {
        Text("Water Needed")
        HStack {
            Text("Soil humidity")
            Text("Fertilizer Needed")
        }
    }
}

struct WaterTreeView: View {
    var body: some View {
        Text("Please water the tree")
        WaterTreeTreeView(isThirsty: true)
        WaterTreeDetails()
    }
}

#Preview {
    WaterTreeView()
}
