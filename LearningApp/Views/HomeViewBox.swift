//
//  HomeViewBox.swift
//  LearningApp
//
//  Created by Baron French on 2022-07-08.
//

import SwiftUI

struct HomeViewBox: View {
    
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    var body: some View {
    
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width:335,height:175), contentMode: .fit)
                
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack (alignment: .leading, spacing:10){
                    Text(title)
                        .bold()
                    Text(description)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)

                    HStack {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width:15,height:15)
                        Text(count)
                            .font(Font.system(size: 10))
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width:15,height:15)
                        Text(time)
                            .font(.caption)
                        
                    }
                }
                
            }
            .padding(.horizontal, 20)
            
        }
        

    }
}

struct HomeViewBox_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewBox(image: "swift", title: "Learn Swift", description: "Swift", count: "10 Lessons", time: "1 Hour")
    }
}
