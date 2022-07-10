//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-10.
//

import SwiftUI

struct RectangleCard: View {
    var height:CGFloat = 48
    var colour:Color = Color.white
    var body: some View {
        Rectangle()
            .foregroundColor(colour)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height:height)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
