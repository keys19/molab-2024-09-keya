//
//  MandalaView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//

import Foundation
import SwiftUI
struct MandalaView: View {
    let mood: String
    @State private var colors: [Color] = []
    @State private var paths: [Path] = []
    @State private var currentPath = Path()
    @State private var selectedColor: Color = .gray
    
    let palettes = [
        "Calm": [Color.blue, Color.green, Color.teal],
        "Happy": [Color.yellow, Color.orange, Color.pink],
        "Stressed": [Color.purple, Color.mint, Color.white],
        "Energetic": [Color.red, Color.orange, Color.yellow]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background
            
            VStack {
                // Title
                Text("Mandala for \(mood)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
                
                // Mandala (Static for Now, Can Be Dynamic)
                ZStack {
                    ForEach(0..<12, id: \.self) { index in
                        Path { path in
                            path.move(to: CGPoint(x: 200, y: 200))
                            path.addArc(center: CGPoint(x: 200, y: 200),
                                        radius: 100,
                                        startAngle: Angle(degrees: Double(index) * 30),
                                        endAngle: Angle(degrees: Double(index + 1) * 30),
                                        clockwise: false)
                            path.closeSubpath()
                        }
                        .fill(colors.indices.contains(index) ? colors[index] : Color.gray)
                        .onTapGesture {
                            if colors.indices.contains(index) {
                                colors[index] = selectedColor
                            } else {
                                colors.append(selectedColor)
                            }
                        }
                    }
                }
                .frame(width: 400, height: 400)
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
                
                // Color Palette
                HStack {
                    ForEach(palettes[mood] ?? [], id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                selectedColor = color
                            }
                            .padding(4)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                // Save Button
                Button(action: {
                    print("Mandala saved!")
                }) {
                    Text("Save Mandala")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 40)
            }
        }
    }
}
