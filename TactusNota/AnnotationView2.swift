//
//  AnnotationView2.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/21/23.
//

import SwiftUI
import Foundation

struct AnnotationView2: View {
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    @State private var offset = CGSize.zero
    @State var viewState = CGSize.zero
    
    @State var withingBBox = false
    
    @State var didLongPress = false
    @GestureState var isLongPressing = false
    @State var completedLongPress = false
    @State var previous_offsetX = 0.0
    @State var previous_offsetY = 0.0
    @State var boxIDVAL = 0
    @State var test_boxIDVAL = 0
    @State var previous_boxIDVAL = 0
    // used to keep track of the bounding box corner that is being dealt with
    @State var C1 = false   // top left
    @State var C2 = false   // top right
    @State var C3 = false   // bottom left
    @State var C4 = false   // bottom right
    
    @State var dragLock = false // This section prevents from dragging the bounding boxes around
    @State var resizeLock = false // This section prevents the bounding box from being resized
    
    @State var prev_f_width = 0.0 // temp var for prev width - current width
    @State var prev_f_height = 0.0 // temp var for prev hieght - current height
    
    @State var cordData: [[CGFloat]] = [] // cordData is a temporary list that gets populated with coordinates when bbox edge is dragged. The purpose of this list is to substract the previous cordinate values from the current. The differecne is used to resize the bounding box.
    
    //    @State private var progress = 0.5 // This will let the user know what percentage of the data is annotated so far.
    @State private var current = 67.0
    @State private var minValue = 0.0
    @State private var maxValue = 170.0
    @State private var annotationClassList: [String] = ["apple","car","bus","cat"]
    //    annotationClassList = ["apple","car","bus","cat"]
    
    // implementing file picking from folder
    @State private var folderc_main: [URL] = []
    //    @StateObject var classList = ClassList()
    @EnvironmentObject var classList: ClassList
    //    @Binding var classNamesAnnot: [String]
//    @State private var image2 = UIImage(systemName: "xmark")! // this is the main variable that holds the to be annotated image
    @State private var image = UIImage()
    
    @AppStorage("ANNOTATION_COORDINATES") var annotation_coordinates: Data = Data() // we know that appstorage cannot be directly used to store coordinates.
    
    @State private var isShowingDialog = false
    // handling apple pencil input
    //    var estimates : [NSNumber : StrokeSample]
    
    // handling annotation quick settings
    @State private var showQuickSettings = false
    
    // hovering effect to display pointer, improve user experience.
    //    @State private var isHovering = false
    //    @State private var hoverLocation: CGPoint = .zero
    
    // this section of the code is highly experimental and will handle multiple image swipe from folder
    // A main counter needs to be added which will be used to update the current image the user is working on. This image needs to be stored in a global var shared and saved as a bookmark.
    @State private var annotation_progress_tracker = 0
    @State private var current_file_name = ""
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
            .updating($isLongPressing) { currentState, gestureState,
                transaction in
                gestureState = currentState
            }
            .onEnded { finished in
                self.completedLongPress = finished
                print("LONG PRESS STATUS:",self.completedLongPress)
                let coordinateManager =  checkCoordinates(coordinates: startLoc, coordinateList: &rectData, viewStateVal: viewState, withinBBOX: &withingBBox) // , STAT_update: statusUpdate
                boxIDVAL = coordinateManager.1
                resizeLock = true
            }
        
