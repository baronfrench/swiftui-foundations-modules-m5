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
    
    // currentQuestion
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current Lesson Explaination
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // current selected lesson and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        
        getLocalData() // parses local data
        getRemoteData() // gets data from github and parses
        
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

    func getRemoteData() {
        
        let urlString = "https://baronfrench.github.io/learningapp-data/data2.json"
        let url = URL(string:urlString)
        
        guard url != nil else {
            return
        }
        
        let request = URLRequest(url: url!)
        
        // get session and start task
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                    // there was an error
                return
            }
            
            // Try to decode the json into an array of modules
            do {
                let jsonDecoder = JSONDecoder()
                let modules = try jsonDecoder.decode([Module].self, from: data!)
                self.modules += modules
            }
            catch {
                print("error - parsing remote json")
            }
            
        })
        
        // start data task
        dataTask.resume()
        
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
    
    // MARK: - Lesson funcs
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
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // advance to next lesson index
        currentLessonIndex += 1
        
        // check in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() ->  Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    // MARK: - Test funcs
    func beginTest(_ moduleId:Int) {
        beginModule(moduleId)
        
        currentQuestionIndex = 0
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0  > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion() {
        // advance index
        currentQuestionIndex += 1
        
        // check in range && set
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
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
