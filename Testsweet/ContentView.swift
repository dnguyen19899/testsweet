//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI

struct ContentView: View {

    @State private var date = Date()
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                content: {
                    // ----------- Custom Entry ----------- //
                    Form {
                        Text("Make Custom Entry").bold()
                        DatePicker("Select date and time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        
                        let NSController = NightscoutController(date: date)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                print("making post")
                                NSController.makeEntryPostRequest(dateString: "2021-07-29T20:59:27.499Z", date: 1627592367499 , sgv: 130, direction: "FLAT")
                            }){
                                Text("Create")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(12)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                print("making delete")
                                NSController.deleteEntryRequest()
                            }){
                                Text("Delete")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 15.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                            }
                            Spacer()
                        }
                    }
                    
                    // ----------- Time Range Feature ----------- //
                    Form {
                        Text("Entries Generator").bold()
                        DatePicker("Select a start date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                        DatePicker("Select an end date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                        
                        let NSController = NightscoutController(startDate: startDate, endDate: endDate)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                print("making post")
                                
                                NSController.populateGraphWithTwoTimes(
                                    dateStart: "2021-07-29T20:00:27.499Z",
                                    epochStartTime: 1627592367499,
                                    epochEndTime:   1627650037122)
                                
                                //NSController.makeEntryPostRequest(dateString: "2021-07-29T20:59:27.499Z", date: 1627592367499 , sgv: 130, direction: "FLAT")
                            }){
                                Text("Create")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(12)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                print("making delete")
                                NSController.deleteEntryRequest()
                            }){
                                Text("Delete")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 15.0))
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                            }
                            Spacer()
                        }
                    }
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
