//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen and Jayden Morgan on 7/26/21.
//

import SwiftUI


struct ContentView: View {
    
    let headerHeight = CGFloat(120)
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            backgroundView()
            
            HeaderView().zIndex(1)
                .frame(height: headerHeight)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
