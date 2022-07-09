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
                        ContentViewBox(index: index)
                    }
                    
                }
                
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
        
    }
}
