//
//  ContentView.swift
//  Chlg-01-TempConverter
//
//  Created by Андрей Бородкин on 08.08.2023.
//

import SwiftUI



struct ContentView: View {
    
    enum TemperatureType: String {
        case celsius = "°C", fahrenheit = "°F", kelvin = "K"
    }
    
    var possibleTempTypes: [TemperatureType] = [.celsius, .fahrenheit, .kelvin]
    
    @State private var inputTemp: Double = 20
    @State private var selectedInputType: TemperatureType = .celsius
    @State private var selectedOutputType: TemperatureType = .fahrenheit
    
    var convertedTemp: Double {
        let baseTempInCelsius: Double
        let outputTemp: Double
        
        switch selectedInputType {
        case .celsius:
            baseTempInCelsius = inputTemp
        case .fahrenheit:
            baseTempInCelsius = (inputTemp - 32) * 5/9
        case .kelvin:
            baseTempInCelsius = inputTemp - 273.15
        }
        
        switch selectedOutputType {
        case .celsius:
            outputTemp = baseTempInCelsius
        case .fahrenheit:
            outputTemp = (baseTempInCelsius * 9/5) + 32
        case .kelvin:
            outputTemp = baseTempInCelsius + 273.15
        }
        
        return outputTemp
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Enter temp", value: $inputTemp, format: .number)
                    Picker("Input temperature", selection: $selectedInputType) {
                        ForEach(possibleTempTypes, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                } header: {
                    Text("Please select input temp")
                }
                
                Section{
                    Picker("Input temperature", selection: $selectedOutputType) {
                        ForEach(possibleTempTypes, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output Type")
                }
                
                Section {
                    Text(convertedTemp, format: .number)
                } header: {
                    Text("Converted Temperature")
                }
            }
            .navigationTitle("Temperature converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
