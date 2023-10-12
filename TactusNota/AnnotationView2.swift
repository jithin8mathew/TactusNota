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
    
    @State var temp_contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var temp_contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
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
//    @State private var annotationClassList: [String] = ["apple","car","bus","cat"]
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
    @State private var showAnnotationsinYOLO = false
    
    // hovering effect to display pointer, improve user experience.
    //    @State private var isHovering = false
    //    @State private var hoverLocation: CGPoint = .zero
    
    // Appstorage
    // UserDefaults
    // A main counter needs to be added which will be used to update the current image the user is working on. This image needs to be stored in a global var shared and saved as a bookmark.
    @State private var annotation_progress_tracker = 0
    //    @State private var fileNameWithoutExtension: String = ""
    @State private var annotationFileContent = ""
    @State private var annotationFilePrecenceStatus = false
    //    @AppStorage("current_working_image") var annotation_progress_tracker = 0
    
    // this section will handle data related to the class information for each annotation
    @State private var class_selection_index = 0 // this will be updated with the use picks a class or once a single class has been added to the classList
    //    @AppStorage("current_working_class") var class_selection_index = 0
    
    @State private var class_color_array_ = [Color]()
    //    @State private var class_name_list_duplicate_array = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                //                HoverPointer()
                //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        contWidth = value.location.x - startLoc.x
                        contHeight = value.location.y - startLoc.y 
//                        temp_contWidth = value.location.x - startLoc.x
//                        temp_contHeight = value.location.y - startLoc.y
                        // experimentally added
