//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI


 

struct ContentView: View {

    var body: some View {

        Button(action: {

            print("making requst button pressed")

            makeEntryPostRequest(dateString: "2021-07-26T18:03:10.049Z", date: 1627322590 , sgv: 212, direction: "jo mama")

        }, label:{

            Text("Run make post Request")

        })

    }

}


 

// Make treatment and post it on the nighscout site, I can delete this but I am not ready to part with it until we know for sure.

func makeTreatmentPostRequest(id: String, glucose: String, carbs: Double, protein: Double, fat: Double, insulin: Double, enteredBy: String ) {

    guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/treatments?token=api-d1b60b0ce9c2dbae"),

        let payload = "[{\"_id\":\"\(id)\",\"eventType\":\"testing\",\"created_at\":\"string\",\"glucose\":\"\(glucose)\",\"glucoseType\":\"string\",\"carbs\":\(carbs),\"protein\":\(protein),\"fat\":\(fat),\"insulin\":\(insulin),\"units\":\"string\",\"transmitterId\":\"string\",\"sensorCode\":\"string\",\"notes\":\"Testing on mac\",\"enteredBy\":\"\(enteredBy)\"}]".data(using: .utf8) else

    {

        return

    }


 

    var request = URLRequest(url: url)

    request.httpMethod = "POST"

    request.addValue("TandemDiabetes1", forHTTPHeaderField: "x-api-key")

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpBody = payload


 

    URLSession.shared.dataTask(with: request) { (data, response, error) in

        guard error == nil else { print(error!.localizedDescription); return }

        guard let data = data else { print("Empty data"); return }


 

        if let str = String(data: data, encoding: .utf8) {

            print(str)

        }

    }.resume()

}


 

// This posts the entrys that we input as parameters.

func makeEntryPostRequest(dateString: String, date: Int, sgv: Int, direction: String) {

    guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/treatments?token=api-d1b60b0ce9c2dbae"),

        let payload = "[{\"type\":\"sgv\",\"dateString\":\"\(dateString)\",\"date\":\(date),\"sgv\":\(sgv),\"direction\":\"\(direction)\"}]".data(using: .utf8) else

    {

        return

    }


 

    var request = URLRequest(url: url)

    request.httpMethod = "POST"

    request.addValue("TandemDiabetes1", forHTTPHeaderField: "x-api-key")

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpBody = payload


 

    URLSession.shared.dataTask(with: request) { (data, response, error) in

        guard error == nil else { print(error!.localizedDescription); return }

        guard let data = data else { print("Empty data"); return }


 

        if let str = String(data: data, encoding: .utf8) {

            print(str)

        }

    }.resume()

}
