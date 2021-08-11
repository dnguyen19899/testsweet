//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen and Jayden Morgan on 7/26/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

enum ActiveAlert {
    case first, second, third
}


struct ContentView: View {
    
    @State private var date = Date()
    @State private var date2 = Date()
    @State private var date3 = Date()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var dateError = false
    @State private var sgvError = false
    @State private var checkError = false
    @State private var deleteAlert = false
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @ObservedObject var sgv = NumbersOnly()
    @ObservedObject var sgv2 = NumbersOnly()
    @ObservedObject var sgv3 = NumbersOnly()
    
    @State private var deleteScreen = false
    @State private var infoWindow = false
    @State private var addScreen = false
    @State private var createScreen = false
    @State private var isAnimating = false
    @State private var showProgress = false
    @State private var showGetScreen = false
    
    
    @State private var CGMPoints: Int64 = 0
    @State private var button = false
    @State private var currentSelection = 0
    @State private var getArrayHere: [String] = ["Loading"]
    
    @State private var showCustomEntry: Bool = false
    @State private var showGenerateEntries: Bool = false
    @State private var showCSVEntry: Bool = false
    @State private var showDeleteEntries: Bool = false
    
    @State private var currentEntries = [Entry]()
    
    @State var fileName = "Add File"
    @State var openFile = false
    @State var filePath = ""
    @State private var fileThere = false
    
    
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    func delete(at offsets: IndexSet){
        currentEntries.remove(atOffsets: offsets)
    }
    func populateGetArray(){
        let NSController = NightscoutController(date: date)
        NSController.getEntryRequest{(data) in
            getArrayHere = data
            //print(getArrayHere)
        }
    }
    func showTrash(){
        if fileName != "Add File"{
            fileThere = true
        }
        else {
            fileThere = false
        }
    }
    
    let headerHeight = CGFloat(50)
    
