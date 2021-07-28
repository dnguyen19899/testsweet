//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI


 

struct ContentView: View {

    var NSController = NightscoutController()
    
    var body: some View {

        Button(action: {

            print("making requst button pressed")
            NSController.makeEntryPostRequest(dateString: "2021-07-27T22:28:57.352Z", date: 1627424937 , sgv: 170, direction: "FLAT")

        }, label:{

            Text("Run make post Request").bold()

        })

    }

}
