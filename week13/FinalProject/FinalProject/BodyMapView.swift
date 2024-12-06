//
//  BodyMapView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.
//

import Foundation
import SwiftUI

//struct BodyMapView: View {
//    @State private var currentColor: Color = .red
//    @State private var points: [DrawingPoint] = [] // Stores drawn points
//    @State private var selectedTool: String = "Red" // "Red" or "Blue"
//    
//    var body: some View {
//        VStack {
//            // Title and Instructions
//            Text("Where Do You Feel Restless?")
//                .font(.title2)
//                .bold()
//                .padding(.top)
//            
//            Text("Tap to select a color, then draw on the body map to indicate restlessness (red) or relaxation (blue).")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
//
//            Spacer()
//            
//            // Image and Drawing Area
//            ZStack {
//                Image("man")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 400)
//                    .overlay(
//                        // Canvas for drawing
//                        Canvas { context, size in
//                            for point in points {
//                                let rectangle = CGRect(x: point.location.x - 5,
//                                                       y: point.location.y - 5,
//                                                       width: 10,
//                                                       height: 10)
//                                context.fill(Path(ellipseIn: rectangle), with: .color(point.color))
//                            }
//                        }
//                    )
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged { value in
//                                let newPoint = DrawingPoint(
//                                    location: CGPoint(x: value.location.x, y: value.location.y),
//                                    color: selectedTool == "Red" ? .red : .blue
//                                )
//                                points.append(newPoint)
//                            }
//                    )
//            }
//            .padding()
//
//            // Tool Selection
//            HStack {
//                Button(action: {
//                    selectedTool = "Red"
//                }) {
//                    Text("Red")
//                        .padding()
//                        .background(selectedTool == "Red" ? Color.red.opacity(0.2) : Color.clear)
//                        .cornerRadius(10)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red))
//                }
//
//                Button(action: {
//                    selectedTool = "Blue"
//                }) {
//                    Text("Blue")
//                        .padding()
//                        .background(selectedTool == "Blue" ? Color.blue.opacity(0.2) : Color.clear)
//                        .cornerRadius(10)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
//                }
//            }
//            .padding()
//
//            Spacer()
//
//            // Save Button
//            Button(action: saveDrawing) {
//                Text("Save")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.green)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
//    }
//    
//    // Save Functionality (placeholder for actual saving logic)
//    func saveDrawing() {
//        print("Drawing saved with \(points.count) points.")
//        // You can save the `points` array to Firebase or a local database if needed.
//    }
//}
//
//// Model to Store Drawing Points
//struct DrawingPoint: Identifiable {
//    let id = UUID()
//    var location: CGPoint
//    var color: Color
//}
//
//struct BodyMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        BodyMapView()
//    }
//}



//struct RestlessBodyMapView: View {
//    @State private var points: [DrawingPoint] = [] // Stores drawn points
//    @State private var selectedTool: String = "Red" // "Red" or "Blue"
//    @State private var currentStep: Int = 1 // Workflow step
//
//    var body: some View {
//        ZStack {
//            // Programmatic Celestial Background
//            CelestialBackground()
//                .ignoresSafeArea()
//
//            VStack {
//                // Title
//                Text("Where Do You Feel Restless?")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.orange)
//                    .multilineTextAlignment(.center)
//                    .padding(.top, 20)
//
//                // Description
//                Text("""
//                In the drawing below, color where you feel restless in red. Now color where you feel relaxed in blue. Stretch the restless red part of your body. Color over the red with blue. Your restless areas may not look perfectly blue, but they hopefully feel more relaxed and look a little less red.
//                """)
//                    .font(.body)
//                    .foregroundColor(Color.white)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//                    .padding(.top, 10)
//
//                Spacer()
//
//                // Image and Drawing Area
//                ZStack {
//                    Image("man") // Replace with your "man.png"
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 400)
//                        .overlay(
//                            Canvas { context, size in
//                                for point in points {
//                                    let rectangle = CGRect(x: point.location.x - 5,
//                                                           y: point.location.y - 5,
//                                                           width: 10,
//                                                           height: 10)
//                                    context.fill(Path(ellipseIn: rectangle), with: .color(point.color))
//                                }
//                            }
//                        )
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onChanged { value in
//                                    let newPoint = DrawingPoint(
//                                        location: CGPoint(x: value.location.x, y: value.location.y),
//                                        color: selectedTool == "Red" && currentStep == 1 ? .red : (selectedTool == "Blue" && currentStep == 2 ? .blue : .clear)
//                                    )
//                                    if newPoint.color != .clear {
//                                        points.append(newPoint)
//                                    }
//                                }
//                        )
//                }
//                .padding()
//
//                // Tool Selection
//                HStack {
//                    Button(action: {
//                        selectedTool = "Red"
//                    }) {
//                        Text("Red")
//                            .padding()
//                            .background(selectedTool == "Red" ? Color.red.opacity(0.2) : Color.clear)
//                            .cornerRadius(10)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red))
//                    }
//                    .disabled(currentStep != 1) // Disable Red button in Step 2
//
//                    Button(action: {
//                        selectedTool = "Blue"
//                    }) {
//                        Text("Blue")
//                            .padding()
//                            .background(selectedTool == "Blue" ? Color.blue.opacity(0.2) : Color.clear)
//                            .cornerRadius(10)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
//                    }
//                    .disabled(currentStep != 2) // Disable Blue button in Step 1
//                }
//                .padding()
//
//                Spacer()
//
//                // Next Button
//                Button(action: {
//                    if currentStep == 1 {
//                        currentStep = 2 // Move to Step 2
//                    } else {
//                        print("Proceeding to the next activity...") // Placeholder for navigation logic
//                    }
//                }) {
//                    Text("Next")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//            }
//            .padding()
//        }
//    }
//}
//
//// Model to Store Drawing Points
//struct DrawingPoint: Identifiable {
//    let id = UUID()
//    var location: CGPoint
//    var color: Color
//}
//
//// Celestial Background View
//struct CelestialBackground: View {
//    var body: some View {
//        ZStack {
//            // Base gradient
//            LinearGradient(
//                gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            
//            // Stars
//            ForEach(0..<100, id: \.self) { _ in
//                Circle()
//                    .fill(Color.white.opacity(0.8))
//                    .frame(width: CGFloat.random(in: 2...4), height: CGFloat.random(in: 2...4))
//                    .position(
//                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
//                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
//                    )
//            }
//        }
//    }
//}
//
//// Preview
//struct RestlessBodyMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestlessBodyMapView()
//    }
//}

import SwiftUI

struct RestlessBodyMapView: View {
    @State private var points: [DrawingPoint] = [] // Stores drawn points
    @State private var selectedTool: String = "Red" // "Red" or "Blue"

    var body: some View {
        ZStack {
            // Programmatic Celestial Background
            CelestialBackground()
                .ignoresSafeArea()

            VStack {
                // Title
                Text("Where Do You Feel Restless?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 40)

                // Description
                Text("""
                Color where you feel restless in red. Now color where you feel relaxed in blue. Stretch the restless red part of your body. Color over the red with blue. Your restless areas may not look perfectly blue, but they hopefully feel more relaxed and look a little less red.
                """)
                    .font(.body)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 10)

                Spacer()

                // Image and Drawing Area
                ZStack {
                    Image("man") // Replace with your "man.png"
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .overlay(
                            Canvas { context, size in
                                for point in points {
                                    let rectangle = CGRect(x: point.location.x - 5,
                                                           y: point.location.y - 5,
                                                           width: 10,
                                                           height: 10)
                                    context.fill(Path(ellipseIn: rectangle), with: .color(point.color))
                                }
                            }
                        )
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let newPoint = DrawingPoint(
                                        location: CGPoint(x: value.location.x, y: value.location.y),
                                        color: selectedTool == "Red" ? .red : .blue
                                    )
                                    points.append(newPoint)
                                }
                        )
                }
                .padding()

                // Tool Selection
                HStack {
                    Button(action: {
                        selectedTool = "Red"
                    }) {
                        Text("Red")
                            .fontWeight(.bold)
                            .foregroundColor(selectedTool == "Red" ? .white : .red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedTool == "Red" ? Color.red : Color.clear)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red))
                    }

                    Button(action: {
                        selectedTool = "Blue"
                    }) {
                        Text("Blue")
                            .fontWeight(.bold)
                            .foregroundColor(selectedTool == "Blue" ? .white : .blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedTool == "Blue" ? Color.blue : Color.clear)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}

// Model to Store Drawing Points
struct DrawingPoint: Identifiable {
    let id = UUID()
    var location: CGPoint
    var color: Color
}

// Celestial Background View
struct CelestialBackground: View {
    var body: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Stars
            ForEach(0..<100, id: \.self) { _ in
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: CGFloat.random(in: 2...4), height: CGFloat.random(in: 2...4))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
            }
        }
    }
}

// Preview
struct RestlessBodyMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestlessBodyMapView()
    }
}
