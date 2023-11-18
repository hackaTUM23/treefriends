//
//  WaterTreeTreeView.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI

struct WaterTreeTreeView: View {
    let yellow = UIColor(rgb: 0xfa7c02)
    let green = UIColor(rgb: 0x02b500)
    let yellowLight = UIColor(rgb: 0xff9127)
    let greenLight = UIColor(rgb: 0x02c600)
    @State var health: Int = 0
    
    var body: some View {
        Text("\(health)")
        ZStack(content: {
            Image("tree_trunk")
            Image("tree_head_2").renderingMode(.template)
                .foregroundColor(Color(yellow.toColor(green, percentage: CGFloat(health))))
            Image("tree_head_1").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/).foregroundColor(Color(yellowLight.toColor(greenLight, percentage: CGFloat(health))))
        }).animation(.easeInOut(duration: 0.5), value: health)
        Button("Text") {
            if (health == 0) {
                health += 100
            } else {
                health = 0
            }
        }
    }
}

#Preview {
    return VStack {
        WaterTreeTreeView()
        
    }
}

//#Preview {
//    WaterTreeTreeView(health: 50)
//}
//
//#Preview {
//    WaterTreeTreeView(health: 100)
//}
