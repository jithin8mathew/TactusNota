//
//  display_annotations.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 5/2/23.
//

import SwiftUI

struct display_annotations: View {
    
    @Binding var annotationFileContent: String
    
    var body: some View {
        let display_text = annotationFileContent.split(separator: "\n")
        ForEach(display_text, id:\.self) {cords in
            let split_each_cord = cords.split(separator: " ")
            ScrollView(.vertical) {
                HStack{
                    Text(split_each_cord[0])
                        .foregroundColor(.white)
                        .font(.footnote)
                        .frame(width: 40, height: 20, alignment: .center)
                        .background(Color(red: 1.0, green: 0.78, blue: 0.16))
                        .cornerRadius(5)
                    
                    Text(split_each_cord[1])
                        .foregroundColor(.white)
                        .font(.footnote)
                        .frame(width: 70, height: 20, alignment: .center)
                        .background(Color(red: 1.0, green: 0.34, blue: 0.20))
                        .cornerRadius(5)
                    
                    Text(split_each_cord[2])
                        .foregroundColor(.white)
                        .font(.footnote)
                        .frame(width: 70, height: 20, alignment: .center)
                        .background(Color(red: 1.0, green: 0.34, blue: 0.20))
                        .cornerRadius(5)
                    
                    Text(split_each_cord[3])
                        .foregroundColor(.white)
                        .font(.footnote)
                        .frame(width: 70, height: 20, alignment: .center)
                        .background(Color(red: 1.0, green: 0.34, blue: 0.20))
                        .cornerRadius(5)
                    
                    Text(split_each_cord[4])
                        .foregroundColor(.white)
                        .font(.footnote)
                        .frame(width: 70, height: 20, alignment: .center)
                        .background(Color(red: 1.0, green: 0.34, blue: 0.20))
                        .cornerRadius(5)
                }
            }
        }
    }
}

