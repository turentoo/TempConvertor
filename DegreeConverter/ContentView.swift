//
//  ContentView.swift
//  DegreeConverter
//
//  Created by Alice Nedosekina on 25/11/2020.
//

import SwiftUI

protocol TempConvertor {
    func toKelvin(value: String) -> Double
    func toTarget(value: Double) -> String
}

struct CelsiusConvertor : TempConvertor {
    func toKelvin(value: String) -> Double {
        return Double(value)! + 273.15
    }
    
    func toTarget(value: Double) -> String {
        return "\(roundTemp(value: value - 273.15))"
    }
}

struct FahrenheitConvertor : TempConvertor {
    func toKelvin(value: String) -> Double {
        return  ( Double(value)! + 459.67 ) * 5 / 9
    }
    
    func toTarget(value: Double) -> String{
        return "\(roundTemp(value: ( value * 9 / 5) - 459.67))"
    }
}

struct KelvinConvertor : TempConvertor {
    func toKelvin(value: String) -> Double {
        return Double(value)!
    }
    
    func toTarget(value: Double) -> String {
        return "\(roundTemp(value: value))"
    }
}


func roundTemp (value: Double) -> Double {
    print(round( 100 * value ) / 100)
    return round( 100 * value ) / 100
    
}



struct ContentView: View {
    @State private var fromUnit: Int = 0
    @State private var toUnit: Int = 0
    @State private var valueToConvert: String = ""
    
    
    var isEmpty : Bool {
        return valueToConvert == ""
    }
    
    var isValid : Bool {
        return !isEmpty && Double(valueToConvert) != nil
    }
    
    
    var convertors : [TempConvertor] = [CelsiusConvertor(), KelvinConvertor(), FahrenheitConvertor()]
    
    
    var output: String {
        let convertedToKelvin = convertors[fromUnit].toKelvin(value: valueToConvert)
        let result = convertors[toUnit].toTarget(value: convertedToKelvin)
        
        return "\(result)"
        
    }
    
    
    let degreeScales = ["Celsius", "Kelvin", "Fahrenheit"]
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Convert from")) {
                        Picker(selection: $fromUnit, label: Text("Convert from"), content: {
                            ForEach (0 ..< degreeScales.count){
                                Text("\(degreeScales[$0])")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        
                        
                    }
                    Section (header: Text("Convert to")) {
                        Picker(selection: $toUnit, label: Text("Convert from"), content: {
                            ForEach (0 ..< degreeScales.count){
                                Text("\(degreeScales[$0])")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }
                    Section (header: Text("Enter value")) {
                        TextField("Value", text: $valueToConvert)
                            .keyboardType(.numberPad)
                        
                    }
                }
                Spacer()
                    .frame(height: 40)
                
                
                
                if isEmpty {
                    Text("Enter value to convert")
                }
                
                else if !isValid {
                    Text("Value is not valid")
                }
                
                else {
                    
                    Text("""
                    \(valueToConvert) \(degreeScales[fromUnit]) equals
                    \(output) \(degreeScales[toUnit])
                    """)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    
                    
                    
                }
                
                
                
                Spacer()
                .frame(height: 40)
            }
            .navigationTitle("Degree convertor")
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
