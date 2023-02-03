//
//  MainView.swift
//  TipCalculator
//
//  Created by Vladut Mihai Poncea on 02.02.2023.
//

import SwiftUI

struct MainView: View {
    
    /// - View Properties
    @State private var billTotal: String = ""
    @State private var people: Int = 1
    @State private var totalPerPerson: Double = 0.0
    @State private var tipPerPerson: Double = 0.0
    @State private var totalTip: Double = 0.0
    
    @State private var toggleCustomAmount: Bool = false
    
    @StateObject private var viewModel = MainViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Bill Total")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(.secondary)
                        
                        TextField("0.00", text: $billTotal)
                            .keyboardType(.decimalPad)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .font(.system(size: 40, weight: .bold))
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Tip")
                                .font(.system(size: 25, weight: .regular))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button(action: {
                                toggleCustomAmount.toggle()
                            }, label: {
                                Text("Custom amount")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.primary.opacity(0.5))
                            })
                        }
                        
                        HStack(spacing: 10) {
                            if toggleCustomAmount {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.secondary.opacity(0.1))
                                    .frame(width: Constants.defaultScreenWidth, height: 50)
                                    .overlay {
                                        HStack(spacing: 20) {
                                            Button(action: {
                                                if viewModel.selectedPercentage != 0 {
                                                    viewModel.selectedPercentage -= 1
                                                }
                                            }, label: {
                                                Circle()
                                                    .fill(Color.secondary.opacity(0.2))
                                                    .frame(width: 30, height: 30)
                                                    .overlay {
                                                        Image(systemName: "minus")
                                                            .foregroundColor(.primary)
                                                    }
                                            })
                                            
                                            Text("\(viewModel.selectedPercentage)%")
                                                .font(.system(size: 30, weight: .bold))
                                            
                                            Button(action: {
                                                viewModel.selectedPercentage += 1
                                            }, label: {
                                                Circle()
                                                    .fill(Color.secondary.opacity(0.2))
                                                    .frame(width: 30, height: 30)
                                                    .overlay {
                                                        Image(systemName: "plus")
                                                            .foregroundColor(.primary)
                                                    }
                                            })
                                        }
                                    }
                            } else {
                                ForEach(viewModel.percentages, id: \.self) { percentage in
                                    Button(action: {
                                        viewModel.selectedPercentage = percentage
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(viewModel.selectedPercentage == percentage ? Color.primary : Color.secondary.opacity(0.1))
                                            .frame(width: Constants.defaultScreenWidth/5 - 40/5, height: 50)
                                            .overlay {
                                                Text("\(percentage)%")
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .foregroundColor(viewModel.selectedPercentage == percentage ? (colorScheme == .light ? .white : .black) : (colorScheme == .light ? .black : .white))
                                            }
                                    })
                                }
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.secondary.opacity(0.1))
                        .frame(height: 200)
                        .overlay {
                            VStack() {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("People")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.secondary)
                                        
                                        HStack(spacing: 20) {
                                            Button(action: {
                                                if people != 1 {
                                                    people -= 1
                                                }
                                            }, label: {
                                                Circle()
                                                    .fill(Color.secondary.opacity(0.2))
                                                    .frame(width: 30, height: 30)
                                                    .overlay {
                                                        Image(systemName: "minus")
                                                            .foregroundColor(.primary)
                                                    }
                                            })
                                            
                                            Text("\(people)")
                                                .font(.system(size: 30, weight: .bold))
                                            
                                            Button(action: {
                                                people += 1
                                            }, label: {
                                                Circle()
                                                    .fill(Color.secondary.opacity(0.2))
                                                    .frame(width: 30, height: 30)
                                                    .overlay {
                                                        Image(systemName: "plus")
                                                            .foregroundColor(.primary)
                                                    }
                                            })
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Total Per Person")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.secondary)
                                        
                                        Text("\(String(format: "%.2f", totalPerPerson))")
                                            .font(.system(size: 40, weight: .bold))
                                    }
                                }
                                
                                Spacer()
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Tip Per Person")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.secondary)
                                        
                                        Text("\(String(format: "%.2f", tipPerPerson))")
                                            .font(.system(size: 30, weight: .bold))
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Total Tip")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.secondary)
                                        
                                        Text("\(String(format: "%.2f", totalTip))")
                                            .font(.system(size: 30, weight: .bold))
                                    }
                                }
                            }
                            .padding(20)
                        }
                }
            }
            .frame(width: Constants.defaultScreenWidth)
            .onTapGesture {
                hideKeyboard()
            }
            .onChange(of: billTotal) { _ in
                totalPerPerson = getTotalPerPerson()
                tipPerPerson = getTipPerPerson()
                totalTip = getTotalTip()
            }
            .onChange(of: people) { _ in
                totalPerPerson = getTotalPerPerson()
                tipPerPerson = getTipPerPerson()
                totalTip = getTotalTip()
            }
            .onChange(of: viewModel.selectedPercentage) { _ in
                totalPerPerson = getTotalPerPerson()
                tipPerPerson = getTipPerPerson()
                totalTip = getTotalTip()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        SettingsView()
                    }, label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    })
                }
            }
            .navigationTitle("Tipeo")
            .navigationBarTitleDisplayMode(.large)
        }
        .tint(.primary)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func getTotalPerPerson() -> Double {
        guard let billTotal = Double(billTotal) else { return 0 }
        
        return (billTotal + (billTotal * (Double(viewModel.selectedPercentage)/100)))/Double(people)
    }
    
    private func getTipPerPerson() -> Double {
        guard let billTotal = Double(billTotal) else { return 0 }
        
        return billTotal * (Double(viewModel.selectedPercentage)/100)/Double(people)
    }
    
    private func getTotalTip() -> Double {
        guard let billTotal = Double(billTotal) else { return 0 }
        
        return billTotal * (Double(viewModel.selectedPercentage)/100)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
//            .preferredColorScheme(.dark)
    }
}
