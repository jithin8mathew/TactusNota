//
//  ContentView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 1/6/22.
//

import SwiftUI

// ghp_mcWpwlDSR8Qp4qPx0nyFOYASaXqErtrRS2crtrttnrrtrZ

struct ContentView: View {
    var body: some View {
        ZStack{
        NavigationView{
            
            VStack{
            
                HStack{
                    Button(action: {
                                        }, label: {
                                            Text("Images")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Save directory")
                                            .font(.system(.title2))
                                            .frame(width: 160, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Previous")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Next")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Save")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    
                }
                
                Image("test1")
                    .resizable()
            }
            
           

        }.navigationViewStyle(StackNavigationViewStyle()) // end of Navigation View// end of navigation view
        .padding(.all, 0)
        } // end of zstack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
