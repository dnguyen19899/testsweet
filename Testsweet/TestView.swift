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
    //var entriesList : Array<Entry>
    //var action : Int
   //var filePath: String
    
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    var body: some View {
            ZStack() {
                //Color(hex:0xcaf0f8).ignoresSafeArea()
                Color(.white).ignoresSafeArea()
                
                VStack {
                    Text(title)
                    Text(description)
                    Text(expected_result)
                    Button(action: {
                        print("running test")
                        //Delete First
                        let NSController = NightscoutController(date: Date())
                        vibrate()
                        NSController.deleteEntryRequest()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            print("Now adding points")
                            //Adding a Point
                        }
                    }, label: {
                        Text("RUN")
                    })
                }
                
                .navigationBarTitle(self.title, displayMode: .inline)
                .navigationBarColor(UIColor(hex: 0x52b69a))
            }
    }
}

/*
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(title: title, description: <#T##String#>, expected_result: <#T##String#>, entriesList: <#T##Array<Entry>#>, action: <#T##Int#>, filePath: <#T##String#>)
    }
}
*/
