//
//  HeaderView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/30/21.
//

import SwiftUI

//extension Color {
//    init(hex: Int, alpha: Double = 1) {
//        let components = (
//            R: Double((hex >> 16) & 0xff) / 255,
//            G: Double((hex >> 08) & 0xff) / 255,
//            B: Double((hex >> 00) & 0xff) / 255
//        )
//        self.init(
//            .sRGB,
//            red: components.R,
//            green: components.G,
//            blue: components.B,
//            opacity: alpha
//        )
//    }
//}

struct HeaderView: View {
    
    @Binding var playgroundMode: Bool
    
    var body: some View {
        ZStack {
            Color(hex:0x212529).ignoresSafeArea()
                
            HStack {
                    Button(action:{
                        playgroundMode.toggle()
                    }, label:{
                        Image(systemName: "circle.fill")
                            .font(.system(size: 45, weight: .regular))
                            .foregroundColor(Color(hex: 0x168aad))
                            .overlay(
                                   RoundedRectangle(cornerRadius: 40)
                                    .strokeBorder(Color(hex: 0x797171), lineWidth: 6)
                               )
                    })
                Text("TESTSWEET")
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundColor(.white)
            }.padding(20)
            .padding(.top, 30)
        }
    }
}
