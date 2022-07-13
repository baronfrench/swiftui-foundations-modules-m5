//
//  TestResultView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-13.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var numCorrect:Int
    var wording:String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let percent: Double = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if percent > 0.5 {
            return "Awesome"
        }
        else if percent > 0.2 {
            return "Doing Great!"
        }
        else {
            return "Keep Learning"
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(wording)
                .font(.title)
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) right")
            Spacer()
            Button(action: {
                model.currentTestSelected = nil
            }) {
                ZStack {
                    RectangleCard(colour:.green)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()

                
            }
            Spacer()
        }
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView(numCorrect: 5)
    }
}
