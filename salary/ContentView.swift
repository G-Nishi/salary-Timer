//
//  ContentView.swift
//  salary
//
//  Created by NG on 2024/01/31.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State var timerHandler: Timer?
    @State var remainingMinutes = 0
    @State var remainingSeconds = 0
    @State var earnedAmount = 0.0
    @AppStorage("timer_value") var timerValue = 0
    @AppStorage("hourly_value") var hourlyValue = 0.0
    
    @State var showAlert = false
    
    init() {
        _remainingMinutes = State(initialValue: timerValue)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.gray)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("残り時間")
                            .foregroundStyle(.green)
                        Text("\(String(format: "%02d:%02d", remainingMinutes, remainingSeconds))")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                        Text("\(earnedAmount, specifier: "%.2f")円")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .padding()
                    HStack {
                        Button {
                            startTimer()
                        } label: {
                            Text("start")
                                .font(.title)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                        }
                        Button {
                            if let unwrapedTimerHandler = timerHandler {
                                if unwrapedTimerHandler.isValid == true {
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("stop")
                                .font(.title)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                        }
                    }
                    .padding()
                    Button {
                        timerHandler?.invalidate()
                        remainingMinutes = timerValue
                        remainingSeconds = 0
                        earnedAmount = 0.0
                    } label: {
                        Text("reset")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .background(.green)
                    }
                    .padding()
                    
                }
            }
            .onAppear {
                timerHandler?.invalidate()
                remainingMinutes = timerValue
                remainingSeconds = 0
                earnedAmount = 0.0
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("秒数設定")
                    }
                }
            }
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    print("OKタップされました")
                }
            } message: {
                Text("お疲れ様でした")
            }
        }
    }
    
    func countDownTimer() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
        } else if remainingMinutes > 0 {
            remainingMinutes -= 1
            remainingSeconds = 59
        } else {
            timerHandler?.invalidate()
            showAlert = true
        }
        earnedAmount += hourlyValue
    }
    
    func startTimer() {
        if let unwrapedTimerHandler = timerHandler {
            if unwrapedTimerHandler.isValid {
                return
            }
        }
        
        if remainingMinutes == 0 && remainingSeconds == 0 {
            remainingMinutes = timerValue
            remainingSeconds = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
        }
    }
}

#Preview {
    ContentView()
}
