//
//  RequestView.swift
//  tree
//
//  Created by Sandesh Sharma on 19.11.23.
//

import SwiftUI

struct RequestView: View {
    var body: some View {
        Text("Watering Request").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).fontWeight(.bold).padding()
        WaterTreeTreeView(isThirsty: .constant(true))
            .padding()
            .frame(width: 150)
        WaterDetailView()
        TreeMap(isInteractive: false).cornerRadius(20).padding()
        HStack {
            Button("Accept", action: accept).buttonStyle(.borderedProminent)
            Button("Reject", action: deny).buttonStyle(.bordered)
        }
        Spacer()
    }
    
    func accept() {
        print("accept")
    }
    
    func deny() {
        print("deny")
    }
}

#Preview {
    RequestView()
}
