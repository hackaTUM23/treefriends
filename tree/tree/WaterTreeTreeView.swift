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
    @State var isThirsty = true
    var health: Int {
        get {
            return isThirsty ? 0 : 100
        }
    }
    
    var body: some View {
        ZStack(content: {
            Image("tree_trunk")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("tree_head_2")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(yellow.toColor(green, percentage: CGFloat(health))))
            Image("tree_head_1")
                .resizable()
                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                .aspectRatio(contentMode: .fit).foregroundColor(Color(yellowLight.toColor(greenLight, percentage: CGFloat(health))))
        }).animation(.easeInOut(duration: 0.5), value: health)
        
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
