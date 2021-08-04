//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI
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
    
    @State private var deleteScreen = false
    @State private var addScreen = false
    @State private var isAnimating = false
    @State private var showProgress = false
    
    
    @State private var CGMPoints: Int64 = 0
    @State private var button = false
  
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
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
        ZStack {
            //Color(hex:0xFFFAF1).ignoresSafeArea()
            Color(.white).ignoresSafeArea()
            
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    
                    Section(header: HeaderView()) {
                        Text("Make Custom Entries")
                            .font(.system(size: 20, weight: .heavy))
                            .padding(.leading, 20)
                            .foregroundColor(.blue)
                        
                        // Datepicker for custom entries
                        DatePicker("Select date and time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Text("BG Reading")
                                .padding(.leading, 20)
                            // SVG input field for custom entries
                            TextField("", text: $sgv.value)
                                        .keyboardType(.decimalPad)
                                .border(Color.gray)
                                .padding(.leading, 100)
                                .padding(.trailing, 20)
                        }.textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        // Initializer for backend
                        let NSController = NightscoutController(date: date)
                        
                        // CREATE button
                        HStack {
                            Spacer()
                            Button(action: {
                               
                                print("the value is \(sgv.value)")
                                if sgv.value != "" {
                                    if (Int(sgv.value)!) >= 0 && (Int(sgv.value)!) <= 500 {
                                        print("making post")
                                        addScreen = true
                                        CGMPoints = 1
                                        NSController.makeEntryPostRequest(date: NSController.getTimeStamp() , sgv: Int(sgv.value)!, direction: "FLAT")
                                        let secondsToDelay = 4.0
                                        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                            print("The adding is truly done")
                                            addScreen = false
                                        }
                                    }
                                    else{
                                        print("chose a sgv value between 0 and 500")
                                        sgvError = true
                                    }
                                }
                                else{
                                    print("must add a sgv value before proceeding")
                                    sgvError = true
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
                            }.alert(isPresented: $sgvError) {
                                Alert(title: Text("Error"), message: Text("Please enter a value between 0 and 500"), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    // ------- Generate Entries ------- //
                    Section() {
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
                                        CGMPoints = NSController.populateGraphWithTwoTimesRandom(epochStartTime: NSController.getStartTimeStamp(), epochEndTime: NSController.getEndTimeStamp())
                                        let secondsToDelay = 5.0
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
                                                CGMPoints = NSController.populateGraphWithTwoTimeStraight(sgv: (Int(sgv2.value)!), epochStartTime: NSController.getStartTimeStamp(), epochEndTime: NSController.getEndTimeStamp())
                                                let secondsToDelay = 5.0
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
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
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
                            NSController.populateGraphWithCSV(date: NSController.getTimeStamp())
                            
                           
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
                    }
                    Spacer()
                    Section() {
                        Text("Delete All Entries")
                            .font(.system(size: 20, weight: .heavy))
                            .padding(.leading, 20)
                            .foregroundColor(.blue)
                        Text("Clear out all entries in Nightscout server. This action cannot be undone.")
                            .font(.system(size: 15, weight: .regular))
                            .padding(.leading, 20.0)
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
                })
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }

    }
}
