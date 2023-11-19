//
//  RequestView.swift
//  tree
//
//  Created by Sandesh Sharma on 19.11.23.
//

import SwiftUI

struct RequestView: View {
    var body: some View {
        Text("Watering Request Received").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        WaterTreeTreeView(isThirsty: .constant(true))
            .padding()
            .frame(width: 150)
        WaterDetailView()
        TreeMap().cornerRadius(20).padding()
        HStack {
            Button("Accept", action: accept).buttonStyle(.borderedProminent)
            Button("Reject", action: deny).buttonStyle(.bordered)
        }
        
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
