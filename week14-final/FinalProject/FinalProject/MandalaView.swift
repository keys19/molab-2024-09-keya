//
//  MandalaView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//


import Foundation
import SwiftUI
import AVFoundation

struct MandalaView: View {
    let mood: String
    @State private var colors: [Color] = Array(repeating: Color.gray, count: 48) // Expanded for multiple regions
    @State private var selectedColor: Color = .gray // Selected color from the palette
    @State private var navigateToThankYouView = false 
    @State private var audioPlayer: AVAudioPlayer?
    // Predefined color palettes based on mood
    let palettes = [
        "Calm": [Color.blue, Color.green, Color.teal],
        "Happy": [Color.yellow, Color.orange, Color.pink],
        "Stressed": [Color.purple, Color.mint, Color.white],
        "Energetic": [Color.red, Color.orange, Color.yellow]
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background
            
            VStack(spacing: 20) {
                // Title
                Text("Mandala for \(mood)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                Spacer()

                // Mandala Drawing Area
                MandalaDrawing(colors: $colors, selectedColor: $selectedColor)

                // Color Palette
                ColorPalette(palettes: palettes[mood] ?? [], selectedColor: $selectedColor)

                Spacer()

                // Save Button
                Button(action: {
                    stopAudio()
                    navigateToThankYouView = true
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

                // Navigation to Thank You Screen
                NavigationLink(
                    destination: ThankYouView(),
                    isActive: $navigateToThankYouView
                ) {
                    EmptyView()
                }
            }
        }
        .onAppear {
            playAudio()
        }
        .onDisappear {
            stopAudio()
        }
        .navigationBarBackButtonHidden(true)
    }


    /// Play the audio file with fade-in
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "sleep", ofType: "mp3") else {
            print("Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.volume = 0.0
            audioPlayer?.play()
            

            let fadeDuration = 2.0
            let fadeInterval = 0.1
            let fadeSteps = Int(fadeDuration / fadeInterval)
            var currentStep = 0

            Timer.scheduledTimer(withTimeInterval: fadeInterval, repeats: true) { timer in
                if currentStep >= fadeSteps {
                    timer.invalidate()
                    return
                }
                audioPlayer?.volume += Float(1.0 / Float(fadeSteps))
                currentStep += 1
            }
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }

    /// Stop the audio playback with fade-out
    func stopAudio() {
        guard let audioPlayer = audioPlayer else { return }


        let fadeDuration = 2.0
        let fadeInterval = 0.1
        let fadeSteps = Int(fadeDuration / fadeInterval)
        var currentStep = 0

        Timer.scheduledTimer(withTimeInterval: fadeInterval, repeats: true) { timer in
            if currentStep >= fadeSteps {
                audioPlayer.stop()
                self.audioPlayer = nil
                timer.invalidate()
                return
            }
            audioPlayer.volume -= Float(1.0 / Float(fadeSteps))
            currentStep += 1
        }
    }
}

// Subview for Mandala Drawing
struct MandalaDrawing: View {
    @Binding var colors: [Color]
    @Binding var selectedColor: Color

    var body: some View {
        ZStack {
            // Outer Decorative Circles
            ForEach(1..<4, id: \.self) { index in
                Circle()
                    .stroke(
                        Color.white.opacity(0.3),
                        lineWidth: CGFloat(index) * 3
                    )
                    .frame(width: CGFloat(300 + (index * 20)), height: CGFloat(300 + (index * 20)))
            }

            // Mandala Design with Multiple Fillable Regions
            ForEach(0..<48, id: \.self) { index in
                Path { path in
                    let center = CGPoint(x: 200, y: 200)
                    let radius = index % 2 == 0 ? 120 : 150 // Alternate inner and outer arcs
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: CGFloat(radius),
                        startAngle: Angle(degrees: Double(index) * 7.5),
                        endAngle: Angle(degrees: Double(index + 1) * 7.5),
                        clockwise: false
                    )
                    path.closeSubpath()
                }
                .fill(colors[index])
                .overlay(
                    Path { path in
                        let center = CGPoint(x: 200, y: 200)
                        let radius = index % 2 == 0 ? 120 : 150
                        path.move(to: center)
                        path.addArc(
                            center: center,
                            radius: CGFloat(radius),
                            startAngle: Angle(degrees: Double(index) * 7.5),
                            endAngle: Angle(degrees: Double(index + 1) * 7.5),
                            clockwise: false
                        )
                        path.closeSubpath()
                    }
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .onTapGesture {
                    colors[index] = selectedColor
                    colors[(index + 24) % 48] = selectedColor // Symmetry for larger region
                }
            }

            // Central Circle for Additional Decoration
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )
        }
        .frame(width: 400, height: 400)
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
        .padding()
    }
}

// Subview for Color Palette
struct ColorPalette: View {
    let palettes: [Color]
    @Binding var selectedColor: Color

    var body: some View {
        HStack {
            ForEach(palettes, id: \.self) { color in
                Circle()
                    .fill(color)
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
        .padding(.vertical)
    }
}

// New Thank You View
struct ThankYouView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background
            Image("thankyou") 
                .resizable()
                .scaledToFill()
//                .offset(x: -20)
                .padding()
            
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

// Preview
struct MandalaView_Previews: PreviewProvider {
    static var previews: some View {
        MandalaView(mood: "Calm")
    }
}
