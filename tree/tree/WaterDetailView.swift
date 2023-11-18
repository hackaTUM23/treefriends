//
//  WaterDetailView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI

struct WaterDetailView: View {
    let estimatedLiters = 15
    let humidity = 60
    let soilHealth = 50
    
    var body: some View {
        VStack {
            HStack {
                Text("Water needed")
                Spacer()
                getWaterIndicator(liter: estimatedLiters)
            }
            soilHumidity(humidity: 70)
            fertilizer(fertilized: true)
        }.padding(.horizontal, 30)
    }
    
    func fertilizer(fertilized: Bool) -> some View {
        HStack {
            Text("Soil Fertilized")
            Spacer()
            Image(systemName: fertilized ? "checkmark.circle.fill": "x.circle.fill").foregroundColor(fertilized ? .green : .red)
        }
    }
    
    func soilHumidity(humidity: Int) -> some View {
        HStack {
            Text("Soil humidity")
            Spacer()
            Text("\(humidity)%")
        }
    }
    
    func dropType(frac: Double, thresh: Double) -> String {
        return frac > thresh ? "drop.fill" : "drop"
    }
    
    func dropColor(frac: Double, thresh: Double) -> Color {
        return frac > thresh ? .blue : .blue
    }
    
    func getWaterIndicator(liter: Int) -> some View {
        let maxLiter = 30
        let literFraction = (Double(liter) / Double(maxLiter))
        let thresh = [0.8, 0.4, 0.0]
        
        return HStack(spacing: 0) {
            ForEach(thresh, id: \.self) { t in
                Image(systemName: dropType(frac: literFraction, thresh: t)).foregroundColor(dropColor(frac: literFraction, thresh: t))
            }
            Text(" (\(liter)L)")
        }
    }
}

#Preview {
    WaterDetailView()
}
