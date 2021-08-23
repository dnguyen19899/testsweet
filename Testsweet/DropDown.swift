//
//  MenuBar.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/5/21.
//

import Foundation
import SwiftUI


struct DropdownButton: View {
    
    @State var shouldShowDropdown = false
    @Binding var displayText: String
    var options = [String]()
    
    var body: some View {
        ZStack{
            Button(action: {
                shouldShowDropdown.toggle()
            }, label: {
                Text(displayText)
            })
        }
    }
}