        // .sequenced(before: DragGesture()) // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-gesture-chains-using-sequencedbefore
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation // offset is the distance of drag by the user
                if resizeLock == false && self.completedLongPress == false{
                    resizeBoundingBox(coordinates: startLoc, coordinateList: &rectData, offset_value: offset, C1_: &C1, C2_: &C2, C3_: &C3, C4_: &C4, test_boxIDVAL_: &test_boxIDVAL)
                    
                    boxIDVAL = test_boxIDVAL
                    print(boxIDVAL,"initially")
                    if C1 == true { // && boxIDVAL != 0 : this condition is preventing the bbox from being resized below the original size
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        // add previous C1 coordinate to a list to substract from later
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - (prev_f_width), rectData[boxIDVAL-1][1] - (prev_f_height), rectData[boxIDVAL-1][2] + (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height)] // reduce x and y value while increasing the width and height with the same value
                    }
                    if C2 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1] - prev_f_height, rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height)]
                    }
                    if C3 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - prev_f_width , rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] + (prev_f_width), rectData[boxIDVAL-1][3] - prev_f_height ]
                    }
                    if C4 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] - (prev_f_height)]
                    }
                    
                }
                if self.completedLongPress == true{
                    dragLock = false
                }
                if self.completedLongPress == true && boxIDVAL != 0 && dragLock == false{ // checking if boxIDVAL value is 0 is a clever way to handle long press guestures outside the bounding boxes
                    resizeLock = true
                    previous_offsetX = startLoc.x - (rectData[boxIDVAL-1][2]/2)
                    previous_offsetY = startLoc.y - (rectData[boxIDVAL-1][3]/2)
                    rectData[boxIDVAL-1] = [previous_offsetX + offset.width , previous_offsetY + offset.height, rectData[boxIDVAL-1][2], rectData[boxIDVAL-1][3]]
                }
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
                    if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                    }
                }
                self.completedLongPress = false
                dragLock = false
                resizeLock = false
                C1 = false
                C2 = false
                C3 = false
                C4 = false
                // experimental
