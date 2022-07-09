//
//  CodeTextView.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-09.
//

import SwiftUI


struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel

    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = model.lessonDescription
        
        // scroll to top
        textView.scrollRectToVisible(CGRect(x:0, y:0, width:1, height:1), animated: false)
        
    }
    
}
