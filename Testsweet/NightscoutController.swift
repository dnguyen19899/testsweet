//
//  NightscoutController.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/27/21.
//

import Foundation

class NightscoutController {
    
    private var date: Date
    private var timestamp = 0
    private var dateString = ""
    
    init (date: Date) {
        self.date = date
        // print(self.date)
    }
    
    func formatDateString() {
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self.dateString = iso8601DateFormatter.string(from: self.date)
        
        print(self.date)
        print(self.dateString)
    }

    // This posts the entrys that we input as parameters.
    func makeEntryPostRequest(dateString: String, date: Int, sgv: Int, direction: String) {

        guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/entries?token=api-d1b60b0ce9c2dbae"),

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
    
    //deleteEntryRequest function deletes all entries
    func deleteEntryRequest() {
        print("deleting")
        guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/entries.json?find[sgv]=130&token=api-d1b60b0ce9c2dbae")

        else {
            print("else\\")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("TandemDiabetes1", forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }

        }.resume()
        
    }
}

