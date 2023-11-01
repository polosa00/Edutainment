//
//  ContentView.swift
//  Edutainment
//
//  Created by Александр Полочанин on 1.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkingNumber = 1
    @State private var numberOfQuestions = 10
    @State private var isStartGame = false
    
    let numbers  = [5, 10, 15, 20]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Form {
                    Section {
                        
                        VStack(alignment: .center, spacing: 15) {
                            Text("What value do you want to check?")
                                .bold()
                                .font(.headline)
                            Stepper("\(checkingNumber)", value: $checkingNumber, in: 1...9)
                        }
                       
                        
                        VStack(alignment: .center, spacing: 15) {
                            Text("Choose number of questions")
                                .bold()
                                .font(.headline)
                            Picker( "numbers", selection: $numberOfQuestions) {
                                ForEach(numbers, id: \.self) { number in
                                    Text("\(number)")
                                }
                            }
                            .pickerStyle(.segmented)
                            
                        }
                        
                       
            
                    } header: {
                        Text("Settings")
                            .font(.headline)
                            .foregroundStyle(.indigo)
                    }
                    .padding(.horizontal, 10)
                    

                }
                .navigationTitle("Edutainment")
            .formStyle(.grouped)
            }
            
            
            NavigationLink {
                QuestionsView(numberOfQuestions: numberOfQuestions, checkingNumber: checkingNumber)
            } label: {
                Text("Start game")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.indigo)
                    .padding()
                    .shadow(radius: 3)
            }
            .background(.orange)
        }
    }
}




#Preview {
    ContentView()
}
