//
//  ContentView.swift
//  week3
//
//  Created by Keya Shah on 25/09/2024.
//

import SwiftUI

// Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink, .teal, .cyan, .mint, .indigo]
    
    let columns = 15
    let rows = 15
    let cellSize: CGFloat = 30

    @State private var margin: CGFloat = 4 //(state var to track changes)

    var body: some View {
        VStack {
            // slider to control the margin
            Slider(value: $margin, in: 0...10, step: 1) {
                Text("Margin")
            }
            .padding()

            VStack(spacing: 0) {
                // id: \.self??
                ForEach(0..<rows, id: \.self) { _ in
                    HStack(spacing: 0) {
                        ForEach(0..<columns, id: \.self) { _ in
                            randomShape()
                                .frame(width: cellSize, height: cellSize)
                                .aspectRatio(1, contentMode: .fit)
                                .padding(margin) // Apply the dynamic margin
                        }
                    }
                }
            }
        }
    }
    
    // @ViewBuilder function
    @ViewBuilder
    func randomShape() -> some View {
        let color = colors.randomElement() ?? .black
        let shapeType = Int.random(in: 0..<5)
        
        let gradient = LinearGradient(
            gradient: Gradient(colors: [colors.randomElement() ?? .black, colors.randomElement() ?? .white]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        
        switch shapeType {
        case 0:
            Circle().fill(gradient)
        case 1:
            Rectangle().fill(color)
        case 2:
            Triangle().fill(color)
        case 3:
            Capsule().fill(color)
        default:
            Ellipse().fill(gradient)
        }
    }
}

#Preview {
    ContentView()
}



//sources
//https://developer.apple.com/documentation/swiftui/viewbuilder
//https://developer.apple.com/tutorials/swiftui/creating-and-combining-views
//https://www.hackingwithswift.com/quick-start/swiftui/swiftuis-built-in-shapes
//https://www.createwithswift.com/using-gradients-in-swiftui/
