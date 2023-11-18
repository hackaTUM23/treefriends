//
//  Home.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import SwiftUI
    
struct ProfileView: View {
    let size: CGFloat = 70
    
    var body: some View {
        Image("vince")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct Home: View {
    @EnvironmentObject var model: Model
    @Binding var step: Int
    @State var level: Int = 20
    @State var timer: Timer?
    let green = Color(UIColor(rgb: 0xAED655))
    
    
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(green)
                    HStack {
                        VStack {
                            HStack {
                                Image(systemName: "leaf.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                                
                                
                                Text("\(level)")
                                    .font(.system(size: 30, weight: .medium))
                                    .colorInvert()
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "crown.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(height: 15)
                                Spacer()
                            }
                        }
                        
                        
                        Spacer()
                        ProfileView()
                    }.padding()
                }
            }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
            
            //Text("Thank you for keeping Munich green!")
            Spacer()
            YoungTree(step: $step)
            Text("This is your personal tree.\nLet it grow by watering trees in Munich. \nKeep going!").multilineTextAlignment(.center).padding()
        }
    }
}




#Preview {
    Home(step: .constant(3))
}

