//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-08.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