//                annotation_coordinates = Storage.archiveStringArray(object: rectData)
                // experimental
                cordData = []
                
            }) // onEnded
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let simultaneously = longPressGesture.simultaneously(with: mainGesture)
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        return
        ZStack{
            Color(red: 0.26, green: 0.26, blue: 0.26)
                .ignoresSafeArea()
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color(red: 0.26, green: 0.26, blue: 0.26, opacity: 0.8))
                        .frame(width: 1000, height: 100)
                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                    VStack{
                        HStack{
                            Label("\(classList.classNameList.count)", systemImage: "list.number")
                                .font(.title)
                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                .padding()
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            //                                .frame(width: 30, height: 30, alignment: .center)
                            
                            // https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-text-and-an-icon-side-by-side-using-label
                            Label("\(rectData.count)", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                                .font(.title)
                                .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                .padding()
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            
                            Button(action: {}){
                                Text(classList.imageFileList.count > 0 ? "\(classList.imageFileList[0].lastPathComponent)" : "Image name")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.orange)
                                    .cornerRadius(50)
                            }
                            VStack{
                                // https://www.appcoda.com/swiftui-gauge/
                                // https://useyourloaf.com/blog/swiftui-gauges/ for more customization
                                Gauge(value: current, in: minValue...Double(annotation_progress_tracker)) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                } currentValueLabel: {
                                    Text("\(Int(annotation_progress_tracker))")
                                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                } minimumValueLabel: {
                                    Text("")
                                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                } maximumValueLabel: {
                                    Text("\(Int(classList.imageFileList.count - 1))")
                                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                }
                                .gaugeStyle(.accessoryCircular)
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            } // end of vStack which is not used really
                            
                            // add a quick clear button
                            
                            //                            Button(action: {
                            //                                isShowingDialog = true
                            //                            }){
                            //                                Text("Clear")
                            //                                    .foregroundColor(.white)
                            //                                    .padding()
                            //                                    .background(Color.red)
                            //                                    .cornerRadius(50)
                            //                            }
                            Button("Empty Trash") {
                                isShowingDialog = true
                            }
                            .confirmationDialog(
                                "Cear Annotations?",
                                isPresented: $isShowingDialog
                            ) {
                                Button("Clear", role: .destructive) {
                                    rectData = []
                                    // Handle empty trash action.
                                    //                clear_annotations = true
                                }
                                Button("Cancel", role: .cancel) {
                                    isShowingDialog = false
                                }
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(50)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            
                            
                            Button(action: {
                                
                                //                                ConfirmEraseItems(title: "Clear Annotations?")
                                rectData=[]
                            }){
                                Text("Clear")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(50)
                            }
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            
                            VStack{ // Vstack for undo and redo-button
                                Button(action:{
                                    if annotation_progress_tracker != 0 {
                                        annotation_progress_tracker -= 1
                                        print("annotion tracker progress no \(annotation_progress_tracker)")
//                                        image = presentImage(url: classList.imageFileList[annotation_progress_tracker])
                                    }
                                }){
                                    Image(systemName:"arrow.uturn.backward.circle")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .padding(.all,3)
                                        .cornerRadius(50)
                                        .frame(width:25, height: 25, alignment: .center)
                                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                }
                                Button(action:{
                                    annotation_progress_tracker += 1
                                    print("annotion tracker progress no \(annotation_progress_tracker)")
//                                    image = presentImage(url: classList.imageFileList[annotation_progress_tracker])
                                }){
                                    Image(systemName:"arrow.uturn.forward.circle")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .padding(.all,3)
                                        .cornerRadius(50)
                                        .frame(width:25, height: 25, alignment: .center)
                                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                }
                            }
                            
                            Button(action:{
                                showQuickSettings.toggle()
                            }){
                                //                                Image(systemName: "chevron.down")
                                Image(systemName: "gear")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .padding(.all,5)
                                    .frame(width:25, height: 25, alignment: .center)
                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                
                            }
                            .sheet(isPresented: $showQuickSettings) {
                                AnnotationQuickSettingsPopUp()
                                // display quick settings here
                            }
                            .padding(.all, 3)
                            .background(Color(red: 0.21, green: 0.21, blue: 0.21))
                            .cornerRadius(35)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            .help(Text("Clear all the annotations"))
                        } // end of Hstack
                        
                        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
                        ScrollView(.horizontal) {
                            HStack(spacing: 1) {
                                if (classList.classNameList.count > 0){
                                    ForEach(classList.classNameList , id: \.self) { cls in
                                        Text(cls)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .frame(width: 70, height: 20, alignment: .center)
                                            .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                            .cornerRadius(2)
                                    }
                                }
                            }
                        }
                        .environmentObject(classList)
                        .frame(minWidth: 400, maxWidth: 700, minHeight: 10, maxHeight: 25)
                        .padding()
                    } // end of Vstack used to put scrolling class selection button
                } // end of Zstack used to create text on mirror effect
                
                Text("\(classList.imageFileList[annotation_progress_tracker].lastPathComponent)")
                Text(current_file_name)
                
                //                HStack{
                //                    Button(action:{
                //                        if annotation_progress_tracker != 0{
                //                            self.annotation_progress_tracker -= 1
                //                        }
                //                    }){
                //                        Image(systemName:"arrow.uturn.backward.circle")
                //                            .resizable()
                //                            .foregroundColor(.white)
                //                            .padding(.all,3)
                //                            .cornerRadius(50)
                //                            .frame(width:25, height: 25, alignment: .center)
                //                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                //                        }
                
                //                    let image = presentImage(url: classList.imageFileList[annotation_progress_tracker])
                //                    if image != nil {
                Image(uiImage: presentImage(url: classList.imageFileList[annotation_progress_tracker]))
                    .resizable()
                //                        .onContinuousHover { phase in // https://nilcoalescing.com/blog/TrackingHoverLocationInSwiftUI/
                //                                        switch phase {
                //                                        case .active(let location):
                //                                            hoverLocation = location
                //                                            print("\(hoverLocation.x)")
                //                                            isHovering = true
                //                                        case .ended:
                //                                            isHovering = false
                //                                        }
                //                                    }
                    .overlay(ZStack{
                        if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .path(in: CGRect(
                                    x: (startLoc.x), // +  dragState.translation.width,
                                    y: (startLoc.y), // + dragState.translation.height,
                                    width: contWidth,
                                    height: contHeight
                                )
                                )
                                .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                        }
                        ForEach(self.rectData, id:\.self) {cords in
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .path(in: CGRect(
                                    x: cords[0]-2,
                                    y: cords[1]-2,
                                    width: cords[2]+3,
                                    height: cords[3]+3
                                )
                                )
                                .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.6))
                        } // end of for each loop
                        //                            if isHovering{
                        //                                Circle()
                        //                                    .fill(.white)
                        //                                    .opacity(1.5)
                        //                                    .frame(width: 30, height: 30)
                        //                                    .position(x: hoverLocation.x, y: hoverLocation.y)
                        //                                    }
                    } // end of zstack
                    ) // end of image overlay and zstack inside it
                    .gesture(simultaneously)
                    .padding(.all, 10)
                //                        .onHover{hover in
                //                            isHovering=hover
                //                                }
                //                    }
                //                    else{
                //                        Image("portland")
                //                            .resizable()
                //                            .padding(.all, 10)
                //                    }
                
                //                    Button(action:{
                //                        self.annotation_progress_tracker += 1
                //                    }){
                //                        Image(systemName:"arrow.uturn.forward.circle")
                //                            .resizable()
                //                            .foregroundColor(.white)
                //                            .padding(.all,3)
                //                            .cornerRadius(50)
                //                            .frame(width:25, height: 25, alignment: .center)
                //                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                //                        }
                //                } // end of hstack that holds the image and image changing buttons
            } // end of vstack withing return
            .onChange(of: annotation_progress_tracker) { newValue in
                current_file_name = "The number is \(newValue)"
//                Image(uiImage: presentImage(url: classList.imageFileList[annotation_progress_tracker]))
//                    .resizable()
//                    .overlay(ZStack{
//                        if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
//                            RoundedRectangle(cornerRadius: 5, style: .circular)
//                                .path(in: CGRect(
//                                    x: (startLoc.x), // +  dragState.translation.width,
//                                    y: (startLoc.y), // + dragState.translation.height,
//                                    width: contWidth,
//                                    height: contHeight
//                                )
//                                )
//                                .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
//                        }
//                        ForEach(self.rectData, id:\.self) {cords in
//                            RoundedRectangle(cornerRadius: 5, style: .circular)
//                                .path(in: CGRect(
//                                    x: cords[0]-2,
//                                    y: cords[1]-2,
//                                    width: cords[2]+3,
//                                    height: cords[3]+3
//                                )
//                                )
//                                .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.6))
//                        } // end of for each loop
//                    } // end of zstack
//                    ) // end of image overlay and zstack inside it
//                    .gesture(simultaneously)
//                    .padding(.all, 10)
//                image = presentImage(url: classList.imageFileList[annotation_progress_tracker])
            }
        } // end of zstack withing return
    } // end of main body
}

