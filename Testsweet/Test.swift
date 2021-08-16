//
//  Test.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/16/21.
//

import Foundation


class Test {
    
    private var title: String
    private var description: String
    private var expected_result: String = ""
    
    private var filePath: String = ""
    private var entriesList: Array<Entry> = []
    
    
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