//                        if temp_contWidth > 0 && temp_contHeight > 0{
//                            contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
//                            contHeight = value.location.y - startLoc.y // Height of the bounding box
//                        }
//                        if temp_contWidth > 0 && temp_contHeight < 0{
//                            contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
//                            contHeight = value.location.y + startLoc.y // Height of the bounding box
//                        }
//                        if temp_contWidth < 0 && temp_contHeight > 0{
//                            contWidth = value.location.x + startLoc.x // the the width of the object (bounding box)
//                            contHeight = value.location.y - startLoc.y // Height of the bounding box
//                        }
//                        if temp_contWidth < 0 && temp_contHeight < 0{
//                            contWidth = value.location.x + startLoc.x // the the width of the object (bounding box)
//                            contHeight = value.location.y + startLoc.y // Height of the bounding box
//                        }
                        // end of experimental addition
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
                                rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - (prev_f_width), rectData[boxIDVAL-1][1] - (prev_f_height), rectData[boxIDVAL-1][2] + (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height), CGFloat(class_selection_index)] // reduce x and y value while increasing the width and height with the same value
                            }
                            if C2 == true && boxIDVAL != 0{
                                dragLock = true
                                cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                                
                                if cordData.count > 2{
                                    prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                                    prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                                }
                                rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1] - prev_f_height, rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height), CGFloat(class_selection_index)]
                            }
                            if C3 == true && boxIDVAL != 0{
                                dragLock = true
                                cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                                
                                if cordData.count > 2{
                                    prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                                    prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                                }
                                rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - prev_f_width , rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] + (prev_f_width), rectData[boxIDVAL-1][3] - prev_f_height , CGFloat(class_selection_index)]
                            }
                            if C4 == true && boxIDVAL != 0{
                                dragLock = true
                                cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                                
                                if cordData.count > 2{
                                    prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                                    prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                                }
                                rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] - (prev_f_height), CGFloat(class_selection_index)]
                            }
                            
                        }
                        if self.completedLongPress == true{
                            dragLock = false
                        }
                        if self.completedLongPress == true && boxIDVAL != 0 && dragLock == false{ // checking if boxIDVAL value is 0 is a clever way to handle long press guestures outside the bounding boxes
                            resizeLock = true
                            previous_offsetX = startLoc.x - (rectData[boxIDVAL-1][2]/2)
                            previous_offsetY = startLoc.y - (rectData[boxIDVAL-1][3]/2)
                            rectData[boxIDVAL-1] = [previous_offsetX + offset.width , previous_offsetY + offset.height, rectData[boxIDVAL-1][2], rectData[boxIDVAL-1][3], rectData[boxIDVAL-1][4]]
                        }
                    }
                    .onEnded({
                        (value) in
                        if (value.location.x - startLoc.x > 20){
                            if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                                rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight, CGFloat(class_selection_index)]])
                                // Here we add the annotation to a text file at the end of each on end
                                let fileNameWithoutExtension = (classList.imageFileList[annotation_progress_tracker].lastPathComponent as NSString).deletingPathExtension
                                let coordinateStrings = rectData.map { coordinate in
                                    "\(coordinate[4]) \(coordinate[0]) \(coordinate[1]) \(coordinate[2]) \(coordinate[3])"
                                }
                                let combinedString = coordinateStrings.joined(separator: "\n")
                                print(combinedString)
                                fileAnnotationSaver(annotations: combinedString, filename: fileNameWithoutExtension)
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
                //        return
                ZStack{
                    Color(red: 0.26, green: 0.26, blue: 0.26)
                        .ignoresSafeArea()
                    HStack{

                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(Color(red: 0.26, green: 0.26, blue: 0.26, opacity: 0.8))
                                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.1)
                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                VStack{
                                    HStack{
                                        Label("\(classList.classNameList.count)", systemImage: "list.number")
                                            .font(.body)
                                        //                                .frame(width: 40, height: 20)
                                            .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                            .padding()
                                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                        //                                .frame(width: 30, height: 30, alignment: .center)
                                        
                                        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-text-and-an-icon-side-by-side-using-label
                                        Label("\(rectData.count)", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                                            .font(.body)
                                        //                                .frame(width: 40, height: 20)
                                            .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                            .padding()
                                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                        
                                        
                                        Label("\(classList.imageFileList[annotation_progress_tracker].lastPathComponent)", systemImage: "photo.fill")
                                            .padding(.all, 10)
                                            .background(Color.orange)
                                            .cornerRadius(35)
                                            .frame(minWidth: 100, maxWidth: 200, minHeight: 10, maxHeight: 25, alignment: .center)
                                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                                        VStack{
//                                            // https://www.appcoda.com/swiftui-gauge/
//                                            // https://useyourloaf.com/blog/swiftui-gauges/ for more customization
//                                            Gauge(value: current, in: minValue...Double(annotation_progress_tracker)) {
//                                                Image(systemName: "heart.fill")
//                                                    .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                                            } currentValueLabel: {
//                                                Text("\(Int(annotation_progress_tracker))")
//                                                    .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                                            } minimumValueLabel: {
//                                                Text("")
//                                                    .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                                            } maximumValueLabel: {
//                                                Text("\(Int(classList.imageFileList.count - 1))")
//                                                    .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
//                                            }
//                                            .gaugeStyle(.accessoryCircular)
//                                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
//                                        } // end of vStack which is not used really
                                        
                                        Button(action: {
                                            
                                            //                                ConfirmEraseItems(title: "Clear Annotations?")
                                            rectData=[]
                                        }){
                                            Text("Clear")
                                                .foregroundColor(.white)
                                                .padding(.all, 10)
                                                .background(Color.red)
                                                .cornerRadius(35)
                                        }
                                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                        
                                        VStack{ // Vstack for undo and redo-button
                                            Button(action:{
                                                if annotation_progress_tracker != 0 {
                                                    annotation_progress_tracker -= 1
                                                    print("annotion tracker progress no \(annotation_progress_tracker)")
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
                                                let fileNameWithoutExtension = (classList.imageFileList[annotation_progress_tracker].lastPathComponent as NSString).deletingPathExtension
                                                
//                                                if checkForTextFile(filename: fileNameWithoutExtension) {
//                                                    cordData = []
//                                                    if let cordString = readAndDisplayFileContent(named: classList.currentWorkingImageName){
//                                                        let lines = cordString.split(separator: "\n")
//                                                        for line in lines {
//                                                            let values = line.split(separator: " ").compactMap { value -> CGFloat? in
//                                                                if let doubleValue = Double(value.trimmingCharacters(in: .whitespaces)) {
//                                                                    return CGFloat(doubleValue)
//                                                                }
//                                                                return nil
//                                                            }
//                                                            cordData.append(values)
//                                                        }
//                                                    }
//                                                }
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
                                        
                                        Button(action:{
                                            showAnnotationsinYOLO.toggle()
                                            let fileNameWithoutExtension = (classList.imageFileList[annotation_progress_tracker].lastPathComponent as NSString).deletingPathExtension
                                            if let content = readAndDisplayFileContent(named: fileNameWithoutExtension+".txt") {
                                                annotationFileContent = content
                                            } else {
                                                annotationFileContent = "No annotation present"
                                                print("File not found")
                                            }
                                        }){
                                            //                                Image(systemName: "chevron.down")
                                            Image(systemName: "doc.plaintext.fill")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .padding(.all,5)
                                                .frame(width:25, height: 25, alignment: .center)
                                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                        }
                                        .sheet(isPresented: $showAnnotationsinYOLO) {
                                            display_annotations(annotationFileContent: $annotationFileContent)
                                            // display quick settings here
                                        }
                                        .padding(.all, 3)
                                        .background(Color(red: 0.21, green: 0.21, blue: 0.21))
                                        .cornerRadius(35)
                                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                    } // end of Hstack
                                    
                                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 1) {
                                            if (classList.classNameList.count > 0){
                                                ForEach(Array(classList.classNameList.enumerated()) , id: \.1) { index, cls in
                                                    Text(cls)
                                                        .foregroundColor(.white)
                                                        .font(.footnote)
                                                        .frame(width: 70, height: 20, alignment: .center)
                                                        .background(classList.class_color_code[index])
                                                        .cornerRadius(2)
                                                        .onTapGesture {
                                                            class_selection_index = index
                                                        }
                                                } // end of foreach loop
                                            }
                                        }
                                    }
                                    .environmentObject(classList)
                                    .frame(minWidth: 350, maxWidth: 550, minHeight: 10, maxHeight: 25, alignment: .center)
                                    .padding()
                                } // end of Vstack used to put scrolling class selection button
                            } // end of Zstack used to create text on mirror effect
                            
                            HStack(alignment: .center){
                                
                                Image(uiImage: presentImage(url: classList.imageFileList[annotation_progress_tracker]))
                                    .resizable()
                                    .frame(width: geometry.frame(in: .global).width * 0.95, height: geometry.frame(in: .global).height * 0.80, alignment: .center)
                                    .overlay(ZStack{
                                        if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                                .path(in: CGRect(
                                                    x: (startLoc.x), // +  dragState.translation.width,
                                                    y: (startLoc.y), // + dragState.translation.height,
                                                    width: contWidth,
                                                    height: contHeight
                                                ))
                                                .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                                            //                                                    .stroke(classList.class_color_code[Int(cords[4])])
                                            //                                            }
                                        }
                                        ForEach(self.rectData, id:\.self) {cords in
                                            ZStack{
                                                //                                                Text(classList.classNameList[class_selection_index])
                                                Text(classList.classNameList[Int(cords[4])])
                                                    .position(x: cords[0]-2, y:cords[1]-2)
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                                //                                                    .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                                    .cornerRadius(5)
                                                    .offset(x:20, y:10)
                                                RoundedRectangle(cornerRadius: 5, style: .circular)
                                                    .path(in: CGRect(
                                                        x: cords[0]-2,
                                                        y: cords[1]-2,
                                                        width: cords[2]+3,
                                                        height: cords[3]+3
                                                    )
                                                    )
                                                //                                                    .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.6))
                                                    .fill(classList.class_color_code[Int(cords[4])])
//                                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                            }
                                        } // end of for each loop
                                    } // end of zstack
                                    ) // end of image overlay and zstack inside it
                                    .gesture(simultaneously)
                                    .padding(.horizontal, 10)
//                                    .onChange(of: image, perform:
//                                    )
//                                    .onAppear{
//                                        print("on appear validated...")
//                                        let fileNameWithoutExtension = (classList.imageFileList[annotation_progress_tracker].lastPathComponent as NSString).deletingPathExtension
//                                        //                                        classList.currentWorkingImageName = fileNameWithoutExtension
//                                        // if annotaiton file with image name exists, then add its data to cordData
//                                        if checkForTextFile(filename: fileNameWithoutExtension) {
//                                            print("check the file on appearance...")
//                                            cordData = []
//                                            if let cordString = readAndDisplayFileContent(named: fileNameWithoutExtension+".txt"){
//                                                let lines = cordString.split(separator: "\n")
//                                                for line in lines {
//                                                    let values = line.split(separator: " ").compactMap { value -> CGFloat? in
//                                                        if let doubleValue = Double(value.trimmingCharacters(in: .whitespaces)) {
//                                                            return CGFloat(doubleValue)
//                                                        }
//                                                        return nil
//                                                    }
//                                                    cordData.append(values)
//                                                }
//                                            }
//                                        }
//                                    }// END OF IMAGE ONAPPEAR
                            } // hstack befor loading image
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        } // end of vstack withing return
                    } // testing Hstack
                    .padding(.all, 0)
                } // end of zstack withing return
            } // end of main zstack
        } // end of geometry viewer
    } // end of main body
    
} // end of struct


