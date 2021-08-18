//
//  CSVTestView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/17/21.
//

import SwiftUI

struct CSVTestView: View {
    
    @State private var date = Date()
    @State private var CGMPoints: Int64 = 0
    
    @State private var title = ""
    @State private var expectedResult = ""
    @State private var notes = ""
    
    @State var fileName = "Add File"
    @State var openFile = false
    @State var filePath = ""
    @State private var fileThere = false
    
    @State private var fileURL: URL = URL(fileURLWithPath: "")
    @State private var isAccessing: Bool = false
    
    @State private var deleteAlert = false
    @State private var showAlert = false
    @State private var addScreen = false
    @State private var showCSVEntry: Bool = false
    @State private var showPopUp: Bool = false
    @State private var deleteScreen = false
    
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
                                    Text("Add Your Own CSV Files")
                                        .bold()
                                        .padding()
                                        .padding(.top, 20)
                                        .font(Font.custom("Helvetica Neue", size: 30.0))
                                    
                                    HStack{
                                        Text("Title:")
                                        TextField("title", text: $title)
                                    }.padding()
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    
                                    VStack(spacing: 25) {
                                        
                                        
                                        HStack{
                                            Button(action: {
                                                vibrate()
                                                print("info")
                                                //self.infoWindow.toggle()
                                                self.showPopUp.toggle()
                                                
                                            }, label: {
                                                Image(systemName: "info.circle")
                                                    .foregroundColor(.black)
                                                
                                            }).padding(.leading, -30)
                                            
                                            Text(fileName)
                                                .fontWeight(fileThere ? .bold : .semibold)
                                                .foregroundColor(fileThere ? .black : .gray)
                                                .padding()
                                            Button(action: {
                                                vibrate()
                                                fileName = "Add File"
                                                filePath = ""
                                                showTrash()
                                            }, label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(fileThere ? .black : .clear)
                                            })
                                            
                                        }
                                        
                                        Button(action: {openFile.toggle()}, label: {
                                            
                                            Text("Open")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                            Image(systemName: "square.and.arrow.down").font(Font.custom("Helvetica Neue", size: 25))
                                        })
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .background(Color.black)
                                        .cornerRadius(12)
                                        
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
                                    
                                    HStack{
                                        Text("Expected Result:")
                                        TextField("expected result", text: $expectedResult)
                                    }.padding()
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    HStack{
                                        Text("Notes:")
                                        TextField("notes", text: $notes)
                                    }.padding()
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    // CREATE button
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            vibrate()
                                            testsList.append(Test(title: title, description: notes, expected_result: expectedResult, filePath: filePath, action: 1))
                                            // go back home
                                            title = ""
                                            expectedResult = ""
                                            notes = ""
                                            
                                        }){
                                            Text("CREATE")
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
                                            Alert(title: Text("Error"), message: Text("Please open and select a file."), dismissButton: .default(Text("OK")))
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
            .navigationBarColor(UIColor(hex: 0x52b69a))
            
            InformationView(show: $showPopUp, showAdd: $addScreen, showDelete: $deleteScreen, CGMPoints: CGMPoints)
        }
        
    }
    
}


struct CSVTestView_Previews: PreviewProvider {
    static var previews: some View {
        CSVTestView()
    }
}
