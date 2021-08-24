//
//  ManualTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI


struct ManualTestView: View {
    
    @State private var createScreen = false
    @State private var date3 = Date()
    @State private var currentEntries = [Entry]()
    @State private var currentSelection = 0
    @State private var currentSelectionText = "FLAT"
    @ObservedObject var sgv3 = NumbersOnly()
    @State private var sgvError = false
    @State private var CGMPoints: Int64 = 0
    @State private var showCreate = false
    @State private var entriesShow: Bool = false
    @State private var title = ""
    @State private var expectedResult = ""
    @State private var description = ""
    @State private var showAlert = false
    
    @State private var editingTitle = false
    @State private var editingDescription = false
    @State private var editingResult = false
    
    @EnvironmentObject var theme : Themes
    
    let regex = try! NSRegularExpression(pattern: "\\A[ ]+\\Z")
    
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
                
                VStack{
                    
                    VStack(alignment: .leading) {
                        Text("TITLE")
                            .font(.headline)
                        TextField("Please fill in the title", text: $title, onEditingChanged: { edit in
                                    self.editingTitle = edit })
                            .textFieldStyle(MyTextFieldStyle(focused: $editingTitle))
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 15)
                    
                    VStack(alignment: .leading) {
                        Text("DESCRIPTION")
                            .font(.headline)
                        TextField("Please provide a description of your test", text: $description, onEditingChanged: { edit in
                                    self.editingDescription = edit })
                            .textFieldStyle(MyTextFieldStyle(focused: $editingDescription))
                    }
                    .padding([.horizontal, .bottom], 15)
                    
                    VStack{
                        
                        VStack(spacing: 15){
                            
                            HStack(spacing: 0) {
                                Spacer()
                                TextField("BG Reading", text: $sgv3.value)
                                    .keyboardType(.numberPad)
                                    .border(theme.getAccent2())
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
                                        .background(theme.getAccent2())
                                }.padding(.trailing, 60)
                                Spacer()
                            }.textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .onTapGesture {
                            print("Tapped to hide keyboard")
                            self.hideKeyboard()
                        }
                        
                        DropdownButton(displayText: $currentSelectionText)
    
                    }.zIndex(1)
                    HStack{
                        Button(action: {
                            vibrate()
                            if sgv3.value != "" {
                                if (Int(sgv3.value)!) >= 0 && (Int(sgv3.value)!) <= 500 {
                                    let entry = Entry(sgv: sgv3.value, direction: currentSelectionText)
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
                                .padding([.top, .bottom], 15)
                                .padding([.leading, .trailing], 30)
                                .foregroundColor(Color.white)
                                .background(theme.getSecondary())
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
                                .padding([.top, .bottom], 15)
                                .padding([.leading, .trailing], 30)
                                .foregroundColor(Color.white)
                                .background(theme.getAccent2())
                                .cornerRadius(12)
                        }
                    }
                    
                    
                    Button(action: {
                        vibrate()
                        withAnimation{
                            entriesShow = true
                        }
                    }, label: {
                        Text("Check Entries")
                            .bold()
                            .font(Font.custom("Helvetica Neue", size: 20.0))
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 30)
                            .foregroundColor(Color.white)
                            .background(theme.getAccent1())
                            .cornerRadius(12)
                    })
                    
                    VStack(alignment: .leading) {
                        Text("EXPECTED RESULT")
                            .font(.headline)
                        TextField("Briefly describe the expected result", text: $expectedResult, onEditingChanged: { edit in
                                    self.editingResult = edit })
                            .textFieldStyle(MyTextFieldStyle(focused: $editingResult))
                    }
                    .padding([.top])
                    .padding([.horizontal, .bottom], 15)
                    
                    
                    
                    HStack{
                        Button(action: {
                            vibrate()
                            
                            if currentEntries.count == 0 {
                                showAlert = true
                            }
                            
                            else if regex.firstMatch(in: title, options: [], range: NSRange(location: 0, length: title.utf16.count)) != nil || title == "" {
                                showAlert = true
                            }
                            else if regex.firstMatch(in: description, options: [], range: NSRange(location: 0, length: description.utf16.count)) != nil || description == "" {
                                showAlert = true
                            }
                            else if regex.firstMatch(in: expectedResult, options: [], range: NSRange(location: 0, length: expectedResult.utf16.count)) != nil || expectedResult == "" {
                                showAlert = true
                            }
                            else {
                                UserDefaults.standard.testsList.append(Test(title: title, description: description, expected_result: expectedResult, entriesList: currentEntries, action: 2))
                                // GO home
                                title = ""
                                expectedResult = ""
                                description = ""
                                currentEntries = []
                                withAnimation{
                                    showCreate = true
                                }
                            }
                            
                        }){
                            Text("CREATE")
                                .bold()
                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                .padding(.top, 15)
                                .padding(.bottom, 15)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(theme.getSecondary())
                                .cornerRadius(12)
                        }.alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("Please add at least one entry before proceeding and make sure all fields are filled in"), dismissButton: .default(Text("OK")))
                        }
                        Button(action: {
                            vibrate()
                            currentEntries = []
                        }){
                            Image(systemName: "trash.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                .padding(.top, 15)
                                .padding(.bottom, 15)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    Spacer()
                }
            }
            
            InformationView(showCreate: $showCreate)
            CurrentEntriesView(show: $entriesShow, currentEntries: currentEntries)
                
        }
            
            .navigationBarTitle("Create a Test Manually", displayMode: .inline)
            .navigationBarColor(UIColor(theme.getPrimanry()))
    }
}


struct MyTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(.all)
        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            .border(focused ? Color(hex: 0x212529) : Color.clear, width: 3.0)
        .cornerRadius(5.0)
    }
}


struct ManualTestView_Previews: PreviewProvider {
    static var previews: some View {
        ManualTestView()
    }
}