func presentImage(url: URL) -> UIImage{
    var image_ = UIImage()
    let data_: Data
    
    do{
        guard url.startAccessingSecurityScopedResource() else {
//            print("trying to access image")
//            print(url)
            data_ = try Data(contentsOf: url)
//            print("loading image from data")
            image_ = UIImage(data: data_)!
            return image_
        }
        do { url.stopAccessingSecurityScopedResource() }
    }catch{
        print("Error loading image: \(error.localizedDescription)")
        return image_
    }
    return image_
}

// this function should write the annotations for each image into a textfile with curresponding filename
func fileAnnotationSaver(annotations: String, filename: String){
    //    let fileNameWithoutExtension = (classList.imageFileList[annotation_progress_tracker].lastPathComponent as NSString).deletingPathExtension
    
    let annotation_file_name = filename+".txt"
    guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileURL = directoryURL.appendingPathComponent(annotation_file_name)
    
    do {
        try annotations.write(to: fileURL, atomically: true, encoding: .utf8)
        print(annotation_file_name + " written successfully")
    } catch {
        print("Error writing file: \(error)")
    }
}

func readAndDisplayFileContent(named fileName: String) -> String? {
    guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "String" }
    let fileURL = directoryURL.appendingPathComponent(fileName)
    //        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { return nil }
    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        return content
    } catch {
        print("Error reading file: \(error)")
        return nil
    }
}

func checkForTextFile(filename: String) -> Bool{
    let fileManager = FileManager.default
    let annotation_file_name = filename+".txt"
    print("Text file present and loading..."+annotation_file_name)
    guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
    let fileURL = directoryURL.appendingPathComponent(annotation_file_name)
    if fileManager.fileExists(atPath: fileURL.path){
        return fileManager.fileExists(atPath: fileURL.path)
    }
    else {
        print("file not present...")
        return false
    }
    return fileManager.fileExists(atPath: fileURL.path)
}

struct AnnotationView2_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView2()
    }
}
