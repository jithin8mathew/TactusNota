//
//  AnnotationLiveStatsWindow.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/24/23.
//

import SwiftUI

struct AnnotationLiveStatsWindow: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(red: 0.26, green: 0.26, blue: 0.26, opacity: 0.8))
                .frame(width: 1000, height: 100)
                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//            VStack{
//                HStack{
//                    Label("\(classList.classNameList.count)", systemImage: "list.number")
//                        .font(.title)
//                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        .padding()
//                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
////                                .frame(width: 30, height: 30, alignment: .center)
//
//                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-text-and-an-icon-side-by-side-using-label
//                    Label("\(rectData.count)", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
//                        .font(.title)
//                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        .padding()
//                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//
//                    Button(action: {}){
//                        Text(classList.imageFileList.count > 0 ? "\(classList.imageFileList[0].lastPathComponent)" : "Image name")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.orange)
//                            .cornerRadius(50)
//                    }
//                    VStack{
//                        // https://www.appcoda.com/swiftui-gauge/
//                        // https://useyourloaf.com/blog/swiftui-gauges/ for more customization
//                        Gauge(value: current, in: minValue...Double(classList.imageFileList.count)) {
//                            Image(systemName: "heart.fill")
//                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        } currentValueLabel: {
//                            Text("\(Int(classList.imageFileList.count - 1))")
//                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        } minimumValueLabel: {
//                            Text("")
//                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        } maximumValueLabel: {
//                            Text("\(Int(classList.imageFileList.count))")
//                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                        }
//                        .gaugeStyle(.accessoryCircular)
//                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                    } // end of vStack which is not used really
//
//                    // add a quick clear button
//                    Button(action: {
//                        rectData=[]
//                    }){
//                        Text("Clear")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.red)
//                            .cornerRadius(50)
//                    }
//                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//
//                    VStack{ // Vstack for undo and redo-button
//                        Button(action:{}){
//                            Image(systemName:"arrow.uturn.backward.circle")
//                                .resizable()
//                                .foregroundColor(.white)
//                                .padding(.all,3)
//                                .cornerRadius(50)
//                                .frame(width:25, height: 25, alignment: .center)
//                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                            }
//                        Button(action:{}){
//                            Image(systemName:"arrow.uturn.forward.circle")
//                                .resizable()
//                                .foregroundColor(.white)
//                                .padding(.all,3)
//                                .cornerRadius(50)
//                                .frame(width:25, height: 25, alignment: .center)
//                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                        }
//                    }
//
//                    Button(action:{
//                        showQuickSettings.toggle()
//                    }){
////                                Image(systemName: "chevron.down")
//                        Image(systemName: "gear")
//                            .resizable()
//                            .foregroundColor(.white)
//                            .padding(.all,5)
//                            .frame(width:25, height: 25, alignment: .center)
//                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//
//                    }
//                    .sheet(isPresented: $showQuickSettings) {
//                        AnnotationQuickSettingsPopUp()
//                        // display quick settings here
//                    }
//                    .padding(.all, 3)
//                    .background(Color(red: 0.21, green: 0.21, blue: 0.21))
//                    .cornerRadius(35)
//                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                    .help(Text("Clear all the annotations"))
//                } // end of Hstack
//
//                // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
//                ScrollView(.horizontal) {
//                    HStack(spacing: 1) {
//                        if (classList.classNameList.count > 0){
//                            ForEach(classList.classNameList , id: \.self) { cls in
//                                Text(cls)
//                                    .foregroundColor(.white)
//                                    .font(.footnote)
//                                    .frame(width: 70, height: 20, alignment: .center)
//                                    .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                                    .cornerRadius(2)
//                            }
//                        }
//                    }
//                }
//                .environmentObject(classList)
//                .frame(minWidth: 400, maxWidth: 700, minHeight: 10, maxHeight: 25)
//                .padding()
//            } // end of Vstack used to put scrolling class selection button
        }
    }
}

struct AnnotationLiveStatsWindow_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationLiveStatsWindow()
    }
}
