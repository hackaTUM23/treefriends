//
//  WaterTreeView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI




struct WaterTreeView: View {
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    @State var isThirsty = true
    @State var timer: Timer?

    var body: some View {
        Group {
            Text("Watering the tree").font(.title)
            Spacer().frame(height: 10)
            Text("This window will close as soon as the tree detects enough water in the soil.").padding(.horizontal)
            WaterTreeTreeView(isThirsty: $isThirsty, transitionDuration: 12.0).frame(height: 200)
            Spacer().frame(height: 20)
            WaterDetailView()
            HStack {
                Button("I ran out of water", action: markAsWatered).buttonStyle(.bordered)
            }
        }.onAppear(perform: {
            self.timer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: {_ in
                self.isThirsty = false
                
                Timer.scheduledTimer(withTimeInterval: 12, repeats: false) {_ in
                    model.userState = .OpenToWork
                    dismiss()
                }
            })
        })
    }
    
    func markAsWatered() {
        isThirsty.toggle()
        print("plant watered")
    }
}

#Preview {
    WaterTreeView()
}
