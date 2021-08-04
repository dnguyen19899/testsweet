
//
//  NightscoutController.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/27/21.
//

import Foundation



extension Date {
    var milliStamp:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

struct Entry {
    var sgv: Int = 0
    var direction: String = ""
    
    init(raw: [String]) {
        sgv = Int(raw[0]) ?? 0
        direction = raw[1]
    }
}

class NightscoutController {
    
    private var debug = false
    private var date: Date = Date()
    private var timeStamp:Int64 = 0
    private var dateString = ""
    
    private var startDate: Date = Date()
    private var startTimeStamp:Int64 = 0
    private var startDateString = ""
    
    private var endDate: Date = Date()
    private var endTimeStamp:Int64 = 0
    private var endDateString = ""
    
    private var CGMCounter = 0
    
    
    init (date: Date) {
        self.date = date
        self.timeStamp = self.date.milliStamp
        self.dateString = self.formatDateString(date: self.date)
        
        if debug {
            print("DATE: \(self.date)")
            print("TIMESTAMP IN MILLISECONDS: \(self.timeStamp)")
            print("DATE STRING: \(self.dateString)")
            print(" ")
        }
    }
    
    init (startDate: Date, endDate: Date)
    {
        self.startDate = startDate
        self.startTimeStamp = self.startDate.milliStamp
        self.startDateString = self.formatDateString(date: self.startDate)
        if debug {
            print("START DATE: \(self.startDate)")
            print("START TIMESTAMP IN MILLISECONDS: \(self.startTimeStamp)")
            print("START DATE STRING: \(self.startDateString)")
            print(" ")
        }
        
        self.endDate = endDate
        self.endTimeStamp = self.endDate.milliStamp
        self.endDateString = self.formatDateString(date: self.endDate)
        if debug {
            print("END DATE: \(self.endDate)")
            print("END TIMESTAMP IN MILLISECONDS: \(self.endTimeStamp)")
            print("END DATE STRING: \(self.endDateString)")
            print(" ")
        }
    }
    
    func formatDateString(date: Date) -> String {
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return iso8601DateFormatter.string(from: self.date)
    }
    
    func getCSVData() -> Array<Entry> {
        
        var csvToStruct = [Entry]()
        
        guard let filePath = Bundle.main.path(forResource: "input", ofType: "csv") else {
            return []
        }
        var data = ""
        do {
            data = try String(contentsOfFile: filePath, encoding: .utf8)
            //print(data)
        } catch {
            print(error)
            return []
        }
        
        let rows = data.components(separatedBy: "\n")
        
        
        for row in rows {
            let csvColumns = row.components(separatedBy: ",")
            let entryStruct = Entry.init(raw: csvColumns)
            csvToStruct.append(entryStruct)
        }
        
        return csvToStruct
    }
    
    func populateGraphWithTwoTimesRandom (epochStartTime: Int64, epochEndTime: Int64) -> Int64  {
        let totalTime = epochEndTime - epochStartTime
        print (totalTime)
        let TotalTime = (totalTime/300000)
        var newEpochStart = epochStartTime
        for _ in (0...TotalTime){
            let randNum = Int.random(in: 40...400)
            makeEntryPostRequest(date: newEpochStart, sgv: randNum, direction: "FLAT")
            newEpochStart = newEpochStart + 300000
            
            
        }
        return TotalTime
    }
    func populateGraphWithTwoTimeStraight (sgv: Int, epochStartTime: Int64, epochEndTime: Int64) -> Int64 {
        let totalTime = epochEndTime - epochStartTime
        let TotalTime = (totalTime/300000)
        var newEpochStart = epochStartTime
        for _ in (0...TotalTime){
            makeEntryPostRequest(date: newEpochStart, sgv: sgv, direction: "FLAT")
            newEpochStart = newEpochStart + 300000
            
        }
        return TotalTime
    }
    
    func populateGraphWithCSV (date: Int64) {
        var newDate :Int64 = date
        let unicorn = self.getCSVData()
        print(unicorn.count)
        for i in 0...(unicorn.count-1){
            //print("date: \(newDate) sgv: \(unicorn[i].sgv), direction: \(unicorn[i].direction)")
            let sgv = unicorn[i].sgv
            let dir = unicorn[i].direction
            let newDir = dir.replacingOccurrences(of: "FLAT\r", with: "FLAT")
            makeEntryPostRequest(date: newDate, sgv: sgv, direction: newDir)
            newDate = newDate - 300000

            
        }
    }
    
    
    
    
    
    
    //for custom
    func getTimeStamp() -> Int64 {
        return timeStamp
    }
    
    func getDateString() -> String {
        return dateString
    }
    //for two dates
    func getStartTimeStamp() -> Int64 {
        return startTimeStamp
    }
    
    func getEndTimeStamp() -> Int64 {
        return endTimeStamp
    }
    
    func getStartDateString() -> String {
        return startDateString
    }
    
    func getEndDateString() -> String {
        return endDateString
    }
    
    
    
    // ----------- CURL Requests ----------- //
    
    // This posts the entrys that we input as parameters.
    func makeEntryPostRequest(date: Int64, sgv: Int, direction: String) {
        guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/entries?&token=api-d1b60b0ce9c2dbae"),
            let payload = "[{\"type\":\"sgv\",\"date\":\(date),\"sgv\":\(sgv),\"direction\":\"\(direction)\"}]".data(using: .utf8) else
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
        guard let url = URL(string: "https://test-sweet.herokuapp.com/api/v1/entries.json?find[date][$gte]=0&count=10000&token=api-d1b60b0ce9c2dbae")

        else {
            print("URL is not accepted")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("TandemDiabetes1", forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            if String(data: data, encoding: .utf8) != nil {
                print("done")
            }

        }.resume()

    }
    
}

