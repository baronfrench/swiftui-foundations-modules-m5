//
//  ContentView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-09.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
       
        ScrollView {
            
            LazyVStack {
                
                // confirm currentModule set
                if model.currentModule != nil {
                
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        NavigationLink(
                            destination: ContentDetailView()
                                .onAppear(perform:{
                                    model.beginLesson(index)
                                }),
                            label: {
                                ContentViewBox(index: index)
                            })
                    }
                    
                }
                
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
        
    }
}
