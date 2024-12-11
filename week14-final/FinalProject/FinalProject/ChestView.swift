//
//  ChestView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.


import SwiftUI
import FirebaseFirestore
import AVFoundation

struct ChestView: View {
    @State private var thoughts: String = ""
    @State private var isModalOpen: Bool = false
    @State private var navigateToJournalView3: Bool = false
    @State private var audioPlayer: AVAudioPlayer?

    private let db = Firestore.firestore()

    var body: some View {
        ZStack {
            // Background Image
            Image("chestv")
                .resizable()
                .scaledToFill()
                .offset(x: -20)
                .ignoresSafeArea()
                .onTapGesture {
                    isModalOpen = true
                }

            VStack(spacing: 20) {
                // Title
                Text("Get It Out")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)

                // Description
                Text("""
                Write a list of what’s on your mind in this chest. Pretend that once you write it down, it’s locked. No more thinking about it... for tonight at least.
                """)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 10)

                Spacer()

                // Invisible button to prevent interaction with the tap gesture
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 200)
                        .opacity(0)
                }
                .frame(height: 200)

                Spacer()

                // Action Buttons
                HStack(spacing: 20) {
                    // Skip Button
                    Button(action: {
                        stopAudioWithFadeOut()
                        navigateToJournalView3 = true 
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.8), lineWidth: 2))
                    }

                    // Submit Button
                    Button(action: {
                        saveThoughtsToFirebase()
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)

                // Navigation to JournalView3
                NavigationLink(
                    destination: JournalView3(),
                    isActive: $navigateToJournalView3
                ) {
                    EmptyView()
                }
            }

            // Modal for Thoughts
            if isModalOpen {
                ZStack {
                    // Dimmed Background
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isModalOpen = false
                        }

                    // Modal Content
                    VStack {
                        Text("What's on Your Mind?")
                            .font(.headline)
                            .foregroundColor(.white)

                        TextEditor(text: $thoughts)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .frame(height: 120)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)

                        Button(action: {
                            isModalOpen = false
                        }) {
                            Text("Done")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 10)
                        }
                    }
                    .padding()
                    .background(Color.orange.opacity(0.9))
                    .cornerRadius(20)
                    .frame(maxWidth: 300)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            playAudioWithFadeIn()
        }
        .onDisappear {
            stopAudioWithFadeOut()
        }
    }



    /// Play the audio file with fade-in effect
    func playAudioWithFadeIn() {
        guard let path = Bundle.main.path(forResource: "mars", ofType: "mp3") else {
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

    // Function to Save Thoughts to Firebase
    func saveThoughtsToFirebase() {
        let thoughtData: [String: Any] = [
            "date": Date(),
            "thoughts": thoughts
        ]

        db.collection("chestThoughts").addDocument(data: thoughtData) { error in
            if let error = error {
                print("Error saving thoughts: \(error.localizedDescription)")
            } else {
                print("Thoughts saved successfully.")
                stopAudioWithFadeOut()
                navigateToJournalView3 = true
            }
        }
    }
}

// Preview
struct ChestView_Previews: PreviewProvider {
    static var previews: some View {
        ChestView()
    }
}
