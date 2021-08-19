//
//  TestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

struct TestView: View {
    
    var test: Test
    @State var CGMPoints: Int64 = 0
    @State var addScreen: Bool = false
    @State var deleteScreen: Bool = false
    @State var showSugarView: Bool = false
    @State var expectedResult = ""
    
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
                //Color(hex:0xcaf0f8).ignoresSafeArea()
                Color(.white).ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        Text("Description:")
                        Text(test.description)
                    }
                    .padding(.top)
                    .padding(.bottom, 2)
                    VStack {
                        Text("Expected Result:")
                        Text(test.expected_result)
                    }
                    .padding()
                    Spacer()
                    HStack{
                        Button(action: {
                            print("running test")
                            //Delete First
                            let NSController = NightscoutController(date: Date())
                            vibrate()
                            deleteScreen = true
                            NSController.deleteEntryRequest()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                print("Now adding points")
                                deleteScreen = false
                                let result = test.run()
                                CGMPoints = result.0
                                expectedResult = result.1
                                addScreen = true
                                let secondsToDelay = (Double(CGMPoints) / 26) + 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                    print("The adding is truly done")
                                    addScreen = false
                                    showSugarView = true
                                }
                            }
                            
                            
                            
                        }, label: {
                            Text("RUN")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                .frame(width: 100, height: 50)
                                .background(Color(hex: 0x52b69a))
                                .cornerRadius(10)
                        })
    
                    }
                    Spacer()
                }
                if showSugarView{
                    checkSugarmateView(expectedResult: expectedResult , show: $showSugarView)
                }
                InformationView(showAdd: $addScreen, showDelete: $deleteScreen, CGMPoints: CGMPoints)
            
                .navigationBarTitle(test.title, displayMode: .inline)
                .navigationBarColor(UIColor(hex: 0x52b69a))
            }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test(title: "test1", description: "description", expected_result: "result", entriesList: [], action: 2))
    }
}
