//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-09.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(fileURLWithPath: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            if url != nil {
                VideoPlayer(player:AVPlayer(url:url))
                .cornerRadius(10)
            }
            
            // Decription
            CodeTextView()
            
            // Next lesson button
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label : {
                    
                    ZStack {
                        RectangleCard(height:48, colour: .green)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            }
            else {
                // show complete button
                Button(action: {
                    model.currentContentSelected = nil // return to home view
                }, label : {
                    
                    ZStack {
                        RectangleCard(height:48, colour: .green)
                        
                        // because we are displaying styled html, we must use UIKit UITextView
                        
                        Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                    }
                })

            }
            
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
