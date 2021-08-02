//
//  HeaderView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/30/21.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                
            HStack {
                Image(systemName: "circle.fill")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .overlay(
                           RoundedRectangle(cornerRadius: 40)
                               .strokeBorder(Color.gray, lineWidth: 5)
                       )
                Text("TESTSWEET")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(.white)
            }.padding(20)
        }
    }
}
