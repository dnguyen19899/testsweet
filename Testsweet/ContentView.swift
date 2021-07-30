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

struct ContentView: View {

    @State private var date = Date()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var dateError = false
    @State private var deleteAlert = false
    @ObservedObject var sgv = NumbersOnly()
    
    var body: some View {
        ZStack {
            Color(hex:0xFFFAF1).ignoresSafeArea()
            
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    
                    Section(header: HeaderView()) {
                        Text("Make Custom Entries")
                            .font(.system(size: 20, weight: .heavy))
                            .padding(.leading, 20)
                            .foregroundColor(.pink)
                        
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

                                print("making post")
                                NSController.makeEntryPostRequest(dateString: NSController.getDateString(), date: NSController.getTimeStamp() , sgv: 130, direction: "FLAT")
                            }){
                                Text("CREATE")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(12)
                            }.alert(isPresented: $dateError) {
                                Alert(title: Text("Error"), message: Text("Please enter the correct date"), dismissButton: .default(Text("OK")))
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
                            .foregroundColor(.pink)
                        
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
                        
                        // CREATE button
                        HStack {
                            Spacer()
                            Button(action: {
                                if startDate == endDate || startDate > endDate {
                                    print("Please make sure start date is less than end and not equal")
                                    dateError = true
                                }
                                else {
                                    print("making post")
                                }
        
                                NSController.populateGraphWithTwoTimes(dateStart: NSController.getStartDateString(), epochStartTime: NSController.getStartTimeStamp(), epochEndTime: NSController.getEndTimeStamp())
                            }){
                                Text("CREATE")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(12)
                            }.alert(isPresented: $dateError) {
                                Alert(title: Text("Error"), message: Text("Please enter the correct date"), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    Section() {
                        Text("Delete All Entries")
                            .font(.system(size: 20, weight: .heavy))
                            .padding(.leading, 20)
                            .foregroundColor(.pink)
                        Text("Clear out all entries in NIghtscout server. This action cannot be undone.")
                            .font(.system(size: 15, weight: .regular))
                            .padding(.leading, 20.0)
                        HStack {
                            Spacer()
                            let NSController = NightscoutController(date: date)
                            Button(action: {

                                print("making delete")
                                deleteAlert = true
                                NSController.deleteEntryRequest()
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
                                        print("Deleting...")
                                        NSController.deleteEntryRequest()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            Spacer()
                        }
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
