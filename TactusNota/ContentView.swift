//
//  ContentView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 1/6/22.
//

import SwiftUI

// ghp_mcWpwlDSR8Qp4qPx0nyFOYASaXqErtrRS2crtrttnrrtrZ

struct ContentView: View {
    
    @StateObject var model = AnnotationViewModel()
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
            
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
                
                if let ImageFile = UIImage(data: model.imageData){
                    
                    AnnotationScreen()
                        .environmentObject(model)
//                    Image(uiImage: ImageFile)
//                        .resizable()
//                        .cornerRadius(20)
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all, 10)
                       
                    
                }
                else{
                    Button(action: {model.showImagePicker.toggle()},
                           label: {
                        Image("test1")
                            .resizable()
                            .cornerRadius(20)
                            .font(.title)
                            .padding(.all, 5)
                        
                            
                         
                    }).padding(.all, 25)
                }
//                Image("test1")
//                    .resizable()
            } // end of vstack
            .sheet(isPresented: $model.showImagePicker, content: {ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)})
            
           

        }
        } // end of zstack
        .navigationViewStyle(StackNavigationViewStyle()) // end of Navigation View// end of navigation view
        .padding(.all, 0)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
