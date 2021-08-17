//
//  TestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

struct TestView: View {
    
    var title: String
    var description: String
    var expected_result: String
    
    let headerHeight = CGFloat(50)
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            ScrollView {
                
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders], content: {
                    
                    Color.clear.frame(height: headerHeight)
                        .padding()
                    
                    Text(title)
                    Text(description)
                    Text(expected_result)
                
                })
                
            }
            .navigationBarColor(UIColor(hex: 0x52b69a))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(title: "Test Title", description: "description", expected_result: "expected_result")
    }
}
