//
//  CSVTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

struct CSVTestView: View {
    
    @State private var CGMPoints: Int64 = 0
    
    @State private var title = ""
    @State private var expectedResult = ""
    @State private var description = ""
    
    @State var fileName = "Add File"
    @State var openFile = false
    @State var filePath = ""
    @State private var fileThere = false
    
    @State private var fileURL: URL = URL(fileURLWithPath: "")
    @State private var isAccessing: Bool = false
    
    @State private var deleteAlert = false
    @State private var showAlert = false
    @State private var addScreen = false
    @State private var showCreate = false
    @State private var showCSVEntry: Bool = false
    @State private var showPopUp: Bool = false
    @State private var deleteScreen = false
    
    @State private var editingTitle = false
    @State private var editingDescription = false
    @State private var editingResult = false
    
    @EnvironmentObject var theme: Themes
    
    let regex = try! NSRegularExpression(pattern: "\\A[ ]+\\Z")
    
    func showTrash(){
        if fileName != "Add File"{
            fileThere = true
        }
        else {
            fileThere = false
        }
    }
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    var body: some View {
        
        ZStack() {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            
            VStack {
                ScrollView{
                    ZStack{
                        Section() {
                            
                            ZStack {
                                VStack {
//                                    Text("Add Your Own CSV Files")
//                                        .bold()
//                                        .padding()
//                                        .padding(.top, 20)
//                                        .font(Font.custom("Helvetica Neue", size: 30.0))
                                    
                                    VStack(alignment: .leading) {
                                        Text("TITLE")
                                            .font(.headline)
                                        TextField("Please fill in the title", text: $title, onEditingChanged: { edit in
                                                    self.editingTitle = edit })
                                            .textFieldStyle(MyTextFieldStyle(focused: $editingTitle))
                                    }
                                    .padding(.top, 30)
                                    .padding(.horizontal, 15)
                                    
                                    VStack(alignment: .leading) {
                                        Text("DESCRIPTION")
                                            .font(.headline)
                                        TextField("Please provide a description of your test", text: $description, onEditingChanged: { edit in
                                                    self.editingDescription = edit })
                                            .textFieldStyle(MyTextFieldStyle(focused: $editingDescription))
                                    }
                                    .padding(.horizontal, 15)
                                    
                                    VStack(spacing: 25) {
                                        
                                        
                                        HStack{
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                vibrate()
                                                print("info")
                                                //self.infoWindow.toggle()
                                                self.showPopUp.toggle()
                                                
                                            }, label: {
                                                Image(systemName: "info.circle")
                                                    .font(Font.system(size: 20, weight: .semibold))
                                                    .foregroundColor(Color(hex:0x212529))
                                                
                                            })
                                            .padding([.top, .bottom, .leading], 5)
                                            .padding(.trailing, 20)
                                            
                                            Button(action: {
                                                
                                                vibrate()
                                                fileName = "Add File"
                                                filePath = ""
                                                openFile.toggle()
                                                
                                            }, label: {
                                                
                                                Text(fileName)
                                                    .font(Font.system(size: 20))
                                                    .fontWeight(fileThere ? .bold : .semibold)
                                                    .foregroundColor(fileThere ? .black : Color(hex:0x212529))
                                                    .padding([.top, .bottom], 5)
                                                
                                                Image(systemName: "square.and.arrow.down")
                                                    .font(Font.system(size: 20, weight: .semibold))
                                                    .foregroundColor(Color(hex:0x212529))
                                                    .padding([.top, .bottom], 5)
                                                    .padding(.trailing, 10)
                                                
                                            })
                                            
                                            Button(action: {
                                                print("clicked on trash")
                                                vibrate()
                                                fileName = "Add File"
                                                filePath = ""
                                                fileThere = false
                                                showTrash()
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash")
                                                    .font(Font.system(size: 20, weight: .semibold))
                                                    .foregroundColor(fileThere ? .black : .clear)
                                                    .padding([.top, .bottom], 5)
                                                    .padding(.trailing, 20)
                                                
                                            })
                                            
                                            Spacer()
                                            
                                        }
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10.0)
                                                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                                                .foregroundColor(Color.gray)
                                        )
                                        .padding()
                                        
                                    }.fileImporter(isPresented: $openFile, allowedContentTypes: [.data]) { (res) in
                                        
                                        do {
                                            fileURL = try res.get()
                                            isAccessing = fileURL.startAccessingSecurityScopedResource()
                                            self.filePath = fileURL.path
                                            
                                            //print(filePath)
                                            
                                            // getting fileName
                                            self.fileName = fileURL.lastPathComponent
                                            
                                            showTrash()
                                            //print(fileName)
                                        }
                                        catch {
                                            print("Error reading docs")
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("EXPECTED RESULT")
                                            .font(.headline)
                                        TextField("Briefly describe the expected result", text: $expectedResult, onEditingChanged: { edit in
                                                    self.editingResult = edit })
                                            .textFieldStyle(MyTextFieldStyle(focused: $editingResult))
                                    }
                                    .padding([.horizontal, .bottom], 15)
                                    
                                    // CREATE button
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            vibrate()
                                            
                                            if filePath == "" {
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
                                                UserDefaults.standard.testsList.append(Test(title: title, description: description, expected_result: expectedResult, filePath: filePath, action: 1))
                                                
                                                // go back home
                                                title = ""
                                                expectedResult = ""
                                                description = ""
                                                fileName = "Add File"
                                                filePath = ""
                                                showTrash()
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
                                            Alert(title: Text("Error"), message: Text("Please open and select a file and make sure all fields are filled in."), dismissButton: .default(Text("OK")))
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
                
            }
            .navigationBarTitle("Create a Test from CSV", displayMode: .inline)
            .navigationBarColor(UIColor(theme.getPrimanry()))
            
            InformationView(show: $showPopUp, showAdd: $addScreen, showDelete: $deleteScreen, CGMPoints: CGMPoints)
            InformationView(showCreate: $showCreate)
        }
        
    }
    
}


struct CSVTestView_Previews: PreviewProvider {
    static var previews: some View {
        CSVTestView()
    }
}
