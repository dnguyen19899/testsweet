//
//  Test.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/16/21.
//

import Foundation


struct Entry: Hashable, Codable {
    
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


class Test: Codable, Hashable {
    
    var id: UUID
    var title: String
    var description: String
    var expected_result: String
    
    var filePath: String = ""
    var entriesList: Array<Entry> = [Entry]()
    var action: Int // 1 for CSV method, 2 for manual method
    
    
    // init for CSV file method
    init(title: String, description: String, expected_result: String, filePath: String, action: Int) {
        
        self.id = UUID()
        self.title = title
        self.description = description
        self.expected_result = expected_result
        self.filePath = filePath
        self.action = action
    }
    
    // init for manual list method
    init(title: String, description: String, expected_result: String, entriesList: [Entry], action: Int) {
        
        self.id = UUID()
        self.title = title
        self.description = description
        self.expected_result = expected_result
        self.entriesList = entriesList
        self.action = action
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func ==(lhs: Test, rhs: Test) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.description == rhs.description && lhs.expected_result == rhs.expected_result && lhs.action == rhs.action
    }

    // run function for CSV file method
    func run() -> (Int64, String) {
        let NSController = NightscoutController(date: Date())

        // if tag 1, run import via CSV
        if self.action == 1 {
            return (NSController.importCSVData(date: NSController.getTimeStamp(), filePath: filePath), expected_result)
        }

        // if tag 2, run import via entries list
        else if self.action == 2 {
            return (Int64(NSController.populateGraphWithEntryList(date: NSController.getTimeStamp(), entries: entriesList)), expected_result)
        }

        else {
            return (0, "nothing")
        }
    }
}
