//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI

struct ContentView: View {

    @State private var date = Date()
    
    var body: some View {
        
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                content: {
                    Form {
                        DatePicker("Select a date and time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                print("making request button pressed")
                                let NSController = NightscoutController(date: date)
                                NSController.formatDateString()
//                                NSController.makeEntryPostRequest(dateString: "2021-07-27T22:28:57.352Z", date: 1627424937 , sgv: 170, direction: "FLAT")
                            }){
                                Text("Create Entry")
                                .bold()
                                    .font(Font.custom("Helvetica Neue", size: 20.0))
                                .padding(20)
                                .foregroundColor(Color.white)
                                .background(Color.green)
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
