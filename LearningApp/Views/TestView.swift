//
//  TestView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-10.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answers
                
                // Button
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
