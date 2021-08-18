//
//  ManualTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

import SwiftUI

struct ManualTestView: View {
    
    @State private var createScreen = false
    @State private var date3 = Date()
    @State private var currentEntries = [Entry]()
    @State private var currentSelection = 0
    @ObservedObject var sgv3 = NumbersOnly()
    @State private var sgvError = false
    @State private var showAlert = false
    @State private var CGMPoints: Int64 = 0
    @State private var addScreen = false
    @State private var entriesShow: Bool = false
    @State private var title = ""
    @State private var expectedResult = ""
    @State private var notes = ""
    
    func delete(at offsets: IndexSet){
        currentEntries.remove(atOffsets: offsets)
    }
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    func getDate() -> Date {
        date3 = Date()
        return date3
    }
    
    
    var body: some View {
        
        ZStack() {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()

                ScrollView{
                    ZStack{
                        VStack{
                            Section {
                                ZStack{
                                    VStack{
                                        Text("Create your own tests:")
                                            .font(.system(size: 30, weight: .heavy, design: .default))
                                            .bold()
                                            .padding()
                                            .foregroundColor(Color(hex: 0x168aad))
                                        
                                        HStack{
                                            Text("Title:")
                                            TextField("title", text: $title)
                                        }.padding()
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
                                        HStack{
                                            Text("Description:")
                                            TextField("description", text: $notes)
                                        }.padding()
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
                                        VStack{
                                            
                                            VStack(spacing: 15){
                                                
                                                HStack(spacing: 0) {
                                                    Spacer()
                                                    TextField("BG Reading", text: $sgv3.value)
                                                        .keyboardType(.numberPad)
                                                        .border(Color(hex: 0x212529))
                                                        .padding(.leading, 60)
                                                    Button(action: {
                                                        self.hideKeyboard()
                                                    }){
                                                        Text("Done")
                                                            .bold()
                                                            .font(Font.custom("Helvetica Neue", size: 15.0))
                                                            .padding([.top, .bottom], 8)
                                                            .padding([.leading, .trailing], 30)
                                                            .foregroundColor(Color.white)
                                                            .background(Color(hex: 0x212529))
                                                    }.padding(.trailing, 60)
                                                    Spacer()
                                                }.textFieldStyle(RoundedBorderTextFieldStyle())
                                            }
                                            .onTapGesture {
                                                print("Tapped to hide keyboard")
                                                self.hideKeyboard()
                                            }
                                            
                                            VStack{
                                                DropdownPicker(title: "Directions", selection: $currentSelection, options: ["FLAT","NONE DOUBLE_UP", "SINGLE_UP", "FORTY_FIVE_UP", "FLAT FORTY_FIVE_DOWN", "SINGLE_DOWN", "DOUBLE_DOWN", "NOT_COMPUTABLE", "OUT_OF_RANGE", "None"])
                                            }
                                        }
                                        HStack{
                                            Button(action: {
                                                vibrate()
                                                var newCurrentSelection = ""
                                                if currentSelection == 0{newCurrentSelection = "FLAT"}
                                                else if currentSelection == 1 {newCurrentSelection = "NONE DOUBLE_UP"}
                                                else if currentSelection == 2 {newCurrentSelection = "SINGLE_UP"}
                                                else if currentSelection == 3 {newCurrentSelection = "FORTY_FIVE_UP"}
                                                else if currentSelection == 4 {newCurrentSelection = "FLAT FORTY_FIVE_DOWN"}
                                                else if currentSelection == 5 {newCurrentSelection = "SINGLE_DOWN"}
                                                else if currentSelection == 6 {newCurrentSelection = "DOUBLE_DOWN"}
                                                else if currentSelection == 7 {newCurrentSelection = "NOT_COMPUTABLE"}
                                                else if currentSelection == 8 {newCurrentSelection = "OUT_OF_RANGE"}
                                                else {newCurrentSelection = ""}
                                                if sgv3.value != "" {
                                                    if (Int(sgv3.value)!) >= 0 && (Int(sgv3.value)!) <= 500 {
                                                        let entry = Entry(sgv: sgv3.value, direction: newCurrentSelection)
                                                        currentEntries.append(entry)
                                                    }
                                                    else{
                                                        sgvError = true
                                                    }
                                                }
                                                else{
                                                    sgvError = true
                                                }
                                                
                                            }){
                                                Text("Add")
                                                    .bold()
                                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                                    .padding(.top, 15)
                                                    .padding(.bottom, 15)
                                                    .padding(.leading, 30)
                                                    .padding(.trailing, 30)
                                                    .foregroundColor(Color.white)
                                                    .background(Color(hex: 0x52b69a))
                                                    .cornerRadius(12)
                                            }.alert(isPresented: $sgvError) {
                                                Alert(title: Text("Error"), message: Text("Please enter a value between 0 and 500"), dismissButton: .default(Text("OK")))
                                            }
                                            
                                            Button(action: {
                                                vibrate()
                                                currentEntries.append(Entry(sgv: "-1", direction: ""))
                                            }){
                                                Text("Add Empty")
                                                    .bold()
                                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                                    .padding(.top, 15)
                                                    .padding(.bottom, 15)
                                                    .padding(.leading, 30)
                                                    .padding(.trailing, 30)
                                                    .foregroundColor(Color.white)
                                                    .background(Color(hex: 0x212529))
                                                    .cornerRadius(12)
                                            }
                                        }
                                        
                                        Button(action: {
                                            vibrate()
                                            entriesShow = true
                                            
                                        }, label: {
                                            Text("Check Entries")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                                .padding(.top, 15)
                                                .padding(.bottom, 15)
                                                .padding(.leading, 30)
                                                .padding(.trailing, 30)
                                                .foregroundColor(Color.white)
                                                .background(Color(hex: 0x168aad))
                                                .cornerRadius(12)
                                        })
                                        
                                        HStack{
                                            Text("Expected Result:")
                                            TextField("expected result", text: $expectedResult)
                                        }.padding()
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
//                                        HStack{
//                                            Text("Notes:")
//                                            TextField("notes", text: $notes)
//                                        }.padding()
//                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                       
                                        
                                        HStack{
                                            Button(action: {
                                                vibrate()
                                                UserDefaults.standard.testsList.append(Test(title: title, description: notes, expected_result: expectedResult, entriesList: currentEntries, action: 2))
                                                // GO home
                                                title = ""
                                                expectedResult = ""
                                                notes = ""
                                                
                                            }){
                                                Text("Done")
                                                    .bold()
                                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                                    .padding(.top, 15)
                                                    .padding(.bottom, 15)
                                                    .padding(.leading, 30)
                                                    .padding(.trailing, 30)
                                                    .foregroundColor(Color.white)
                                                    .background(Color.black)
                                                    .cornerRadius(12)
                                            }.alert(isPresented: $showAlert) {
                                                Alert(title: Text("Error"), message: Text("Please add at least one entry before proceeding."), dismissButton: .default(Text("OK")))
                                            }
                                            Button(action: {
                                                vibrate()
                                                currentEntries = []
                                            }){
                                                Image(systemName: "trash.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.red)
                                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                                    .padding(.top, 15)
                                                    .padding(.bottom, 15)
                                                    .padding(.leading, 30)
                                                    .padding(.trailing, 30)
                                                    .background(Color.black)
                                                    .cornerRadius(12)
                                            }
                                        }
                                        Spacer()
                                    }
                                        CurrentEntriesView(show: $entriesShow, currentEntries: currentEntries)
                                    //InformationView(show: $showPopUp, showAdd: $addScreen, showDelete: $deleteScreen, CGMPoints: CGMPoints)
                                }
                            }
                        }
                    }.padding([.leading, .trailing])
                  
                }

            }
        
        .navigationBarTitle("Create a Test Manually", displayMode: .inline)
        .navigationBarColor(UIColor(hex: 0x52b69a))

       
    }
}



struct ManualTestView_Previews: PreviewProvider {
    static var previews: some View {
        ManualTestView()
    }
}

