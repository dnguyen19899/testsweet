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
    var body: some View {
        ZStack {
            Color(hex:0x212529).ignoresSafeArea()
                
            HStack {
                Image(systemName: "circle.fill")
                    .font(.system(size: 50, weight: .regular))
                    .foregroundColor(Color(hex: 0x0077b6))
                    .overlay(
                           RoundedRectangle(cornerRadius: 40)
                               .strokeBorder(Color.gray, lineWidth: 5)
                       )
                Text("TESTSWEET")
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundColor(.white)
            }.padding(20)
        }
    }
}
