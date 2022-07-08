//
//  ContentModel.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-08.
//

import Foundation

class ContentModel: ObservableObject {
    
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    func getLocalData() {
        
        // Gte file URL
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // Read json
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
        
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
        
            // assign to local variable
            self.modules = modules
            
        }
        catch {
            print(error)
        }
        
    }
    
    let styleUrl = Bundle.main.url(forResource: "tyle", withExtension: "html")
    
    do {
        let styleData = try Data(contentsOf: styleUrl)
        self.styleData = styleData
    }
    
}