    var body: some View {
        
        if addScreen {
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 1000, height: 1000)
                VStack{
                    Text("Adding CGM Readings")
                        .foregroundColor(Color.black)
                        .font(.system(size: 40))
                        .bold()
                    Image(systemName: "arrow.2.circlepath")
                        .font(.system(size: 56.0))
                        .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                        .animation(self.isAnimating ? foreverAnimation : .default)
                        .onAppear { self.isAnimating = true }
                        .onDisappear { self.isAnimating = false }
                        .onAppear { self.showProgress = true }
                    Text("Adding \(CGMPoints) points").padding()
                }
            }
        }
        if deleteScreen {
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 1000, height: 1000)
                VStack{
                    Text("Deleting")
                        .foregroundColor(Color.black)
                        .font(.system(size: 60))
                        .bold()
                    Image(systemName: "arrow.2.circlepath")
                        .font(.system(size: 56.0))
                        .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                        .animation(self.isAnimating ? foreverAnimation : .default)
                        .onAppear { self.isAnimating = true }
                        .onDisappear { self.isAnimating = false }
                        .onAppear { self.showProgress = true }
                }
            }
        }
        ZStack(alignment: .topLeading) {
            //Color(hex:0xcaf0f8).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            HeaderView().zIndex(1)
                .frame(height: headerHeight)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    
                    // List of feature buttons here:
                    Color.clear.frame(height: CGFloat(80))
                    
                    // ------- Entries Generation ------- //
                    Section() {
                        
                        HStack(spacing: 5) {
                            // ------- Generate Entries ------- //
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(Color(hex: 0x184e77))
                                .frame(height: 150)
                                .padding([.leading, .top])
                                .overlay(
                                    Text("AUTO GENERATE ENTRIES")
                                        .font(.system(size: 20, weight: .heavy, design: .default))
                                        .foregroundColor(.white).padding()
                                ).onTapGesture {
                                    self.showGenerateEntries = true
                                }.sheet(isPresented: $showGenerateEntries) {
                                    
                                    Text("Generate Entries within Range")
                                        .font(.system(size: 20, weight: .heavy))
                                        .padding(.leading, 20)
                                        .foregroundColor(.blue)
                                    
                                    // Start Date
                                    DatePicker("Select a start date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                        .padding(.bottom, 10)
                                    // End Date
                                    DatePicker("Select an end date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                        .padding(.bottom, 10)
                                    
                                    // initializer for backend
                                    let NSController = NightscoutController(startDate: startDate, endDate: endDate)
                                    
                                    //Check box slider thing
                                    
                                    HStack {
                                        Button(action: {
                                            button = false
                                        }){
                                            Text("Random Readings")
                                                .bold()
                                                .foregroundColor(button ? Color.blue : Color.white)
                                                .padding()
                                                .background(button ? Color.clear : Color.blue)
                                                .cornerRadius(12)
                                        }
                                        Button(action: {
                                            button = true
                                        }){
                                            Text("Straight Readings")
                                                .bold()
                                                .foregroundColor(button ? Color.white : Color.blue)
                                                .padding()
                                                .background(button ? Color.blue : Color.clear)
                                                .cornerRadius(12)
                                        }
                                        
                                        VStack{
                                            if button {
                                                Text("BG Reading")
                                                    .padding(.leading, 20)
                                                // SVG input field for custom entries
                                                TextField("", text: $sgv2.value)
                                                    .keyboardType(.decimalPad)
                                                    .border(Color.gray)
                                                    .padding(.leading, 40)
                                                    .padding(.trailing, 20)
                                            }
                                        }.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onTapGesture {
                                            self.hideKeyboard()
                                        }
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                    .padding()
                                    
                                    // CREATE button
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            if startDate == endDate || startDate > endDate {
                                                print("Please make sure start date is less than end and not equal")
                                                self.activeAlert = .third
                                                self.showAlert = true
                                            }
                                            else {
                                                print("start date: \(startDate)")
                                                print("end date: \(endDate)")
                                                if button == false{
                                                    print("making post; random")
                                                    addScreen = true
                                                    showGenerateEntries = false
                                                    CGMPoints = NSController.populateGraphWithTwoTimesRandom(epochStartTime: NSController.getStartTimeStamp(), epochEndTime: NSController.getEndTimeStamp())
                                                    let secondsToDelay = (Double(CGMPoints) / 26) + 1
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                                        print("The adding is truly done")
                                                        addScreen = false
                                                    }
                                                }
                                                else {
                                                    if sgv2.value != "" {
                                                        if (Int(sgv2.value)!) >= 0 && (Int(sgv2.value)!) <= 500  {
                                                            print("making post; straight")
                                                            addScreen = true
                                                            showGenerateEntries = false
                                                            CGMPoints = NSController.populateGraphWithTwoTimeStraight(sgv: (Int(sgv2.value)!), epochStartTime: NSController.getStartTimeStamp(), epochEndTime: NSController.getEndTimeStamp())
                                                            let secondsToDelay = (Double(CGMPoints) / 26) + 1
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                                                print("The adding is truly done")
                                                                addScreen = false
                                                            }
                                                        }
                                                        else{
                                                            print("chose a sgv value between 0 and 500")
                                                            self.activeAlert = .second
                                                            self.showAlert = true
                                                        }
                                                    }
                                                    else{
                                                        print("must add SGV value nerd")
                                                        self.activeAlert = .first
                                                        self.showAlert = true
                                                        
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }){
                                            Text("CREATE")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                                .padding([.top, .bottom], 15)
                                                .padding([.leading, .trailing], 30)
                                                .foregroundColor(Color.white)
                                                .background(Color.black)
                                                .cornerRadius(12)
                                        }.alert(isPresented: $showAlert) {
                                            switch activeAlert {
                                            case .first:
                                                return Alert(title: Text("Error"), message: Text("Please enter an SGV value"), dismissButton: .default(Text("OK")))
                                            case .second:
                                                return Alert(title: Text("Error"), message: Text("chose a sgv value between 0 and 500"), dismissButton: .default(Text("OK")))
                                            case .third:
                                                return Alert(title: Text("Error"), message: Text("Please make sure start date is less than end and not equal"), dismissButton: .default(Text("OK")))
                                                
                                                
                                            }
                                        }
                                        Spacer()
                                    }
                                    
                                }
                            
                            //---------Create Your Own Test------------//
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(Color(hex: 0x168aad))
                                .frame(height: 150)
                                .padding([.trailing, .top])
                                .overlay(
                                    Text("CUSTOM ENTRIES")
                                        .font(.system(size: 20, weight: .heavy, design: .default))
                                        .foregroundColor(.white).padding()
                                ).onTapGesture {
                                    self.createScreen = true
                                }.sheet(isPresented: $createScreen) {
                                    ZStack{
                                        VStack{
                                            Text("Create your own tests:")
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 30))
                                                .bold()
                                                .padding()
                                            VStack{
                                                
                                                VStack(spacing: 15){
                                                    Text("SGV")
                                                        .padding([.leading, .trailing], 10)
                                                    HStack(spacing: 0) {
                                                        Spacer()
                                                        TextField("", text: $sgv3.value)
                                                            .keyboardType(.numberPad)
                                                            .border(Color.gray)
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
                                                                .background(Color.black)
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
                                                        .background(Color.black)
                                                        .cornerRadius(12)
                                                }.alert(isPresented: $sgvError) {
                                                    Alert(title: Text("Error"), message: Text("Please enter a value between 0 and 500"), dismissButton: .default(Text("OK")))
                                                }
                                                Button(action: {
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
                                                        .background(Color.black)
                                                        .cornerRadius(12)
                                                }
                                            }
                                            
                                            NavigationView {
                                                List {
                                                    ForEach(currentEntries, id: \.self){ entry in
                                                        Text(entry.toString())
                                                    }
                                                    .onDelete(perform: delete)
                                                }
                                                .navigationTitle("Current Entries")
                                            }
                                            
                                            DatePicker("Select an end date", selection: $date3, displayedComponents: [.date, .hourAndMinute])
                                                .padding(.leading, 20)
                                                .padding(.trailing, 20)
                                                .padding(.bottom, 10)
                                            
                                            HStack{
                                                Button(action: {
                                                    //pass in date3 for time
                                                    let NSController = NightscoutController(date: date3)
                                                    CGMPoints = Int64(NSController.populateGraphWithEntryList(date: NSController.getTimeStamp(), entries: currentEntries))
                                                    addScreen = true
                                                    createScreen = false
                                                    currentEntries = []
                                                    let secondsToDelay = (Double(CGMPoints) / 26) + 1
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                                        print("The adding is truly done")
                                                        addScreen = false
                                                    }
                                                    
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
                                                }
                                                Button(action: {
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
                                    }
                                }
                        }
                    }
                    // ------- CSV Import ------- //
                    Section() {
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color(hex: 0x52b69a))
                            .frame(height: 120)
                            .padding([.leading, .trailing])
                            .overlay(
                                Text("ENTRIES from CSV")
                                    .font(.system(size: 25, weight: .heavy, design: .default))
                                    .foregroundColor(.white).padding()
                            ).onTapGesture {
                                self.showCSVEntry = true
                            }.sheet(isPresented: $showCSVEntry) {
                                
                                Text("Add Your Own CSV Files")
                                    .bold()
                                    .padding()
                                    .padding(.top, 20)
                                    .font(Font.custom("Helvetica Neue", size: 30.0))
                                    .offset(y: infoWindow ? -UIScreen.main.bounds.height/100 : +200)
                                
                                NotificationView()
                                    .offset(y: infoWindow ? -UIScreen.main.bounds.height/40 : -UIScreen.main.bounds.height)
                                
                                VStack(spacing: 25) {
                                    
                                    
                                    HStack{
                                        Button(action: {
                                            
                                            print("info")
                                            self.infoWindow.toggle()
                                            
                                        }, label: {
                                            Image(systemName: "info.circle")
                                                .foregroundColor(.black)
                                            
                                        }).padding(.leading, -30)
                                        
                                        Text(fileName)
                                            .fontWeight(fileThere ? .bold : .semibold)
                                            .foregroundColor(fileThere ? .black : .gray)
                                            .padding()
                                        Button(action: {
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
                                        let fileURL = try res.get()
                                        self.filePath = fileURL.path
                                        print(filePath)
                                        
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
                                Spacer()
                                DatePicker("Select an end date and time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 10)
                                // Initializer for backend
                                let NSController = NightscoutController(date: date)
                                // CREATE button
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        print("CSV entires pressed")
                                        
                                        CGMPoints = Int64(NSController.importCSVData(date: NSController.getTimeStamp(), filePath: filePath))
                                        
                                        addScreen = true
                                        self.showCSVEntry = false
                                        let secondsToDelay = (Double(CGMPoints) / 26) + 1
                                        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                            print("The adding is truly done")
                                            addScreen = false
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
                                            .background(Color.black)
                                            .cornerRadius(12)
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                        
                        
                        
                        
                        
                        //                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        //                            .fill(Color(hex: 0x52b69a))
                        //                            .frame(height: 120)
                        //                            .padding([.leading, .trailing])
                        //                            .overlay(
                        //                                Text("ENTRIES from CSV")
                        //                                    .font(.system(size: 25, weight: .heavy, design: .default))
                        //                                    .foregroundColor(.white).padding()
                        //                            ).onTapGesture {
                        //                                self.showCSVEntry = true
                        //                            }.sheet(isPresented: $showCSVEntry) {
                        //                                Text("Add Your Own CSV Files")
                        //                                    .bold()
                        //                                    .padding()
                        //                                    .font(Font.custom("Helvetica Neue", size: 30.0))
                        //
                        //                                VStack(spacing: 25) {
                        //
                        //                                    HStack{
                        //                                        Text(fileName)
                        //                                            .fontWeight(fileThere ? .bold : .semibold)
                        //                                            .foregroundColor(fileThere ? .black : .gray)
                        //                                            .padding()
                        //                                        Button(action: {
                        //                                            fileName = "Add File"
                        //                                            filePath = ""
                        //                                            showTrash()
                        //                                        }, label: {
                        //                                        Image(systemName: "trash")
                        //                                            .foregroundColor(fileThere ? .black : .clear)
                        //                                        })
                        //                                    }
                        //
                        //                                    Button(action: {openFile.toggle()}, label: {
                        //                                        Text("Open")
                        //                                            .bold()
                        //                                            .font(Font.custom("Helvetica Neue", size: 20.0))
                        //                                        Image(systemName: "square.and.arrow.down").font(Font.custom("Helvetica Neue", size: 25))
                        //                                    })
                        //                                     .padding()
                        //                                      .foregroundColor(Color.white)
                        //                                      .background(Color.black)
                        //                                      .cornerRadius(12)
                        //
                        //                                }.fileImporter(isPresented: $openFile, allowedContentTypes: [.data]) { (res) in
                        //
                        //                                    do {
                        //                                        let fileURL = try res.get()
                        //                                        self.filePath = fileURL.path
                        //                                        print(filePath)
                        //
                        //                                        // getting fileName
                        //                                        self.fileName = fileURL.lastPathComponent
                        //                                        showTrash()
                        //                                        //print(fileName)
                        //                                    }
                        //                                    catch {
                        //                                        print("Error reading docs")
                        //                                        print(error.localizedDescription)
                        //                                    }
                        //                                }
                        //                                Spacer()
                        //                                DatePicker("Select an end date and time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        //                                    .padding(.leading, 20)
                        //                                    .padding(.trailing, 20)
                        //                                    .padding(.bottom, 10)
                        //
                        //
                        //                                // Initializer for backend
                        //                                let NSController = NightscoutController(date: date)
                        //
                        //                                // CREATE button
                        //                                HStack {
                        //                                    Spacer()
                        //                                    Button(action: {
                        //                                        print("CSV entires pressed")
                        //
                        //                                        CGMPoints = Int64(NSController.importCSVData(date: NSController.getTimeStamp(), filePath: filePath))
                        //
                        //                                        addScreen = true
                        //                                        self.showCSVEntry = false
                        //                                        let secondsToDelay = (Double(CGMPoints) / 26) + 1
                        //                                        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                        //                                            print("The adding is truly done")
                        //                                            addScreen = false
                        //                                        }
                        //
                        //                                    }){
                        //                                        Text("CREATE")
                        //                                        .bold()
                        //                                            .font(Font.custom("Helvetica Neue", size: 20.0))
                        //                                            .padding(.top, 15)
                        //                                            .padding(.bottom, 15)
                        //                                            .padding(.leading, 30)
                        //                                            .padding(.trailing, 30)
                        //                                        .foregroundColor(Color.white)
                        //                                        .background(Color.black)
                        //                                        .cornerRadius(12)
                        //                                    }
                        //                                    Spacer()
                        //                                }
                        //                                Spacer()
                        //                            }
                        
                    }
                    //------- get function, maybe a graph-----//
                    Section() {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color(hex:0x212529))
                            .frame(height: 100)
                            .padding([.leading, .trailing])
                            .overlay(
                                Text("VIEW ENTRIES ADDED")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(.white).padding()
                            ).onTapGesture {
                                self.showGetScreen = true
                            }.sheet(isPresented: $showGetScreen) {
                                
                                
                                
                                ZStack{
                                    VStack{
                                        
                                        NavigationView {
                                            List {
                                                
                                                ForEach(getArrayHere, id: \.self){ entry in
                                                    Text(entry)
                                                    
                                                    
                                                }
                                                
                                            }
                                            .navigationTitle("Here is what is graphed")
                                            .onAppear(perform: populateGetArray)
                                            
                                        }
                                        Button(action: {
                                            populateGetArray()
                                            
                                        }){
                                            Text("REFRESH")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                                .padding(.top, 15)
                                                .padding(.bottom, 15)
                                                .padding(.leading, 30)
                                                .padding(.trailing, 30)
                                                .foregroundColor(Color.white)
                                                .background(Color.red)
                                                .cornerRadius(12)
                                        }.padding()
                                    }
                                }
                            }
                    }
                    Spacer()
                    // ------- Delete Entries ------- //
                    Section() {
                        
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(Color.red)
                                .frame(width: 200, height: 100)
                                .padding()
                                .overlay(
                                    HStack(spacing: 0) {
                                        Text("DELETE")
                                            .font(.system(size: 26, weight: .heavy, design: .default))
                                            .foregroundColor(.white).padding()
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                            .font(.system(size: 26))
                                    }
                                    
                                ).onTapGesture {
                                    self.showDeleteEntries = true
                                }.sheet(isPresented: $showDeleteEntries) {
                                    Text("Delete All Entries")
                                        .font(.system(size: 20, weight: .heavy))
                                        .padding([.leading, .top], 20)
                                        .foregroundColor(.blue)
                                    Text("Clear out all entries in Nightscout server. This action cannot be undone.")
                                        .font(.system(size: 15, weight: .regular))
                                        .padding([.leading, .trailing], 20)
                                        .padding(.bottom, 40)
                                    HStack {
                                        Spacer()
                                        let NSController = NightscoutController(date: date)
                                        Button(action: {
                                            
                                            print("delete button has been clicked waiting to see if canceled or not")
                                            deleteAlert = true
                                        }){
                                            Text("DELETE")
                                                .bold()
                                                .font(Font.custom("Helvetica Neue", size: 20.0))
                                                .padding(.top, 15)
                                                .padding(.bottom, 15)
                                                .padding(.leading, 30)
                                                .padding(.trailing, 30)
                                                .foregroundColor(Color.white)
                                                .background(Color.red)
                                                .cornerRadius(12)
                                        }.alert(isPresented:$deleteAlert) {
                                            Alert(
                                                title: Text("Are you sure you want to delete all entries?"),
                                                message: Text("This action cannot be undone"),
                                                primaryButton: .destructive(Text("Delete")) {
                                                    NSController.deleteEntryRequest()
                                                    deleteScreen = true
                                                    showDeleteEntries = false
                                                    let secondsToDelay = 5.0
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                                        print("The delete is truly done")
                                                        deleteScreen = false
                                                    }
                                                },
                                                secondaryButton: .cancel()
                                                
                                            )
                                        }
                                        Spacer()
                                    }
                                }
                            Spacer()
                        }
                    }
                    
                    // list end here
                    Spacer()
                })
            }
        }
    }
}

struct MyDatePicker: UIViewRepresentable {
    
    @Binding var selection: Date
    let minuteInterval: Int
    let displayedComponents: DatePickerComponents
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MyDatePicker>) -> UIDatePicker {
        let picker = UIDatePicker()
        // listen to changes coming from the date picker, and use them to update the state variable
        picker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged), for: .valueChanged)
        return picker
    }
    
    func updateUIView(_ picker: UIDatePicker, context: UIViewRepresentableContext<MyDatePicker>) {
        picker.minuteInterval = minuteInterval
        picker.date = selection
        
        switch displayedComponents {
        case .hourAndMinute:
            picker.datePickerMode = .time
        case .date:
            picker.datePickerMode = .date
        case [.hourAndMinute, .date]:
            picker.datePickerMode = .dateAndTime
        default:
            break
        }
    }
    
    class Coordinator {
        let datePicker: MyDatePicker
        init(_ datePicker: MyDatePicker) {
            self.datePicker = datePicker
        }
        
        @objc func dateChanged(_ sender: UIDatePicker) {
            datePicker.selection = sender.date
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
