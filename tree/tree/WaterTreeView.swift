//
//  WaterTreeView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI




struct WaterTreeView: View {
    @State var isThirsty = true
    var body: some View {
        Text("Watering the tree").font(.title)
        Spacer().frame(height: 10)
        Text("This window will close as soon as the tree detects enough water in the soil.").padding(.horizontal)
        WaterTreeTreeView(isThirsty: $isThirsty).frame(height: 200)
        Spacer().frame(height: 20)
        WaterDetailView()
        HStack {
            Button("I ran out of water", action: markAsWatered).buttonStyle(.bordered)
        }
    }
    
    func markAsWatered() {
        isThirsty.toggle()
        print("plant watered")
    }
}

#Preview {
    WaterTreeView()
}
