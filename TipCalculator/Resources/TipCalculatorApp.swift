//
//  TipCalculatorApp.swift
//  TipCalculator
//
//  Created by Vladut Mihai Poncea on 02.02.2023.
//

import SwiftUI

@main
struct TipCalculatorApp: App {
    
    @AppStorage("color_scheme") private var storageColorScheme: Int = 0
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(storageColorScheme == 0 ? .light : .dark)
        }
    }
}
