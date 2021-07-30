//
//  NumbersOnly.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/30/21.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