//class Storage: NSObject {
//
//    static func archiveStringArray(object : [[CGFloat]]) -> Data {
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
//            return data
//        } catch {
//            fatalError("Can't encode data: \(error)")
//        }
//    }
//
//    static func loadStringArray(data: Data) -> [[CGFloat]] {
//        do {
//            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [[CGFloat]] else {
//                return []
//            }
//            return array
//        } catch {
//            fatalError("loadWStringArray - Can't encode data: \(error)")
//        }
//    }
//}

func presentImage(url: URL) -> UIImage{
    var image_ = UIImage()
//    var imageCopy = UIImage()
    let data_: Data
    
    do{
        guard url.startAccessingSecurityScopedResource() else {
            print("trying to access image")
            print(url)
            data_ = try Data(contentsOf: url)
            print("loading image from data")
            image_ = UIImage(data: data_)!
            return image_
        }
        // Make sure you release the security-scoped resource when you finish.
        defer { url.stopAccessingSecurityScopedResource() }
//        data = try Data(contentsOf: url)
//        image_ = UIImage(data: data)!
//        imageCopy = UIImage(data: image.jpegData(compressionQuality: 1.0)!)!
    }catch{
        print("Error loading image: \(error.localizedDescription)")
        return image_
    }
    return image_
}



//func addSamples(for touches: [UITouch]) {
//   if let stroke = strokeCollection?.activeStroke {
//      for touch in touches {
//         if touch == touches.last {
//            let sample = StrokeSample(point: touch.location(in: self),
//                                 forceValue: touch.force)
//            stroke.add(sample: sample)
//            registerForEstimates(touch: touch, sample: sample)
//         } else {
//            let sample = StrokeSample(point: touch.location(in: self),
//                                 forceValue: touch.force, coalesced: true)
//            stroke.add(sample: sample)
//            registerForEstimates(touch: touch, sample: sample)
//         }
//      }
//      self.setNeedsDisplay()
//   }
//}


