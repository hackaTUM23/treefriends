//
//  RequestView.swift
//  tree
//
//  Created by Sandesh Sharma on 19.11.23.
//

import SwiftUI

struct RequestView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        Text("Watering Request")
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .fontWeight(.bold)
            .padding()
        WaterTreeTreeView(isThirsty: .constant(true))
            .padding()
            .frame(width: 120)
        WaterDetailView()
        TreeMap(isInteractive: false).cornerRadius(20).padding()
        HStack {
            Button("Reject", action: deny).buttonStyle(.bordered)
            Button("Accept", action: accept).buttonStyle(.borderedProminent)
        }
        Spacer()
    }
    
    func accept() {
        print("accept")
        model.hasNewTask = false
        print(model.tasks)
        model.currentTask = model.tasks[2]
        model.userState = .Working
    }
    
    func deny() {
        model.hasNewTask = false
        print("deny")
    }
}

#Preview {
    RequestView()
}
