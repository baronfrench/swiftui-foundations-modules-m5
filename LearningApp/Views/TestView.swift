//
//  TestView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-10.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment:.leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id:\.self) { index in
                            
                            
                            Button(
                                action: {
                                    //tracked selected index
                                    selectedAnswerIndex = index
                                },
                                label:{
                                    ZStack {
                                        
                                        if !submitted {
                                            RectangleCard(colour:index == selectedAnswerIndex ? .gray : .white)
                                        }
                                        else if index == selectedAnswerIndex &&
                                                index == model.currentQuestion!.correctIndex {
                                            // correct answer
                                            RectangleCard(colour:.green)
                                        }
                                        else if index == selectedAnswerIndex &&
                                                index != model.currentQuestion!.correctIndex {
                                            // wrong number
                                            RectangleCard(colour:.red)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(colour:.green)
                                        }
                                        else {
                                            RectangleCard(colour:.white)
                                        }
                                        Text(model.currentQuestion!.answers[index])
                                        
                                    }
                                    .padding(5)
                                })
                            .disabled(submitted)
                        }
                    }
                }
                
                // Button
                Button(
                    action:{
                        // check the answer, and increemtn countrer if ocffect
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                        submitted = true
                    },
                    label: {
                        ZStack {
                            RectangleCard(height:48, colour:.green)
                            Text("Submit")
                                .foregroundColor(.white)
                                .bold()
                            
                        }
                        .padding(5)
                    })
                .disabled(selectedAnswerIndex == nil)
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        }
        else {
            // Test hasn't loaded yet
            ProgressView() // this is the spinning circle
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
