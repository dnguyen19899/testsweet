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
//                                    Text("Add Your Own CSV Files")
//                                        .bold()
//                                        .padding()
//                                        .padding(.top, 20)
//                                        .font(Font.custom("Helvetica Neue", size: 30.0))
                                    
                                    VStack(alignment: .leading) {
                                        Text("TITLE")
                                            .font(.headline)
                                        TextField("Please fill in the title", text: $title)
                                            .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                            .cornerRadius(5.0)
                                    }
                                    .padding(.top, 30)
                                    .padding(.horizontal, 15)
                                    
                                    VStack(alignment: .leading) {
                                        Text("DESCRIPTION")
                                            .font(.headline)
                                        TextField("Please provide a description of your test", text: $description)
                                            .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                            .cornerRadius(5.0)
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
//                                            Text(fileName)
//                                                .fontWeight(fileThere ? .bold : .semibold)
//                                                .foregroundColor(fileThere ? .black : .gray)
//                                                .padding()
                                            
                                            Button(action: {
                                                
                                                vibrate()
                                                fileName = "Add File"
                                                filePath = ""
                                                showTrash()
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
                                        TextField("Briefly describe the expected result", text: $expectedResult)
                                            .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                            .cornerRadius(5.0)
                                    }
                                    .padding([.horizontal, .bottom], 15)
                                    
                                    // CREATE button
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            vibrate()
                                            UserDefaults.standard.testsList.append(Test(title: title, description: description, expected_result: expectedResult, filePath: filePath, action: 1))
                                            // go back home
                                            title = ""
                                            expectedResult = ""
                                            description = ""
                                            
                                        }){
                                            Text("CREATE")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                                .padding(.top, 15)
                                                .padding(.bottom, 15)
                                                .padding(.leading, 30)
                                                .padding(.trailing, 30)
                                                .foregroundColor(Color.white)
                                                .background(Color(hex: 0x52b69a))
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
