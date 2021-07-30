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
                Text("TESTSWEET")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(.white)
            }.padding(20)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
