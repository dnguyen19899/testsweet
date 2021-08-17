//
//  ManualTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

import SwiftUI

struct ManualTestView: View {
    
    var body: some View {
        
        ZStack() {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            VStack {
                
                Text("Please format me")
                
            }
            .navigationBarTitle("Create a Test Manually", displayMode: .inline)
            .navigationBarColor(UIColor(hex: 0x52b69a))
        }
    }
}

struct ManualTestView_Previews: PreviewProvider {
    static var previews: some View {
        ManualTestView()
    }
}

