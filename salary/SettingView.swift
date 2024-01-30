//
//  SettingView.swift
//  MyTimer
//
//  Created by NG on 2024/01/31.
//

import SwiftUI

struct SettingView: View {
    @State var inputHours = ""
    @State var inputMinutes = ""
    @State var inputHourly = ""

    @AppStorage("timer_value") var timerValue = 0
    @AppStorage("hourly_value") var hourlyValue = 0.0

    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack {
                    Text("\(timerValue)分")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                    Text("秒給：\(hourlyValue, specifier: "%.2f")円")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding()
                
                VStack {
                    HStack {
                        TextField("Hours", text: $inputHours)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        TextField("Minutes", text: $inputMinutes)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }
                    TextField("Hourly wage", text: $inputHourly)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }
                .padding()

                Button("Set Timer") {
                    if let hours = Int(inputHours), let minutes = Int(inputMinutes) {
                        timerValue = hours * 60 + minutes
                    }
                    
                    if let salary = Double(inputHourly) {
                        hourlyValue = salary / 3600.0
                    }
                }
                .font(.title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(.green)
                .padding()

                Spacer()
                
            }
            .padding()
            
        }
    }
}

#Preview {
    SettingView()
}
