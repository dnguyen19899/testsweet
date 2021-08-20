//
//  TestsweetApp.swift
//  Testsweet
//
//  Created by Duy Nguyen on 7/26/21.
//

import SwiftUI

@main
struct TestsweetApp: App {
    @StateObject private var theme = Themes()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(theme)
        }
    }
}
