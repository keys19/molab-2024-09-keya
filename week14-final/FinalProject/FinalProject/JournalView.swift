
//
//  JournalView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import AVFoundation

struct JournalView: View {
    @State private var selectedPrompt: String = "Choose a prompt"
    @State private var reflectionText: String = ""
    @State private var navigateToBodyMapView = false
    @State private var errorMessage: String = ""
    @State private var audioPlayer: AVAudioPlayer?

    let prompts = [
        "What are you grateful for today?",
        "What made you smile today?",
        "What challenges did you overcome?",
        "What did you learn today?",
        "How can you make tomorrow even better?"
    ]

    var body: some View {
        ZStack {
          
            Image("jview1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                )

            ScrollView {
                VStack {
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("today.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("a successful day")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)

                    Spacer()

                    // Prompt Picker
                    VStack(alignment: .leading, spacing: 16) {
                        Picker("Choose a prompt", selection: $selectedPrompt) {
                            ForEach(prompts, id: \.self) { prompt in
                                Text(prompt)
                                    .foregroundColor(.white)
                                    .tag(prompt)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                                .background(Color.white.opacity(0.1).cornerRadius(10))
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .padding(.top, 120)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)

                    // Reflection Text Editor
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Reflection:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading, 8)

                        TextEditor(text: $reflectionText)
                            .frame(height: 150)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                                    .background(Color.white.opacity(0.1).cornerRadius(10))
                            )
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .background(Color.black.opacity(0.2))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)

                    // Navigation Button
                    Button(action: {
                        stopAudio()
                        navigateToBodyMapView = true
                    }) {
                        NavigationLink(destination: RestlessBodyMapView(), isActive: $navigateToBodyMapView) {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 40)

                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            playAudio()
        }
        .onDisappear {
            stopAudio()
        }
    }

    //Audio Playback Methods

    /// Play the audio file
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "autumnsky", ofType: "mp3") else {
            print("Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }

    /// Stop the audio playback
    func stopAudio() {
//        audioPlayer?.stop()
//        audioPlayer = nil
        guard let audioPlayer = audioPlayer else { return }

  
            let fadeDuration = 2.0
            var timer: Timer?
            let fadeInterval = 0.1
            let fadeSteps = Int(fadeDuration / fadeInterval)
            var currentStep = 0

            timer = Timer.scheduledTimer(withTimeInterval: fadeInterval, repeats: true) { _ in
                if currentStep >= fadeSteps {
                    
                    audioPlayer.stop()
                    self.audioPlayer = nil
                    timer?.invalidate()
                    return
                }

               
                audioPlayer.volume -= Float(1.0 / Float(fadeSteps))
                currentStep += 1
            }
    }
}

// Preview
struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
