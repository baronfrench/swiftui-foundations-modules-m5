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
            
            
            // Next lesson button
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label : {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius:5)
                            .frame(height:48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            }
            
        }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