//func checkCoordinates(coordinates: CGPoint, coordinateList: inout [[CGFloat]], viewStateVal: CGSize, withinBBOX: inout Bool) -> (Bool, Int){
//
//    bboxID = 0
//    var temp_boxID = 0
//    withinBBOX = false
//
//    for bCord in coordinateList{
//        bboxID = bboxID + 1
//
//        // This section checks if the tap on the screen is withing an already drawn bouding box
//        if coordinates.x >= bCord[0]  && coordinates.x <= (bCord[0]+bCord[2])  && coordinates.y >= bCord[1] && coordinates.y <= (bCord[1]+bCord[3]) {
//            // if withing coordinates then return the bbox ID and set a boolean var to true.
//            withinBBOX = true
//            temp_boxID = bboxID
//            return (withinBBOX, bboxID)
//        }
//        else{
//            continue
//        }
//    }
//    return (withinBBOX, temp_boxID)
//}
//
//func resizeBoundingBox(coordinates: CGPoint, coordinateList: inout [[CGFloat]], offset_value: CGSize, C1_: inout Bool, C2_: inout Bool, C3_: inout Bool, C4_: inout Bool, test_boxIDVAL_: inout Int){
//    bboxID = 0
//    for bCord in coordinateList{
//        bboxID = bboxID + 1
//        if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
//            C1_ = true
//            C2_ = false
//            C3_ = false
//            C4_ = false
//            test_boxIDVAL_ = bboxID
//            print("within C1 edge...")
//        }
//
//        // Check if the tap is at the top right corner
//        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
//
//            C1_ = false
//            C2_ = true
//            C3_ = false
//            C4_ = false
//            test_boxIDVAL_ = bboxID
//
//            print("within C2 edge...")
//        }
//
//        // Check if the tap is at the bottom left corner
//        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
//            C1_ = false
//            C2_ = false
//            C3_ = true
//            C4_ = false
//            test_boxIDVAL_ = bboxID
//            print("within C3 edge...")
//        }
//
//        // Check if the tap is at the bottom right corner
//        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
//            C1_ = false
//            C2_ = false
//            C3_ = false
//            C4_ = true
//            test_boxIDVAL_ = bboxID
//            print("within C4 edge...")
//        }
//    }
//}
//
//func presentImage(url: URL, inputImage: UIImage) -> UIImage{
//
//    var image = UIImage()
//    let data: Data
//
//        do{
//            guard url.startAccessingSecurityScopedResource() else {
//                print("trying to access image")
//                // Handle the failure here.
////                ImageDisplayPreview(currentImageSelection: inputImage) // replace bind with other var type
//                data = try Data(contentsOf: url)
//                print("loading image from data")
//                image = UIImage(data: data)!
//                return image
//            }
//
//            // Make sure you release the security-scoped resource when you finish.
//            defer { url.stopAccessingSecurityScopedResource() }
//            data = try Data(contentsOf: url)
//            image = UIImage(data: data)!
//        }catch{
//            print("Error loading image: \(error.localizedDescription)")
//            return UIImage()
//        }
//    return image
//}

//struct ConfirmEraseItems: View {
//    @State private var isShowingDialog = false
//
//    var title: String
//    var body: some View {
//        Button("Empty Trash") {
//            isShowingDialog = true
//        }
//        .confirmationDialog(
//            title,
//            isPresented: $isShowingDialog
//        ) {
//            Button("Clear", role: .destructive) {
//                // Handle empty trash action.
////                clear_annotations = true
//            }
//            Button("Cancel", role: .cancel) {
//                isShowingDialog = false
//            }
//        }
//    }
//}

struct AnnotationView2_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView2()
        //        AnnotationView( classNamesAnnot: $classNamesAnnot)
    }
}
