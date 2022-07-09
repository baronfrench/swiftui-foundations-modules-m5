//
//  ContentModel.swift
//  LearningApp
//
//  Created by Christopher Ching on 2021-03-03.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current Lesson Explaination
    @Published var lessonDescription = NSAttributedString()

    
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
    // MARK: - Data methods
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            // TODO log error
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            // Log error
            print("Couldn't parse style data")
        }
        
    }

    //  MARK: - Module navigation methods
    func beginModule(_ moduleid:Int) {
        
        // Find index for the moduleid
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break;
            }
            
        }
        
        // Set current module
        currentModule = modules[currentModuleIndex]
        
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        // Check lesson index in range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set current module
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // set explaination
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() ->  Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    func nextLesson() {
        // advance to next lesson index
        currentLessonIndex += 1
        
        // check in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    // MARK: - Code Styling
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if(styleData != nil) {
            data.append(self.styleData!)
        }
        
        // add html
        data.append(Data(htmlString.utf8))
        
        // convert to attributed string
        // assinging to constant and using ? means it runs code with {} if success only, else nothing happens
        // this instead of do...catch
        if let attributedString = try? NSAttributedString(data: data,
                                                         options: [.documentType:NSAttributedString.DocumentType.html],
                                                         documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
    

}
