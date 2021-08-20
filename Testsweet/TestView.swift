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
    
    @EnvironmentObject var theme : Themes
    
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
                //Color(hex:0xcaf0f8).ignoresSafeArea()
                Color(.white).ignoresSafeArea()
                
            VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("TITLE")
                            .font(.headline)
                        Text(test.title)
                    }
                    .padding(.top, 25)
                    .padding([.horizontal, .bottom], 15)
                    
                    VStack(alignment: .leading) {
                        Text("DESCRIPTION")
                            .font(.headline)
                        Text(test.description)
                    }
                    .padding([.horizontal, .bottom], 15)
                    
                    VStack(alignment: .leading) {
                        Text("EXPECTED RESULT")
                            .font(.headline)
                        Text(test.expected_result)
                    }
                    .padding(.horizontal, 15)
                    .padding([.bottom], 50)
                    
                    HStack{
                        Spacer()
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
                            Text("RUN TEST")
                                .bold()
                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                .padding(.top, 15)
                                .padding(.bottom, 15)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(theme.getSecondary())
                                .cornerRadius(12)
                                .frame(width: 200, height: 50)
                                .background(theme.getSecondary())
                                .cornerRadius(10)

                        })
                        Spacer()
                    }
                    Spacer()
            }
            
                if showSugarView{
                    checkSugarmateView(expectedResult: expectedResult , show: $showSugarView)
                }
                InformationView(showAdd: $addScreen, showDelete: $deleteScreen, CGMPoints: CGMPoints)
            
                .navigationBarTitle(test.title, displayMode: .inline)
                    .navigationBarColor(UIColor(theme.getPrimanry()))
            }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test(title: "test1", description: "description", expected_result: "result", entriesList: [], action: 2))
    }
}
