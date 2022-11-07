////
////  testView.swift
////  TactusNota
////
////  Created by Jithin Mathew on 7/27/22.
////
//
//import SwiftUI
//
////struct testView: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
//
////struct testView: View {
////    @State var viewState = CGSize.zero
////    @State var location = CGPoint.zero
////
////    var body: some View {
////        RoundedRectangle(cornerRadius: 10)
////            .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
////            .frame(width: viewState.width + 200, height: viewState.height + 200)
////            .offset(x: viewState.width , y: viewState.height )
////            .position(x: location.x , y: location.y)
////            .gesture(
////                DragGesture().onChanged { value in
////                    viewState = value.translation
////                    self.location = value.location
////                }
////                .onEnded { value in
////                    withAnimation(.spring()) {
////                        viewState = value.translation
////                    }
////                }
////            )
//////        Text("Location: (\(location.x), \(location.y))")
////    }
////}
////
//
//
//
//import SwiftUI
//
//struct testView: View {
//    let minWidth: CGFloat = 100
//    let minHeight: CGFloat = 100
//    @State var width: CGFloat?
//    @State var height: CGFloat?
//
//    var body: some View {
//        HStack(alignment: .center) {
//            Spacer()
//            ZStack{
//                
//            }
//            
//            ZStack{
//                RedRectangle(width: width ?? minWidth, height: height ?? minHeight)
//
//                Resizer(width: width ?? minWidth, height: height ?? minHeight)
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged { value in
//                                width = width! + value.translation.width
//                                height = height! + value.translation.width
//                            }
//                    )
//            }
//
//            Spacer()
//        }
//        .onAppear {
//            width = minWidth
//            height = minHeight
//        }
//    }
//}
//
//struct RedRectangle: View {
//    let width: CGFloat
//    let height: CGFloat
//
//    var body: some View {
//        Rectangle()
//            .fill(Color.red)
//            .frame(width: width, height: height)
//    }
//}
//
//struct Resizer: View {
//    let width: CGFloat
//    let height: CGFloat
//    
//    var body: some View {
//        Circle()
//            .fill(.yellow)
//            .frame(width: 20, height: 20)
//            .offset(x: width + (-width/2) , y: height + (-height/2))
////            .position(x: width + width , y: height + (-height/2))
//    }
//}
//
//struct testView_Previews: PreviewProvider {
//    static var previews: some View {
//        testView()
//    }
//}
