//
//  statusUpdateView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/7/23.
//

import SwiftUI
import Charts

struct statusUpdateView: View {
    
    private var showStatusView = true
    @State private var AnnotationPointDensity: [Int] = [34, 43, 43, 65, 66, 98, 63,12, 53, 95, 66, 34, 66, 89, 94, 29]
    
    //https://swdevnotes.com/swift/2022/create-a-bar-chart-with-swiftui-charts-in-ios-16/
//    let annotStat: [annot] = [
//        annot(customID: 1, annotCount:34)
//    ]
    
    var body: some View {
        VStack(spacing: 0){
            Text("Statistics")
                .font(.custom("Playfair Display", fixedSize: 20))
//            Chart{
//                ForEach(AnnotationPointDensity) {annotations in
//                    BarMark(x:1, y: annotations)
//                }
//            }
//
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(.purple)
        .cornerRadius(10)
        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 15, x: 5, y: 5)
    }
}

struct statusUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        statusUpdateView()
    }
}
