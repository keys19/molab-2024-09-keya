//
//  MandalaEditor.swift
//  FinalProject
//
//  Created by Keya Shah on 22/11/2024.
//

import Foundation
import SwiftUI
struct MandalaEditor: View {
    @State private var selectedColor: UIColor = .gray
    @State private var pathColors: [String: UIColor] = [:]
    let svgName: String
    let palettes: [UIColor]

    var body: some View {
        VStack(spacing: 20) {
            // SVG Display and Interaction
            InteractiveMandalaView(svgName: "svg1", selectedColor: $selectedColor, pathColors: $pathColors)
                .frame(height: 400)
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 5)

            // Color Palette for Selection
            HStack {
                ForEach(palettes, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            selectedColor = color
                        }
                        .padding(4)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? Color.white : Color.clear, lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)

            // Save Button
            Button(action: saveMandala) {
                Text("Save Mandala")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .shadow(radius: 5)
                    )
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }

    // Save Mandala Functionality
    private func saveMandala() {
        // Example: Print the path colors to the console
        print("Mandala saved with colors: \(pathColors)")
        
        // You can add file saving or other persistence logic here.
    }
}
