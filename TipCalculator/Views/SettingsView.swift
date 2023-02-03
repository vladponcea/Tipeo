//
//  SettingsView.swift
//  TipCalculator
//
//  Created by Vladut Mihai Poncea on 02.02.2023.
//

import SwiftUI

struct SettingsView: View {
    
    /// - View Properties
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var darkModeIsOn: Bool = false
    
    @AppStorage("color_scheme") private var storageColorScheme: Int = 0
    
    
    var body: some View {
        ZStack {
            List {
                HStack {
                    Text("Dark mode")
                        .font(.system(size: 20, weight: .regular))
                    
                    Toggle("", isOn: $darkModeIsOn)
                        .tint(colorScheme == .light ? .black : .white)
                        .onChange(of: darkModeIsOn) { newValue in
                            if newValue {
                                storageColorScheme = 1
                            } else {
                                storageColorScheme = 0
                            }
                        }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if storageColorScheme == 0 {
                darkModeIsOn = false
            } else {
                darkModeIsOn = true
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
//                .preferredColorScheme(.dark)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
