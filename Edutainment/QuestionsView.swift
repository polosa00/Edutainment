//
//  QuestionsView.swift
//  Edutainment
//
//  Created by Александр Полочанин on 1.11.23.
//

import SwiftUI

struct QuestionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var inputValue = ""
    @State private var answerValue = 0
    @State private var nextMultipleValue = 0
    @State private var scoreValue = 0
    @State private var showAlert = false
    @State  var numberOfQuestions: Int
    
    let checkingNumber: Int
    private let valuesForMultiply = [2, 3, 4, 5, 6, 7, 8, 9]
    
    
    var body: some View {
        ZStack {
            //            Color.red.ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: .indigo, location: 0.3),
                .init(color: .blue, location: 0.3)
            ], center: .top, startRadius: 250, endRadius: 700).ignoresSafeArea()
            VStack (spacing: 30) {
                Spacer()
                Text("Score: \(scoreValue)")
                    .font(.title)
                    .bold()
                    .foregroundStyle(showAlert ? .indigo : .white)

                VStack(alignment: .center, spacing: 20) {
                    
                    HStack(spacing: 15) {
                        
                        HStack {
                            Text("\(checkingNumber)")
                                .font(.title)
                                .bold()
                                .frame(width: 40)
                                .foregroundStyle(.white)
                            
                            Text("x")
                                .bold()
                            
                            Text("\(nextMultipleValue)")
                                .font(.title)
                                .bold()
                                .frame(width: 40)
                                .foregroundStyle(.white)
                        }
                        Text("?")
                            .font(.title)
                    }
                    .font(.largeTitle)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(.orange)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    
                    HStack {
                        TextField("Enter your answer", text: $inputValue)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 45)
                    }
                    
                    Button {
                        if numberOfQuestions > 1 {
                            answerValue = Int(inputValue) ?? 1
                            checkMultiple(checkingNumber, and: nextMultipleValue)
                            inputValue = ""
                        } else {
                            inputValue = ""
                            showAlert = true
                        }
                    } label: {
                        
                        Text("Check Answer")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(.indigo)
                            .clipShape(.capsule)
                    }
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                }
                .onAppear(perform:nextRandomMultipleValue)
                .onSubmit {checkValue(value: inputValue)}
                .frame(height: 300)
                .frame(width: 300)
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Count down of questions is: \(numberOfQuestions)")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .bold()
                Spacer()
                
            }
            
        }
        .toolbar(.hidden)
        .alert(isPresented: $showAlert) {
            Alert(
                 title: Text("Questions is over"),
                 message: Text("You score is: \(scoreValue)"),
                 primaryButton: .default(Text("Try again"), action: {
                     dismiss.callAsFunction()
                 }),
                 secondaryButton: .cancel()
             )
        }
        
        
    }
    
    func checkValue(value: String) {
        answerValue = Int(value) ?? 1
    }
    
    func nextRandomMultipleValue() {
        nextMultipleValue = valuesForMultiply.randomElement() ?? 1
        
    }
    
    func checkMultiple(_ numberOne: Int, and numberTwo: Int) {
        let checkedValue = numberOne * numberTwo
        if answerValue == checkedValue {
            print(answerValue)
            nextRandomMultipleValue()
            countDown()
            scoreValue += 1
        } else {
            scoreValue -= 1
        }
    }
    
    func countDown() {
        numberOfQuestions -= 1
    }
}

#Preview {
    QuestionsView(numberOfQuestions: 1, checkingNumber: 5)
}
