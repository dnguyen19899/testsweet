//
//  CSVTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

struct CSVTestView: View {
    
    var body: some View {
        
        ZStack() {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            VStack {
                
                Text("Please formate me")
                
            }
            .navigationBarTitle("Create a Test from CSV", displayMode: .inline)
            .navigationBarColor(UIColor(hex: 0x52b69a))
        }
    }
}

struct CSVTestView_Previews: PreviewProvider {
    static var previews: some View {
        CSVTestView()
    }
}
