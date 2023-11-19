//
//  YoungTree.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import SwiftUI

struct YoungTree: View {
    @Binding var step: Int
    
    static let maxSteps = 5
    let scale = 70.0
    let scales = [1.0, 1.4, 1.7, 2.5, 2.5, 2.9]
    
 
    
    func young() -> some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("young_tree_younger")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: scales[step] * scale)
            }.opacity(step >= 2 ? 0 : 1)
        }
    }
    
    func older() -> some View {
        VStack {
            Spacer()
            ZStack {
                Image("young_tree_trunk")
                    .resizable()
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(
                        step == 2 ?
                            Color(green)
                        :
                            Color(brown)
                    )
                Image("young_tree_leaves")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(height: scales[step] * scale * 1.3)
                .opacity(step < 2 ? 0.0 : 1)
        }
    }
    
//    func views() -> some View {
//        if step > 2 {
//            youngest()
//        } else {
//            older()
//        }
//    }
    
    let brown = UIColor(rgb: 0x965B50)
    let green = UIColor(rgb: 0xAED655)
    var body: some View {
        VStack {
            ZStack {
                young()
                older()
            }
        }.animation(.easeInOut(duration: 2), value: step)
        
        
    }
}

struct YoungTreeTest: View {
    @State var timer: Timer?
    @State var step: Int = 0

    var body: some View {
        YoungTree(step: $step).onAppear(perform: {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
                if self.step < YoungTree.maxSteps {
                    self.step += 1
                }               else {
                    self.step = 0
                }
                
            })
        })    }
}

#Preview {
    YoungTreeTest()
}
