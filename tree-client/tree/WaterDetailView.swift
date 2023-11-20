//
//  WaterDetailView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI



struct WaterDetailView: View {
    let estimatedLiters = 25
    let humidity = 30
    let isFertilized = true
    let recommendedWateringTime: Date = Date(timeIntervalSinceNow: 3.0 * 60 * 60)
    let dateLastRain = Date(timeIntervalSinceNow: -13.0 * 60 * 60 * 24)
    let dateNextRain = Date(timeIntervalSinceNow: 5.0 * 60 * 60 * 24)
    let dateFormatter = DateFormatter()
    let dateIntervalFormatter = DateIntervalFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    init() {
        dateFormatter.dateFormat = "HH:mm"
        dateIntervalFormatter.dateStyle = .short
        dateIntervalFormatter.timeStyle = .none
    }
    
    // zeit naechster niederschlag
    // kein niederschlag seit
    // avg min max temp
    
    var body: some View {
        
        List {
//            Section(header: Text("Tree Data")) {
                HStack {
                    Text("Water needed")
                    Spacer()
                    getWaterIndicator(liter: estimatedLiters)
                }
                soilHumidity(humidity: humidity)
//            }
            //Section(header: Text("Watering Info")) {
                //fertilizer(fertilized: isFertilized)
                HStack {
                    Text("Watering Time")
                    Spacer()
                    Text("\(dateFormatter.string(from: recommendedWateringTime))")
                    Image(systemName: "info.circle")
                }
                HStack {
                    Text("Last rain")
                    Spacer()
                    Text("\(getInterval(start: dateLastRain, end: Date())) days ago")
                }
                HStack {
                    Text("Next rain")
                    Spacer()
                    Text("In \(getInterval(start: Date(), end: dateNextRain)) days")
                }
//            }
//            Section(header: Text("Weather Info")) {
                HStack {
                    Text("Current Temperature")
                    Spacer()
                    Text("38°C")
                }
//            }
        }.listStyle(.plain)
    }
    
    func getInterval(start: Date, end: Date) -> Int {
        let dateComponent = calendar.dateComponents([Calendar.Component.day], from: calendar.startOfDay(for: start), to: calendar.startOfDay(for: end))
        return dateComponent.day!
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
