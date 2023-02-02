//
//  MainViewModel.swift
//  TipCalculator
//
//  Created by Vladut Mihai Poncea on 02.02.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var percentages: [Int] = [0, 10, 15, 20, 25]
    @Published var selectedPercentage: Int = 0
    
    init() {
        selectedPercentage = percentages[1]
    }
}
