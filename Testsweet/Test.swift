//
//  Test.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/16/21.
//

import Foundation


struct Entry: Hashable {
    var sgv: Int = 0
    var direction: String = ""
    
    init(raw: [String]) {
        sgv = Int(raw[0]) ?? -1
        direction = raw[1]
    }
    
    init(sgv: String, direction: String) {
        self.sgv = Int(sgv) ?? -1
        self.direction = direction
    }
    
    func toString() -> String{
        if(sgv == -1 && direction == "") {
            return ""
        }
        else {
            return String(self.sgv) + ", " + self.direction
        }
    }
}


class Test {
    
    var title: String
    var description: String
    var expected_result: String = ""
    
    var filePath: String = ""
    var entriesList: Array<Entry> = []
    
    
    // init for CSV file method
    init(title: String, description: String, expected_result: String, filePath: String) {
        self.title = title
        self.description = description
        self.expected_result = expected_result
        self.filePath = filePath
    }
    
    // init for manual list method
    init(title: String, description: String, expected_result: String, entriesList: [Entry]) {
        self.title = title
        self.description = description
        self.expected_result = expected_result
        self.entriesList = entriesList
    }

    // run function for CSV file method
    func runFromCSV() -> Int64 {
        let NSController = NightscoutController(date: Date())
        return NSController.importCSVData(date: NSController.getTimeStamp(), filePath: filePath)
    }
    
    // run function for entries list method
    func runFromEntriesList() -> Int {
        let NSController = NightscoutController(date: Date())
        return NSController.populateGraphWithEntryList(date: NSController.getTimeStamp(), entries: entriesList)
    }
    
}
