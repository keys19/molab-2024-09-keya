//
//  BodyMapView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.
//



import Foundation
import SwiftUI
import AVFoundation

struct RestlessBodyMapView: View {
    @State private var points: [DrawingPoint] = [] // Stores drawn points
    @State private var selectedTool: String = "Red"
    @State private var navigateToTrackYourDay = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isStretchesModalOpen: Bool = false
    var body: some View {
        ZStack {
            // Background
            CelestialBackground()
                .ignoresSafeArea()

            VStack {
                // Title
                Text("Where Do You Feel Restless?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)

                Spacer()

                // Body Drawing Area
                ZStack {
                    Image("man")
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

                    // Tool Buttons on the Right
                    VStack(spacing: 20) {
                        ToolCircle(color: .red, isSelected: selectedTool == "Red") {
                            selectedTool = "Red"
                        }
                        ToolCircle(color: .blue, isSelected: selectedTool == "Blue") {
                            selectedTool = "Blue"
                        }
                        Button(action: {
                            isStretchesModalOpen = true // Open the stretches modal
                        }) {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                
                 
                                Text("""
                                Mark restless areas of your body in red and relaxed areas in blue. Stretch the red areas, then overlay them with blue to relax. Your goal is to feel better, even if it doesn’t look perfect.
                                """)
                                    .font(.body)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                

                Spacer()

                // Done Button
                Button(action: {
                    stopAudioWithFadeOut()
                    navigateToTrackYourDay = true
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }

                // Navigation Link to Track Your Day
                NavigationLink(
                    destination: TraceYourDayView(),
                    isActive: $navigateToTrackYourDay
                ) {
                    EmptyView()
                }
                .padding(.bottom, 20)
            }

            // Stretches Modal
            if isStretchesModalOpen {
                ZStack {
                    // Dimmed Background
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isStretchesModalOpen = false
                        }

                    // Modal Content
                    VStack(spacing: 20) {
                        Text("Stretch Examples")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("""
                        • Neck Stretches: Gently tilt your head forward and backward.
                        • Shoulder Rolls: Rotate your shoulders forward and backward.
                        • Arm Circles: Extend your arms and make circular motions.
                        • Back Stretch: Reach forward and hold for a few seconds.
                        """)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding()

                        Button(action: {
                            isStretchesModalOpen = false
                        }) {
                            Text("Close")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(20)
                    .frame(maxWidth: 300)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                }
            }
        }
        .onAppear {
            playAudioWithFadeIn()
        }
        .onDisappear {
            stopAudioWithFadeOut()
        }
    }

    //Audio Playback Methods

    /// Play the audio file with fade-in effect
    func playAudioWithFadeIn() {
        guard let path = Bundle.main.path(forResource: "angelic", ofType: "mp3") else {
            print("Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.volume = 0.0
            audioPlayer?.play()

            // Gradually increase the volume
            let fadeDuration = 2.0
            let fadeInterval = 0.1
            let fadeSteps = Int(fadeDuration / fadeInterval)
            var currentStep = 0

            Timer.scheduledTimer(withTimeInterval: fadeInterval, repeats: true) { timer in
                if currentStep >= fadeSteps {
                    timer.invalidate()
                } else {
                    audioPlayer?.volume += Float(1.0 / Float(fadeSteps))
                    currentStep += 1
                }
            }
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }

    /// Stop the audio playback with fade-out
    func stopAudioWithFadeOut() {
        guard let audioPlayer = audioPlayer else { return }

        // Gradually decrease the volume
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

            // Reduce volume gradually
            audioPlayer.volume -= Float(1.0 / Float(fadeSteps))
            currentStep += 1
        }
    }
}

// Supporting structs
struct ToolCircle: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(isSelected ? .white : .clear, lineWidth: 4) //outline
                )
        }
    }
}

struct DrawingPoint: Identifiable {
    let id = UUID()
    var location: CGPoint
    var color: Color
}

struct CelestialBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            GeometryReader { geometry in
                ForEach(0..<100, id: \.self) { _ in
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: CGFloat.random(in: 2...4), height: CGFloat.random(in: 2...4))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
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
